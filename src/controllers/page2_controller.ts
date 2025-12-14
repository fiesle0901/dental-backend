import { Request, Response } from "express";
import { prisma } from "../config/prisma";
import { extractFormData } from "../services/gemini.service";
import { prompt } from "../prompts/prompt2Loaded";

export const uploadPage2Form = async (req: Request, res: Response) => {
  const { patientId } = req.body;

  const file = (req as any).file;

  if (!patientId) {
    return res.status(400).json({ error: "Attach page 1 first" });
  }

  if (!file) {
    return res.status(400).json({ error: "No file uploaded" });
  }

  try {
    const chart = await prisma.dentalChart.upsert({
      where: { patientId },
      update: {},
      create: { patientId },
    });

    const extractedData = await extractFormData(
      file.buffer,
      file.mimetype,
      prompt
    );

    await prisma.$transaction(async (tx) => {
      if (Array.isArray(extractedData.ToothFinding)) {
        for (const tooth of extractedData.ToothFinding) {
          const tf = await tx.toothFinding.upsert({
            where: {
              dentalChartId_toothNumber: {
                dentalChartId: chart.id,
                toothNumber: tooth.toothNumber,
              },
            },
            update: {
              condition: tooth.condition ?? null,
            },
            create: {
              dentalChartId: chart.id,
              toothNumber: tooth.toothNumber,
              condition: tooth.condition ?? null,
            },
          });

          await tx.toothRestoration.deleteMany({
            where: { toothId: tf.id },
          });

          if (tooth.restorations?.length) {
            await tx.toothRestoration.createMany({
              data: tooth.restorations.map((r: string) => ({
                toothId: tf.id,
                type: r,
              })),
            });
          }

          await tx.toothSurgery.deleteMany({
            where: { toothId: tf.id },
          });

          if (tooth.surgeries?.length) {
            await tx.toothSurgery.createMany({
              data: tooth.surgeries.map((s: string) => ({
                toothId: tf.id,
                toothSurgery: s,
              })),
            });
          }
        }
      }

      if (extractedData.periodontal) {
        await tx.periodontalScreening.upsert({
          where: { dentalChartId: chart.id },
          update: extractedData.periodontal,
          create: { dentalChartId: chart.id, ...extractedData.periodontal },
        });
      }

      if (extractedData.occlusion) {
        await tx.occlusion.upsert({
          where: { dentalChartId: chart.id },
          update: extractedData.occlusion,
          create: { dentalChartId: chart.id, ...extractedData.occlusion },
        });
      }

      // 1–many
      if (extractedData.appliances) {
        await tx.appliances.deleteMany({
          where: { dentalChartId: chart.id },
        });

        await tx.appliances.create({
          data: {
            ...extractedData.appliances,
            form: { connect: { id: chart.id } },
          },
        });
      }

      if (extractedData.tmd) {
        await tx.tmd.deleteMany({
          where: { dentalChartId: chart.id },
        });

        await tx.tmd.create({
          data: {
            ...extractedData.tmd,
            form: { connect: { id: chart.id } },
          },
        });
      }
    });

    return res.json({
      success: true,
      dentalChartId: chart.id,
    });
  } catch (error: any) {
    console.error(error);
    return res.status(500).json({
      error: "Failed to process page 2",
      detail: error.message,
    });
  }
};
