import { Request, Response } from "express";
import { prisma } from "../config/prisma";
import { extractFormData } from "../services/gemini.service";
import { prompt } from "../prompts/prompt4Loaded";
import { ensureRecordIsEditable } from "../utils/recordGuard";

export const uploadPage4Form = async (req: Request, res: Response) => {
  const { recordId } = req.params;

  const file = (req as any).file;

  if (!recordId) {
    return res.status(400).json({ error: "Create a dental record first" });
  }

  if (!file) {
    return res.status(400).json({ error: "No file uploaded" });
  }

  try {
    await ensureRecordIsEditable(recordId);
  } catch (error: any) {
    if (error.message === "RECORD_NOT_FOUND") {
      return res.status(404).json({ error: "Dental record not found" });
    }

    if (error.message === "RECORD_FINALIZED") {
      return res
        .status(404)
        .json({ error: "Cannot modify. Dental record is finalized" });
    }

    throw error;
  }

  try {
    const chart = await prisma.dentalChart.findUnique({
      where: { dentalRecordId: recordId },
    });

    if (!chart) {
      return res.status(400).json({ error: "No chartId found" });
    }

    const extractedData = await extractFormData(
      file.buffer,
      file.mimetype,
      prompt
    );

    await prisma.treatmentRecord.deleteMany({
      where: { dentalRecordId: recordId },
    });

    const createdRecords = await prisma.treatmentRecord.createMany({
      data: extractedData.treatmentRecord.map((row: any) => {
        const charged = Number(row.amountCharged) || 0;
        const paid = Number(row.amountPaid) || 0;

        return {
          dentalRecordId: recordId,
          date: row.date ? new Date(row.date) : null,
          toothQuantity: row.toothQuantity || null,
          procedure: row.procedure || null,
          dentist: row.dentist || null,
          amountCharged: charged,
          amountPaid: paid,
          balance: row.balance,
          nextAppointment: row.nextAppointment
            ? new Date(row.nextAppointment)
            : null,
        };
      }),
    });

    return res.json({
      success: true,
      dentalRecordId: recordId,
      extractedData,
    });
  } catch (error: any) {
    console.error(error);
    return res
      .status(500)
      .json({ error: "Failed to process page 4", detail: error.message });
  }
};
