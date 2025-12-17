-- DropForeignKey
ALTER TABLE "Appliances" DROP CONSTRAINT "Appliances_dentalChartId_fkey";

-- DropForeignKey
ALTER TABLE "Occlusion" DROP CONSTRAINT "Occlusion_dentalChartId_fkey";

-- DropForeignKey
ALTER TABLE "PeriodontalScreening" DROP CONSTRAINT "PeriodontalScreening_dentalChartId_fkey";

-- DropForeignKey
ALTER TABLE "Tmd" DROP CONSTRAINT "Tmd_dentalChartId_fkey";

-- DropForeignKey
ALTER TABLE "ToothRestoration" DROP CONSTRAINT "ToothRestoration_toothId_fkey";

-- DropForeignKey
ALTER TABLE "ToothSurgery" DROP CONSTRAINT "ToothSurgery_toothId_fkey";

-- AddForeignKey
ALTER TABLE "ToothRestoration" ADD CONSTRAINT "ToothRestoration_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES "ToothFinding"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ToothSurgery" ADD CONSTRAINT "ToothSurgery_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES "ToothFinding"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeriodontalScreening" ADD CONSTRAINT "PeriodontalScreening_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Occlusion" ADD CONSTRAINT "Occlusion_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appliances" ADD CONSTRAINT "Appliances_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tmd" ADD CONSTRAINT "Tmd_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;
