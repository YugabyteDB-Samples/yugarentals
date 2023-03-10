require("dotenv").config();
const date = require("date-and-time");
const fs = require("fs");
const express = require("express");
const cors = require("cors");
const App = express();
App.use(express.json());
App.use(cors());
const { Pool } = require("@yugabytedb/pg");
const {
    DB_TYPE,
    DB_HOST,
    DB_USER,
    DB_PASSWORD,
    DB_CONNECTION_STRING,
    DB_NAME,
    ORACLE_CLIENT_LIB_PATH
} = process.env;
let oracledb;
if (DB_TYPE === "oracle") {
    oracledb = require("oracledb");
    oracledb.initOracleClient({
        libDir: process.env.ORACLE_CLIENT_LIB_PATH,
    });
}
const QueryFactory = require("./QueryFactory");

let connection;

const status = {
    simulating: false,
};
function executeQuery(query, dbType = "yugabyte", options, queryArgs) {
    if (dbType === "oracle") {
        console.log("execute query for oracle");
        return connection.execute(query, (queryArgs = []), (options = {}));
    } else {
        return connection.query(query, (queryArgs = []));
    }
}
async function run() {
    try {
        if (DB_TYPE === "oracle") {
            connection = await oracledb.getConnection({
                user: DB_USER,
                password: DB_PASSWORD,
                connectionString: DB_CONNECTION_STRING,
            });

            console.log("Successfully connected to Oracle Database");
        } else {
            let config = {
                user: DB_USER,
                host: DB_HOST,
                password: DB_PASSWORD,
                port: 5433,
                database: DB_NAME,
                min: 5,
                max: 10,
                idleTimeoutMillis: 5000,
                connectionTimeoutMillis: 5000,
            };
            //won't work in Docker
            if (process.env.DB_DEPLOYMENT_TYPE === "docker") {
                connection = new Pool(config);
            } else {
                config["ssl"] = {
                    rejectUnauthorized: true,
                    ca: fs.readFileSync("./root.crt").toString(),
                    servername: DB_HOST,
                };

                connection = new Pool(config);
            }
            connection.on("connect", (c) => {
                c.query("SET search_path to admin");
            });

            connection.on("error", (e) => {
                console.log("connection error: ", e);
            });
            await connection.query("SELECT 1 = 1");
            console.log("Successfully connected to YugabyteDB");
        }
    } catch (err) {
        console.error(err);
    }
}

run();

// `select r.rental_date, f.title, c.first_name, c.last_name
//         FROM rental r, customer c, inventory i, film f
//         WHERE r.customer_id = c.customer_id
//         AND r.inventory_id = i.inventory_id
//         AND i.film_id = f.film_id
//         ORDER BY r.rental_date DESC
//         LIMIT 20`,
App.get("/recentRentals", async (req, res) => {
    try {
        let data = await executeQuery(
            DB_TYPE === "oracle"
                ? QueryFactory.oracle.getRecentRentals
                : QueryFactory.yugabyte.getRecentRentals,
            //         select * from (select * rental limit 5) as r inner join customer c on c.customer_id = r.customer_id inner join inventory i on r.inventory_id = i.inventory_id inner join film f on f.film_id =
            // i.film_id limit 20;
            DB_TYPE
        );

        data = data?.rows.map((d) => {
            if (DB_TYPE === "oracle") {
                return {
                    rentalDate: d[0],
                    filmTitle: d[1],
                    customerFirstName: d[2],
                    customerLastName: d[3],
                };
            }

            return {
                rentalDate: d.rental_date,
                filmTitle: d.title,
                customerFirstName: d.first_name,
                customerLastName: d.last_name,
            };
        });
        res.json({ data });
    } catch (e) {
        res.status(400).json({ status: e });
        console.log(e);
    }
});

App.get("/salesByFilmCategory", async (req, res) => {
    try {
        let salesByFilmCategory = await executeQuery(
            DB_TYPE === "oracle"
                ? QueryFactory.oracle.getSalesByFilmCategory
                : QueryFactory.yugabyte.getSalesByFilmCategory,
            DB_TYPE
        );

        salesByFilmCategory = salesByFilmCategory?.rows.map((d) => {
            if (DB_TYPE === "oracle") return { category: d[0], count: d[1] };

            return { category: d.category, count: d.total_sales };
        });
        res.json({ data: salesByFilmCategory });
    } catch (e) {
        res.status(400).json({ status: e });
        console.log(e);
    }
});

