import e, { Request, Response } from "express";
import { prisma } from "../config/prisma";
import { extractFormData } from "../services/gemini.service";
import { prompt } from "../prompts/prompt3Loaded";

export const uploadPage3Form = async (req: Request, res: Response) => {
  const { patientId } = req.body;

  const file = (req as any).file;

  if (!patientId) {
    return res.status(400).json({ error: "Attach page 1 and 2 first" });
  }

  if (!file) {
    return res.status(400).json({ error: "No file uploaded" });
  }

  try {
    const chart = await prisma.dentalChart.findUnique({
      where: {
        patientId,
      },
    });

    if (!chart) {
      return res.status(400).json({ error: "No chartId found!" });
    }

    const extractedData = await extractFormData(
      file.buffer,
      file.mimetype,
      prompt
    );

    await prisma.informedConsent.upsert({
      where: { dentalChartId: chart.id },
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
        dentalChartId: chart.id,

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
      dentalChartId: chart.id,
    });
  } catch (error: any) {
    console.error(error);
    return res
      .status(500)
      .json({ error: "Failed to process page 2", detail: error.message });
  }
};
