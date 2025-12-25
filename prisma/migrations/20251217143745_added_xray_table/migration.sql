-- AlterTable
ALTER TABLE "InformedConsent" ADD COLUMN     "periodontal" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "periodontalInitial" TEXT;

-- AlterTable
ALTER TABLE "Occlusion" ALTER COLUMN "molarClass" DROP NOT NULL,
ALTER COLUMN "molarClass" DROP DEFAULT,
ALTER COLUMN "molarClass" SET DATA TYPE TEXT;

-- CreateTable
CREATE TABLE "XrayTaken" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "panoramic" BOOLEAN NOT NULL DEFAULT false,
    "cephalometric" BOOLEAN NOT NULL DEFAULT false,
    "occlusal" BOOLEAN NOT NULL DEFAULT false,
    "others" TEXT,

    CONSTRAINT "XrayTaken_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "XrayTaken_dentalChartId_key" ON "XrayTaken"("dentalChartId");

-- AddForeignKey
ALTER TABLE "XrayTaken" ADD CONSTRAINT "XrayTaken_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;
