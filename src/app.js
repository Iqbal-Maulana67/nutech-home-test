import express from "express";
import path from "path";
import dotenv from "dotenv";
import authRoutes from "./routes/authRoutes.js";
import profileRoutes from "./routes/profileRoutes.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.use("/public", express.static(path.resolve("src/public")));

app.use("/", authRoutes);
app.use("/", profileRoutes);

app.use((error, req, res, next) => {
  console.error("Error: ", error);
  res.status(500).json({
    message: error.message || "Internal server error",
  });
});

async function start() {
  try {
    app.listen(PORT, () => {
      console.log(`Server running on http:localhost:${PORT}`);
    });
    console.log("CWD:", process.cwd());
  } catch (err) {
    console.log("Failed to start:", err);
  }
}

start();
