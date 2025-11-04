import { Router } from "express";
import { index } from "../controllers/bannerController.js";

const router = Router();

router.get("/banner", index);

export default router;
