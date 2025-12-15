import { Request, Response } from "express";
import { extractFormData } from "../services/gemini.service";
import { prompt } from "../prompts/prompt1Loaded";

import { prisma } from "../config/prisma";

export const uploadPage1Form = async (req: Request, res: Response) => {
  const file = (req as any).file;
  const { recordId } = req.params;

  if (typeof recordId !== "string") {
    return res.status(400).json({ error: "Invalid recordId" });
  }

  if (!file) {
    return res.status(400).json({ error: "No file uploaded" });
  }

  if (!recordId) {
    return res.status(400).json({ error: "Missing dental record ID" });
  }

  try {
    const extractedData = await extractFormData(
      file.buffer,
      file.mimetype,
      prompt
    );

    const { patient, dentalHistory, medicalHistory } = extractedData;

    const birthdate = toISO(patient?.birthdate);

    await prisma.$transaction(async (tx) => {
      // find or create patient

      let existingPatient = await tx.patient.findFirst({
        where: {
          firstName: patient?.firstName,
          lastName: patient?.lastName,
          birthdate,
        },
      });

      // create patient if it doesn't exists
      if (!existingPatient) {
        existingPatient = await tx.patient.create({
          data: {
            firstName: patient?.firstName,
            lastName: patient?.lastName,
            birthdate,
            sex: patient?.sex,
          },
        });
      }

      // attach patient to DentalRecord
      await tx.dentalRecord.update({
        where: { id: recordId },
        data: { patientId: existingPatient.id },
      });

      await tx.patientSnapshot.create({
        data: {
          dentalRecordId: recordId,
          firstName: patient?.firstName,
          lastName: patient?.lastName,
          middleName: patient?.middleName,
          birthdate,
          sex: patient?.sex,
          nationality: patient?.nationality,
          religion: patient?.religion,
          nickname: patient?.nickname,
          homeAddress: patient?.homeAddress,
          homeNo: patient?.homeNo,
          occupation: patient?.occupation,
          officeNo: patient?.officeNo,
          dentalInsurance: patient?.dentalInsurance,
          faxNo: patient?.faxNo,
          effectiveDate: toISO(patient?.effectiveDate),
          cellMobileNo: patient?.cellMobileNo,
          emailAddress: patient?.emailAddress,
          parentGuardianName: patient?.parentGuardianName,
          parentOccupation: patient?.parentOccupation,
          referredBy: patient?.referredBy,
          consultationReason: patient?.consultationReason,
        },
      });

      if (dentalHistory) {
        await tx.dentalHistory.create({
          data: {
            dentalRecordId: recordId,
            ...dentalHistory,
          },
        });
      }

      if (medicalHistory) {
        await tx.medicalHistory.create({
          data: {
            dentalRecordId: recordId,
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
        });
      }
    });

    return res.json({ success: true, patientId: recordId });
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
