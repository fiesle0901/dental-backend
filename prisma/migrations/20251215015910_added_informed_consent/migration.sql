-- CreateTable
CREATE TABLE "InformedConsent" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "treatment" BOOLEAN NOT NULL DEFAULT false,
    "treatmentInitial" TEXT,
    "drugsMedication" BOOLEAN NOT NULL DEFAULT false,
    "drugsMedicationInitial" TEXT,
    "changesInPlan" BOOLEAN NOT NULL DEFAULT false,
    "changesInPlanInitial" TEXT,
    "radiograph" BOOLEAN NOT NULL DEFAULT false,
    "radiographInitial" TEXT,
    "removalOfTeeth" BOOLEAN NOT NULL DEFAULT false,
    "removalOfTeethInitial" TEXT,
    "crownsBridges" BOOLEAN NOT NULL DEFAULT false,
    "crownsBridgesInitial" TEXT,
    "endodontics" BOOLEAN NOT NULL DEFAULT false,
    "endodonticsInitial" TEXT,
    "fillings" BOOLEAN NOT NULL DEFAULT false,
    "fillingsInitial" TEXT,
    "dentures" BOOLEAN NOT NULL DEFAULT false,
    "denturesInitial" TEXT,
    "patientSignature" TEXT,
    "dentistSignature" TEXT,
    "signedDate" TIMESTAMP(3),

    CONSTRAINT "InformedConsent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "InformedConsent_dentalChartId_key" ON "InformedConsent"("dentalChartId");

-- AddForeignKey
ALTER TABLE "InformedConsent" ADD CONSTRAINT "InformedConsent_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;
