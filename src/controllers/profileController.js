import { request, response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import multer from "multer";
import path from "path";

import { PrismaClient } from "../generated/prisma/client.ts";

dotenv.config();

const prisma = new PrismaClient();

const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || "12h";

export const show = async (req, res) => {
  const user = req.user;

  if (!user)
    return res
      .status(400)
      .json({ status: 102, message: "User tidak ditemukan" });

  const existingUser = await prisma.user.findUnique({
    where: { id: user.userId },
  });

  res.status(200).json({
    status: 0,
    message: "Sukses",
    data: {
      email: existingUser.email,
      first_name: existingUser.first_name,
      last_name: existingUser.last_name,
      profile_image: existingUser.profile_image,
    },
  });
};

export const update = async (req, res) => {
  try {
    const { first_name, last_name } = req.body;
    const user = req.user;

    if (!user)
      return res
        .status(400)
        .json({ status: 102, message: "User tidak ditemukan" });

    const existingUser = await prisma.user.findUnique({
      where: { id: user.userId },
    });

    if (!existingUser)
      return res
        .status(400)
        .json({ status: 102, message: "Error please try again!" });

    const updatedUser = await prisma.user.update({
      where: {
        id: user.userId,
      },
      data: {
        first_name: first_name,
        last_name: last_name,
      },
    });

    res.status(200).json({
      status: 0,
      message: "Update profile berhasil!",
      data: { updatedUser },
    });
  } catch (error) {
    response.status(500).json({
      message: "Error please try again",
    });
  }
};

export const updateImage = async (req, res) => {
  try {
    if (req.fileValidationError) {
      return res.status(400).json({
        status: 102,
        message: req.fileValidationError,
      });
    }

    if (!req.file) {
      return res.status(400).json({ message: "Tidak ada file yang diupload" });
    }

    const user = req.user;

    if (!user)
      return res
        .status(400)
        .json({ status: 102, message: "User tidak ditemukan" });

    const existingUser = await prisma.user.findUnique({
      where: { id: user.userId },
    });

    if (!existingUser)
      return res
        .status(400)
        .json({ status: 102, message: "Error please try again" });

    const fileUrl = `${req.protocol}://${req.get(
      "host"
    )}/public/images/profiles/${req.file.filename}`;

    res.status(200).json({
      status: 0,
      message: "Update profile image berhasil",
      data: {
        email: existingUser.email,
        first_name: existingUser.first_name,
        last_name: existingUser.last_name,
        profile_image: fileUrl,
      },
    });
  } catch (error) {
    res.status(500).json({ message: "Error please try again" });
  }
};

export const checkBalance = async (request, response) => {
  try {
    const user = request.user;

    if (!user)
      return response
        .status(400)
        .json({ status: 102, message: "User tidak ditemukan" });

    const existingUser = await prisma.user.findUnique({
      where: { id: user.userId },
    });

    if (!existingUser)
      return response
        .status(400)
        .json({ status: 102, message: "Error please try again" });

    response
      .status(200)
      .json({
        status: 0,
        message: "Get Balance Berhasil!",
        data: { balance: existingUser.balance },
      });
  } catch (error) {
      res.status(500).json({ message: "Error please try again" });
  }
};
