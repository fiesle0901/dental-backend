import { config } from "dotenv";
config();

import express, { Express } from "express";
import dentalRecordRoutes from "./routes/dentalRecord.routes";

const app: Express = express();

const PORT = process.env.PORT || 5002;

app.use(express.json());

app.use("/api/dental-records", dentalRecordRoutes);

app.get("/", (req, res) => {
  res.json("Hello!");
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
