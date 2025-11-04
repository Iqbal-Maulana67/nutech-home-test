import { PrismaClient } from "../generated/prisma/client.ts";

const prisma = new PrismaClient();

function padNumber(num) {
  return num.toString().padStart(3, "0");
}

export const index = async (request, response) => {
  try {
    const data = await prisma.services.findMany();

    response.status(200).json({ status: 0, message: "Sukses", data });
  } catch (err) {
    console.log(err);
    response.status(500).json({ message: "Error please try again" });
  }
};

export const topupService = async (request, response) => {
  try {
    const { top_up_amount } = request.body;

    if (parseInt(top_up_amount) <= 0)
      return response.status(400).json({
        status: 102,
        message:
          "Paramter amount hanya boleh angka dan tidak boleh lebih kecil dari 0",
      });

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

    let balance = existingUser.balance + top_up_amount;

    const updatedBalance = await prisma.user.update({
      where: { id: user.userId },
      data: {
        balance: balance,
      },
    });

    console.log(updatedBalance.balance);

    response.status(200).json({
      status: 0,
      message: "Top Up Balance Berhasil",
      data: {
        balance: updatedBalance.balance,
      },
    });
  } catch (error) {
    console.log(error);
    response.status(500).json({
      message: "Error please try again",
    });
  }
};

export const transaction = async (req, res) => {
  try {
    const { service_code } = req.body;

    const services = await prisma.services.findUnique({
      where: { service_code: service_code },
    });

    if (!services)
      return res
        .status(400)
        .json({ status: 102, message: "Service atau layanan tidak ditemukan" });

    const user = await prisma.user.findUnique({
      where: { id: req.user.userId },
    });

    if (!user)
      return res
        .status(400)
        .json({ status: 102, message: "Error please try again!" });

    if (parseInt(user.balance) < parseInt(services.service_tariff))
      return res
        .status(400)
        .json({ status: "102", message: "Balance tidak cukup" });

    await prisma.user.update({
      where: { id: req.user.userId },
      data: {
        balance: parseInt(user.balance) - parseInt(services.service_tariff),
      },
    });

    const now = new Date();

    const day = String(now.getDate()).padStart(2, "0");
    const month = String(now.getMonth() + 1).padStart(2, "0");
    const year = now.getFullYear();

    const formattedDate = `${day}${month}${year}`;

    let invoiceFormat = `INV${formattedDate}-`;

    const transactionHistory = await prisma.history.findMany({
      orderBy: { created_on: "desc" },
      take: 1,
    });
    let invoiceNumber = parseInt(
      transactionHistory
        .map((history) => history.invoice_number)
        .toString()
        .split("-")[1]
    );

    if (transactionHistory <= 0) {
      invoiceFormat += "001";
    } else {
      const invoiceTotal =
        parseInt(
          transactionHistory
            .map((history) => history.invoice_number)
            .toString()
            .split("-")[1]
        ) + 1;
      invoiceFormat += padNumber(invoiceTotal);
    }

    console.log(invoiceFormat);

    const createdData = await prisma.history.create({
      data: {
        invoice_number: invoiceFormat,
        userId: req.user.userId,
        transaction_type: service_code,
        description: services.service_name,
        total_amount: services.service_tariff,
      },
    });

    res.status(200).json({
      message: "Sukses",
      services: services,
      data: createdData,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      message: "Error please try again",
    });
  }
};

export const transactionHistory = async (req, res) => {
  const offset = req.query.offset;
  const limit = req.query.limit;

  let data = await prisma.history.findMany({
    where: { userId: req.user.userId },
    skip: parseInt(offset),
    ...(limit && { take: parseInt(limit) }),
    orderBy: { created_on: "desc" },
  });

  if (!data.length) data = { status: 0, message: "Data kosong" };
  res.status(200).json({ data });
};
