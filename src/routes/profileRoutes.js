import { Router } from "express";
import { body, validationResult } from "express-validator";
import { verifyToken } from "../middlewares/authMiddleware.js";
import { checkBalance, show, update, updateImage } from "../controllers/profileController.js";
import upload from "../middlewares/profileMiddleware.js";

const router = Router();

const validateRequest = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      status: 102,
      message: "Validation failed",
      errors: errors
        .array()
        .map((err) => err.msg)
        .toString(),
    });
  }
  next();
};

router.get("/profile", verifyToken, show);

router.put("/profile/update", [
  body("first_name").notEmpty().withMessage("First name kososng"),
  body("last_name").notEmpty().withMessage('Last name kosong')
], validateRequest, verifyToken, update);

router.put("/profile/image", verifyToken, upload.single("image"), updateImage);

router.get("/balance", verifyToken, checkBalance);

export default router;
