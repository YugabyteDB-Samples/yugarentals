import "./App.scss";
import { useEffect, useRef, useState } from "react";
import Table from "./components/Table";
import { Button, CircularProgress } from "@mui/material";

function App() {
  async function getData(url = "") {
    const response = await fetch(`${url}`, {
      method: "GET",
      mode: "cors", // no-cors, *cors, same-origin
      cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "same-origin", // include, *same-origin, omit
    });
    return response;
  }
  async function postData(url = "", data = {}) {
    // Default options are marked with *
    const response = await fetch(`${url}`, {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "same-origin", // include, *same-origin, omit
      headers: {
        "Content-Type": "application/json",
        // 'Content-Type': 'application/x-www-form-urlencoded',
      },
      redirect: "follow", // manual, *follow, error
      referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
      body: JSON.stringify(data), // body data type must match "Content-Type" header
    });
    return response.json(); // parses JSON response into native JavaScript objects
  }
  async function handleUpdateSimulating() {
    const json = await postData("/refresh", {});
    const data = await json?.simulating;
    updateIsSimulating(data);
  }
  const [salesByFilmCategory, setSalesByFilmCategory] = useState();
  const [isViewLoading, setIsViewLoading] = useState(false);
  const [recentRentals, setRecentRentals] = useState();
  const [isSimulating, updateIsSimulating] = useState(false);
  const [dataUpdateTimer, setDataUpdateTimer] = useState();
  let savedCallback = useRef(function () {
    if (isSimulating) setDataUpdateTimer(Date.now());
  });
  const updateSavedCallback = function () {
    savedCallback.current = function () {
      if (isSimulating) setDataUpdateTimer(Date.now());
    };
  };
  useEffect(() => {
    async function getSimStatus() {
      try {
        const status = await getData("/status");
        const json = await status.json();
        const data = json?.simulating;
        updateIsSimulating(data);
      } catch (e) {
        console.log(`Error in fetching /status: ${e}`);
      }
    }

    getSimStatus();

    updateSavedCallback();
    let id = setInterval(savedCallback.current, 5000);
    return () => clearInterval(id);
  }, [isSimulating]);

  useEffect(() => {
    async function getSalesByFilmCategory() {
      try {
        if (!isViewLoading) {
          setIsViewLoading(true);
          const salesByFilmCategory = await getData("/salesByFilmCategory");
          const json = await salesByFilmCategory.json();
          console.log(json);
          const data = json?.data;
          console.log(data);
          setSalesByFilmCategory(data);
          setIsViewLoading(false);
        }
      } catch (e) {
        console.log(`Error in fetching /salesByFilmCategory: ${e}`);
      }
    }

    async function getRecentRentals() {
      try {
        const recentRentals = await getData("/recentRentals");
        const json = await recentRentals.json();
        console.log(json);
        const data = json?.data;
        console.log(data);
        setRecentRentals(data);
      } catch (e) {
        console.log(`Error in fetching /recentRentals: ${e}`);
      }
    }
    getSalesByFilmCategory();
    getRecentRentals();
  }, [dataUpdateTimer]);

  return (
    <div className="App">
      <div className="header">
        <h1>
          <i>YugaRentals</i>
          <img src={process.env.PUBLIC_URL + "/movie.png"} width="50" />
        </h1>
        <Button
          variant="outlined"
          onClick={handleUpdateSimulating}
          // disabled={isSimulating}
        >
          {!isSimulating ? (
            "Simulate"
          ) : (
            <span className="simulation" style={{ alignItems: "center" }}>
              Running Simulation <CircularProgress size={20} />
            </span>
          )}
        </Button>
      </div>
      <div className="app-container">
        <div className="table-wrapper">
          <h3>Recent Rentals</h3>
          <Table
            columns={[
              "Rental Date",
              "Film Title",
              "Customer First Name",
              "Customer Last Name",
            ]}
            rows={recentRentals}
            dataKeys={[
              "rentalDate",
              "filmTitle",
              "customerFirstName",
              "customerLastName",
            ]}
            tableStyles={{ width: 800, minWidth: 0 }}
          ></Table>
        </div>
        <div className="table-wrapper">
          <h3>
            Sales by Category{" "}
            <span>
              {isViewLoading && !salesByFilmCategory && (
                <CircularProgress size={20} />
              )}
            </span>
          </h3>
          <Table
            columns={["Film Category", "Total Sales"]}
            rows={salesByFilmCategory}
            dataKeys={["category", "count"]}
            tableStyles={{ width: 300, minWidth: 0 }}
          ></Table>
        </div>
      </div>
    </div>
  );
}

export default App;
