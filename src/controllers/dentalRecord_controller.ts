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

export const getDentalRecord = async (req: Request, res: Response) => {
  const { recordId } = req.params;

  if (!recordId) {
    return res.status(400).json({ error: "Missing recordId" });
  }

  const record = await prisma.dentalRecord.findUnique({
    where: { id: recordId },
    include: {
      patient: true,
      patientSnapshot: true,
      dentalHistory: true,
      medicalHistory: {
        include: {
          allergies: true,
          medicalConditions: true,
          forWomenOnly: true,
        },
      },
      dentalChart: {
        include: {
          teeth: {
            include: {
              restorations: true,
              surgeries: true,
            },
          },
          periodontal: true,
          occlusion: true,
          appliances: true,
          tmd: true,
        },
      },
      informedConsent: true,
      treatmentRecords: true,
    },
  });

  if (!record) {
    return res.status(404).json({ error: "Record not found" });
  }

  res.json(record);
};

export const deleteDentalRecord = async (req: Request, res: Response) => {
  const { recordId } = req.params;

  if (!recordId) {
    return res.status(400).json({ error: "Missing recordId" });
  }

  await prisma.dentalRecord.delete({
    where: { id: recordId },
  });

  res.json({ success: true });
};
