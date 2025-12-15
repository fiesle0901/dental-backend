import { Request, Response } from "express";
import { prisma } from "../config/prisma";

export const createDentalRecord = async (_req: Request, res: Response) => {
  try {
    const record = await prisma.dentalRecord.create({
      data: {}, // patientId is null at first
    });

    return res.status(201).json({
      recordId: record.id,
    });
  } catch (error: any) {
    console.error(error);
    return res.status(500).json({
      error: "Failed to create dental record",
    });
  }
};
