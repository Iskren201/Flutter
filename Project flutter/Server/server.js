const express = require("express");
const dbClient = require("./db");

const app = express();
const port = 3000;

app.use(express.json());

async function createUsersTable() {
  try {
    const checkQuery = `
      SELECT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_name = 'users'
      );
    `;
    const { rows } = await dbClient.query(checkQuery);
    const tableExists = rows[0].exists;

    if (!tableExists) {
      const createQuery = `
        CREATE TABLE users (
          id SERIAL PRIMARY KEY,
          username VARCHAR(255) UNIQUE NOT NULL,
          password VARCHAR(255) NOT NULL
        )
      `;
      await dbClient.query(createQuery);
      console.log("Users table created successfully");
    }
  } catch (error) {
    console.error("Error creating users table:", error);
    throw error;
  }
}

app.post("/login", async (req, res) => {
  try {
    await createUsersTable();

    const { username, password } = req.body;
    console.log("Received username:", username);
    console.log("Received password:", password);

    const query = "SELECT * FROM users WHERE username = $1 AND password = $2";
    const result = await dbClient.query(query, [username, password]);
    if (result.rows.length > 0) {
      res.json({ success: true });
    } else {
      res.status(404).json({
        success: false,
        error: "User not found or invalid credentials",
      });
    }
  } catch (error) {
    console.error("Error during login:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.post("/signup", async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username) {
      return res.status(400).json({ error: "Username cannot be empty" });
    }

    const checkQuery = "SELECT * FROM users WHERE username = $1";
    const checkResult = await dbClient.query(checkQuery, [username]);
    if (checkResult.rows.length > 0) {
      return res.status(400).json({ error: "Username already exists" });
    }

    const insertQuery =
      "INSERT INTO users (username, password) VALUES ($1, $2)";
    await dbClient.query(insertQuery, [username, password]);
    res.json({ success: true });
  } catch (error) {
    console.error("Error during signup:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.listen(port, async () => {
  try {
    await createUsersTable();
    console.log(`Server is running on http://localhost:${port}`);
  } catch (error) {
    console.error("Error starting server:", error);
    process.exit(1);
  }
});
