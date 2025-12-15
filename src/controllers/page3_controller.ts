import e, { Request, Response } from "express";
import { prisma } from "../config/prisma";
import { extractFormData } from "../services/gemini.service";
import { prompt } from "../prompts/prompt3Loaded";

export const uploadPage3Form = async (req: Request, res: Response) => {
  const { recordId } = req.params;

  const file = (req as any).file;

  if (!recordId) {
    return res.status(400).json({ error: "Create dental record first" });
  }

  if (!file) {
    return res.status(400).json({ error: "No file uploaded" });
  }

  try {
    const extractedData = await extractFormData(
      file.buffer,
      file.mimetype,
      prompt
    );

    await prisma.informedConsent.upsert({
      where: { dentalRecordId: recordId },
      update: {
        treatment: extractedData.treatment.acknowledged,
        treatmentInitial: extractedData.treatment.initial,

        drugsMedication: extractedData.drugsMedication.acknowledged,
        drugsMedicationInitial: extractedData.drugsMedication.initial,

        changesInPlan: extractedData.changesInPlan.acknowledged,
        changesInPlanInitial: extractedData.changesInPlan.initial,

        radiograph: extractedData.radiograph.acknowledged,
        radiographInitial: extractedData.radiograph.initial,

        removalOfTeeth: extractedData.removalOfTeeth.acknowledged,
        removalOfTeethInitial: extractedData.removalOfTeeth.initial,

        crownsBridges: extractedData.crownsBridges.acknowledged,
        crownsBridgesInitial: extractedData.crownsBridges.initial,

        endodontics: extractedData.endodontics.acknowledged,
        endodonticsInitial: extractedData.endodontics.initial,

        fillings: extractedData.fillings.acknowledged,
        fillingsInitial: extractedData.fillings.initial,

        dentures: extractedData.dentures.acknowledged,
        denturesInitial: extractedData.dentures.initial,

        patientSignature: extractedData.patientSignature,
        dentistSignature: extractedData.dentistSignature,

        signedDate: extractedData.date ? new Date(extractedData.date) : null,
      },
      create: {
        dentalRecordId: recordId,

        treatment: extractedData.treatment.acknowledged,
        treatmentInitial: extractedData.treatment.initial,

        drugsMedication: extractedData.drugsMedication.acknowledged,
        drugsMedicationInitial: extractedData.drugsMedication.initial,

        changesInPlan: extractedData.changesInPlan.acknowledged,
        changesInPlanInitial: extractedData.changesInPlan.initial,

        radiograph: extractedData.radiograph.acknowledged,
        radiographInitial: extractedData.radiograph.initial,

        removalOfTeeth: extractedData.removalOfTeeth.acknowledged,
        removalOfTeethInitial: extractedData.removalOfTeeth.initial,

        crownsBridges: extractedData.crownsBridges.acknowledged,
        crownsBridgesInitial: extractedData.crownsBridges.initial,

        endodontics: extractedData.endodontics.acknowledged,
        endodonticsInitial: extractedData.endodontics.initial,

        fillings: extractedData.fillings.acknowledged,
        fillingsInitial: extractedData.fillings.initial,

        dentures: extractedData.dentures.acknowledged,
        denturesInitial: extractedData.dentures.initial,

        patientSignature: extractedData.patientSignature,
        dentistSignature: extractedData.dentistSignature,
        signedDate: extractedData.date ? new Date(extractedData.date) : null,
      },
    });

    return res.json({
      sucess: true,
      dentalRecordId: recordId,
    });
  } catch (error: any) {
    console.error(error);
    return res
      .status(500)
      .json({ error: "Failed to process page 3", detail: error.message });
  }
};
