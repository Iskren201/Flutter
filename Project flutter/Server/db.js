const { Client } = require("pg");

const client = new Client({
  host: "localhost",
  user: "postgres",
  port: 5432,
  password: "test123",
  database: "postgres",
  synchronize: true,
  entities: ["src/entity/**/*.ts"],
  migrations: ["src/migrations/**/*.ts"],
  cli: {
    migrationsDir: "./Migration",
  },
});

client.connect();

module.exports = client;
