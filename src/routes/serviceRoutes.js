import { Router } from "express";
import { index } from "../controllers/serviceController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = Router();

router.get("/service", verifyToken, index);

export default router;