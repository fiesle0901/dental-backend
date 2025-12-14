import { Request, Response } from "express";
import { extractFormData } from "../services/gemini.service";
import { prompt } from "../prompts/prompt1Loaded";

import { prisma } from "../config/prisma";

export const uploadPage1Form = async (req: Request, res: Response) => {
  const file = (req as any).file;

  if (!file) {
    return res.status(400).json({ error: "No file uploaded" });
  }

  try {
    const extractedData = await extractFormData(
      file.buffer,
      file.mimetype,
      prompt
    );

    const { patient, dentalHistory, medicalHistory } = extractedData;

    const mappedPatient = {
      ...patient,
      birthdate: toISO(patient.birthdate),
      effectiveDate: toISO(patient.effectiveDate),
      age: patient.age ? parseInt(patient.age) || null : null,
    };

    const saveForm = await prisma.$transaction((tx) =>
      tx.patient.create({
        data: {
          ...mappedPatient,
          dentalHistory: dentalHistory ? { create: dentalHistory } : undefined,
          medicalHistory: medicalHistory
            ? {
                create: {
                  ...medicalHistory,
                  allergies: medicalHistory.allergies
                    ? { create: medicalHistory.allergies }
                    : undefined,
                  medicalConditions: medicalHistory.medicalConditions
                    ? { create: medicalHistory.medicalConditions }
                    : undefined,
                  forWomenOnly: medicalHistory.forWomenOnly
                    ? { create: medicalHistory.forWomenOnly }
                    : undefined,
                },
              }
            : undefined,
        },
      })
    );

    return res.json({ success: true, patientId: saveForm.id });
  } catch (error: any) {
    console.error(error);
    return res.status(500).json({
      error: "Failed to process page 1",
      detail: error.message,
    });
  }
};

function toISO(value: any): string | null {
  if (!value) return null;
  const d = new Date(value);
  return isNaN(d.getTime()) ? null : d.toISOString();
}
