import { Router } from "express";
import {
  index,
  topupService,
  transaction,
  transactionHistory,
} from "../controllers/serviceController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";
import { body, query, validationResult } from "express-validator";

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

router.get("/service", verifyToken, index);

router.post(
  "/topup",
  verifyToken,
  [
    body("top_up_amount")
      .notEmpty()
      .isNumeric()
      .withMessage("Parameter amount hanya boleh angka"),
  ],
  validateRequest,
  topupService
);

router.post(
  "/transaction",
  verifyToken,
  [body("service_code").notEmpty().withMessage("Service code kosong")],
  validateRequest,
  transaction
);

router.get(
  "/transaction/history",
  verifyToken,
  [
    query("offset")
      .isNumeric()
      .withMessage("Parameter offset hanya boleh angka"),
    query("limit").optional().isNumeric().withMessage("Parameter limit hanya boleh angka")
  ],
  validateRequest,
  transactionHistory
);
export default router;
