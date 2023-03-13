import * as React from "react";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { v4 as uuidv4 } from "uuid";
import { useAutoAnimate } from "@formkit/auto-animate/react";

export default function BasicTable({ columns, rows, dataKeys, tableStyles }) {
  const [animationParent] = useAutoAnimate();
  return (
    <div style={{ padding: "10px" }}>
      <TableContainer component={Paper}>
        <Table sx={{ ...tableStyles }} aria-label="simple table">
          <TableHead>
            <TableRow>
              {columns.map((col, i) => {
                return (
                  <TableCell key={col} align="left">
                    {col}
                  </TableCell>
                );
              })}
            </TableRow>
          </TableHead>
          <TableBody ref={animationParent}>
            {rows?.map((row) => {
              const rowKey = dataKeys.map((dataKey) => {
                return row?.[dataKey];
              });
              return (
                <TableRow
                  key={rowKey.join("-")}
                  sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                >
                  {dataKeys?.map((key) => {
                    let val = row?.[key];
                    if (typeof val === "number") {
                      val = parseFloat(val).toFixed(2);
                    }
                    return (
                      <TableCell align="left" key={uuidv4()}>
                        {val}
                      </TableCell>
                    );
                  })}
                </TableRow>
              );
            })}
          </TableBody>
        </Table>
      </TableContainer>
    </div>
  );
}