App.get("/status", async (req, res) => {
    try {
        res.json(status);
    } catch (e) {
        res.status(400).json({ status: e });
        console.log(e);
    }
});

let materializedViewInterval = null;
let rentFilmInterval = null;
let materializedViewUpdated = true;
async function handleMaterializedView() {
    if (!materializedViewInterval) {
        materializedViewInterval = setInterval(async function () {
            if (materializedViewUpdated) {
                console.log("Refreshing Materialized View In Interval");
                materializedViewUpdated = false;
                await executeQuery(QueryFactory.yugabyte.refreshSalesByFilmCategory);
                materializedViewUpdated = true;
            }
        }, 5000);

        if (materializedViewUpdated) {
            console.log("Refreshing Materialized View");
            materializedViewUpdated = false;
            await executeQuery(QueryFactory.yugabyte.refreshSalesByFilmCategory);
            materializedViewUpdated = true;
        }
    }
}
async function handleSimulation() {
    try {
        if (DB_TYPE === "yugabyte") handleMaterializedView();

        if (!rentFilmInterval) {
            rentFilmInterval = setInterval(rentFilm, 1000);
        }
    } catch (e) {
        console.log("error in handling simulation", e);
    }
}

App.post("/refresh", async (req, res) => {
    try {
        status["simulating"] = !status["simulating"];
        if (status["simulating"]) {
            handleSimulation();
        } else {
            console.log("Clearing interval for Materialized View");
            clearInterval(materializedViewInterval);
            materializedViewInterval = null;
            clearInterval(rentFilmInterval);
            rentFilmInterval = null;
        }
        res.json(status);
    } catch (e) {
        res.status(400).json({ status: e });
        console.log(e);
    }
});

async function rentFilm() {
    try {
        const now = new Date();
        const customerId = Math.floor(Math.random() * 599 + 1);
        const inventoryId = Math.floor(Math.random() * 4581 + 1);
        const dateValue = date.format(now, "YYYY-MM-DD HH:mm:ss");

        var fiveDaysFromNow = new Date(
            new Date().getTime() + 5 * 24 * 60 * 60 * 1000
        );
        const fiveDaysFromNowValue = date.format(
            fiveDaysFromNow,
            "YYYY/MM/DD HH:mm:ss"
        );

        if (DB_TYPE === "oracle") {
            const values = {
                RENTAL_DATE: { val: now },
                INVENTORY_ID: { val: inventoryId },
                CUSTOMER_ID: { val: customerId },
                RETURN_DATE: { val: now },
                STAFF_ID: { val: 1 },
                ids: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT },
            };

            let result = await connection.execute(
                QueryFactory.oracle.createRental,
                values,
                {
                    autoCommit: true,
                }
            );

            const rentalId = result?.outBinds?.ids?.[0];

            const paymentValues = {
                customer_id: { val: customerId },
                staff_id: { val: 1 },
                rental_id: { val: rentalId },
                amount: { val: 5.99 },
                payment_date: { val: now },
            };

            await connection.execute(
                QueryFactory.oracle.createPayment,
                paymentValues,
                { autoCommit: true }
            );
        } else {
            const values = [now, inventoryId, customerId, now, 1];
            let result = await connection.query(
                QueryFactory.yugabyte.createRental,
                values
            );

            const rentalId = result?.rows?.[0]?.rental_id;

            const paymentValues = [customerId, 1, rentalId, 5.99, now];
            await connection.query(
                QueryFactory.yugabyte.createPayment,
                paymentValues
            );
        }
        return true;
    } catch (e) {
        console.log(`error in renting film: ${e}`);
    }
}
App.post("/insert", async (req, res) => {
    try {
        await rentFilm();
        res.json({ data: "Successfully inserted new rental" });
    } catch (e) {
        res.status(400).json({ status: e });
        console.log(e);
    }
});

App.use(express.static("../client/build"));

App.listen(8000, function () {
    console.log("App listening on port 8000");
});
