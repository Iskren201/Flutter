import express from "express";
import { createConnection } from "typeorm";
import { User } from "./entity/User";

const app = express();
const port = 3000;

app.use(express.json());

createConnection()
  .then(async () => {
    console.log("Connected to the database");
  })
  .catch((error) => {
    console.error("Error connecting to the database:", error);
  });

app.post("/register", async (req, res) => {
  // Registration logic here
});

// Example login endpoint
app.post("/login", async (req, res) => {
  // Login logic here
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
