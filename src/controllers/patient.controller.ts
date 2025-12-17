import { Request, Response } from "express";
import { prisma } from "../config/prisma";

export const getAllPatients = async (req: Request, res: Response) => {
  const patients = await prisma.patient.findMany({
    select: {
      id: true,
      firstName: true,
      lastName: true,
    },
    orderBy: { lastName: "asc" },
  });

  const allPatients = patients.map((p) => ({
    id: p.id,
    fullName: [p.firstName, p.lastName].filter(Boolean).join(" "),
  }));

  res.json(allPatients);
};

export const getPatient = async (req: Request, res: Response) => {
  const { patientId } = req.params;

  if (!patientId) {
    return res.status(400).json({ error: "Missing patientId" });
  }

  const patient = await prisma.patient.findUnique({
    where: { id: patientId },
    include: {
      dentalRecords: {
        select: {
          id: true,
          createdAt: true,
        },
        orderBy: { createdAt: "desc" },
      },
    },
  });

  if (!patient) {
    return res.status(404).json({ error: "Patient not found" });
  }

  res.json({
    patient: {
      id: patient.id,
      firstName: patient.firstName,
      lastName: patient.lastName,
      birthdate: patient.birthdate,
      sex: patient.sex,
    },
    records: patient.dentalRecords,
  });
};

export const deletePatient = async (req: Request, res: Response) => {
  const { patientId } = req.params;

  if (!patientId) {
    return res.status(400).json({ error: "Missing patientId" });
  }

  const recordCount = await prisma.dentalRecord.count({
    where: { patientId },
  });

  if (recordCount > 0) {
    return res.status(409).json({
      error: "Cannot delete patient with existing dental records",
    });
  }

  await prisma.patient.delete({
    where: { id: patientId },
  });

  res.json({ success: true });
};
