import { PrismaClient } from "../generated/prisma/client.ts";

const prisma = new PrismaClient();

export const index = async (request, response) => {
  try {
    const data = await prisma.banner.findMany();

    response.status(200).json({ status: 0, message: "Sukses", data });
  } catch (err) {
    console.log(err);
    response.status(500).json({ message: "Error please try again" });
  }
};