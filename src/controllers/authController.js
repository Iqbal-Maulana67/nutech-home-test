import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { PrismaClient } from "../generated/prisma/client.ts";

dotenv.config();

const prisma = new PrismaClient();

const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || "12h";

export const register = async (request, response) => {
  try {
    const { first_name, last_name, email, password } = request.body;

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser)
      return response.status(400).json({ message: "Email sudah terdaftar" });

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: { first_name, last_name, email, password: hashedPassword },
    });

    response.status(200).json({
      status: 0,
      message: "Register berhasil silahkan login",
      data: {
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
      },
    });
  } catch (error) {
    console.log(error);

    response.status(500).json({
      message: "Error please try again",
    });
  }
};

export const login = async (request, response) => {
  const { email, password } = request.body;

  const existingUser = await prisma.user.findUnique({ where: { email } });
  if (!existingUser)
    return response
      .status("400")
      .json({ status: 101, message: "Email tidak ditemukan" });

  const isMatch = await bcrypt.compare(password, existingUser.password);

  if (!isMatch)
    return response
      .status(400)
      .json({ status: 103, message: "Username atau password salah" });

  const token = jwt.sign({ userId: existingUser.id }, JWT_SECRET, {
    expiresIn: JWT_EXPIRES_IN,
  });

  return response
    .status(200)
    .json({ status: 0, message: "Login sukses", data: { token: token } });
};
