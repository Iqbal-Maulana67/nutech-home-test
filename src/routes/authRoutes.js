import { Router } from "express";
import { body, validationResult } from "express-validator";
import { login, register } from "../controllers/authController.js";

const router = Router();

const validateRequest = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      status: 102,
      message: errors
        .array()
        .map((err) => err.msg)
        .toString(),
    });
  }
  next();
};

router.post(
  "/registration",
  [
    body("first_name").notEmpty().withMessage("First Name kosong"),
    body("last_name").notEmpty().withMessage("Last Name kosong"),
    body("email").isEmail().withMessage("Parameter email tidak sesuai format"),
    body("password")
      .isLength({ min: 8 })
      .withMessage("Panjang password minimal 8 karakter!"),
  ],
  validateRequest,
  register
);

router.post(
  "/login",
  [
    body("email").isEmail().withMessage("Parameter email tidak sesuai format"),
    body("password")
      .isLength({ min: 8 })
      .withMessage("Panjang password minimal 8 karakter!"),
  ],
  validateRequest,
  login
);


export default router;
