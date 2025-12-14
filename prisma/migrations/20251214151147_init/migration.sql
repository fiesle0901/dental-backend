-- CreateEnum
CREATE TYPE "Sex" AS ENUM ('M', 'F');

-- CreateEnum
CREATE TYPE "YesNo" AS ENUM ('Yes', 'No');

-- CreateEnum
CREATE TYPE "ToothCondition" AS ENUM ('PRESENT', 'DECAYED', 'MISSING_CARIES', 'MISSING_OTHER', 'IMPACTED', 'SUPERNUMERARY', 'ROOT_FRAGMENT', 'UNERUPTED');

-- CreateEnum
CREATE TYPE "RestorationType" AS ENUM ('AM', 'CO', 'JC', 'AB', 'ATT', 'P', 'IN', 'IMP', 'S', 'RM');

-- CreateEnum
CREATE TYPE "SurgeryType" AS ENUM ('EXTRACTION_CARIES', 'EXTRACTION_OTHER');

-- CreateTable
CREATE TABLE "Patient" (
    "id" TEXT NOT NULL,
    "lastName" TEXT,
    "firstName" TEXT,
    "middleName" TEXT,
    "birthdate" TIMESTAMP(3),
    "age" INTEGER,
    "sex" "Sex",
    "religion" TEXT,
    "nickname" TEXT,
    "homeAddress" TEXT,
    "homeNo" TEXT,
    "occupation" TEXT,
    "officeNo" TEXT,
    "dentalInsurance" TEXT,
    "faxNo" TEXT,
    "effectiveDate" TIMESTAMP(3),
    "cellMobileNo" TEXT,
    "emailAddress" TEXT,
    "parentGuardianName" TEXT,
    "parentOccupation" TEXT,
    "referredBy" TEXT,
    "consultationReason" TEXT,

    CONSTRAINT "Patient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DentalHistory" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "previousDentist" TEXT,
    "lastDentalVisit" TEXT,

    CONSTRAINT "DentalHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalHistory" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "physicianName" TEXT,
    "physicianAddress" TEXT,
    "physicianSpecialty" TEXT,
    "physicianOfficeNumber" TEXT,
    "goodHealth" "YesNo",
    "underMedicalTreatment" "YesNo",
    "medicalConditionBeingTreated" TEXT,
    "seriousIllnessSurgery" "YesNo",
    "illnessOrOperationDetails" TEXT,
    "hospitalized" "YesNo",
    "hospitalizationDetails" TEXT,
    "takingMedication" "YesNo",
    "medicationDetails" TEXT,
    "useTobacco" "YesNo",
    "useAlcoholDrugs" "YesNo",
    "bleedingTime" TEXT,
    "bloodType" TEXT,
    "bloodPressure" TEXT,

    CONSTRAINT "MedicalHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalAllergies" (
    "id" TEXT NOT NULL,
    "medicalHistoryId" TEXT NOT NULL,
    "localAnesthetic" "YesNo",
    "penicillin" "YesNo",
    "antibiotics" "YesNo",
    "sulfaDrugs" "YesNo",
    "aspirin" "YesNo",
    "latex" "YesNo",
    "others" TEXT,

    CONSTRAINT "MedicalAllergies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ForWomenOnly" (
    "id" TEXT NOT NULL,
    "medicalHistoryId" TEXT NOT NULL,
    "pregnant" "YesNo",
    "nursing" "YesNo",
    "takingBirthControl" "YesNo",

    CONSTRAINT "ForWomenOnly_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalConditions" (
    "id" TEXT NOT NULL,
    "medicalHistoryId" TEXT NOT NULL,
    "highBloodPressure" BOOLEAN,
    "lowBloodPressure" BOOLEAN,
    "epilepsyConvulsions" BOOLEAN,
    "aidsHivInfection" BOOLEAN,
    "sexuallyTransmittedDisease" BOOLEAN,
    "stomachTroublesUlcers" BOOLEAN,
    "faintingSeizure" BOOLEAN,
    "rapidWeightLoss" BOOLEAN,
    "radiationTherapy" BOOLEAN,
    "jointReplacementImplant" BOOLEAN,
    "heartSurgery" BOOLEAN,
    "heartAttack" BOOLEAN,
    "thyroidProblem" BOOLEAN,
    "heartDisease" BOOLEAN,
    "heartMurmur" BOOLEAN,
    "hepatitisLiverDisease" BOOLEAN,
    "rheumaticFever" BOOLEAN,
    "hayFeverAllergies" BOOLEAN,
    "respiratoryProblems" BOOLEAN,
    "hepatitisJaundice" BOOLEAN,
    "tuberculosis" BOOLEAN,
    "swollenAnkles" BOOLEAN,
    "kidneyDisease" BOOLEAN,
    "diabetes" BOOLEAN,
    "chestPain" BOOLEAN,
    "stroke" BOOLEAN,
    "cancerTumors" BOOLEAN,
    "anemia" BOOLEAN,
    "angina" BOOLEAN,
    "asthma" BOOLEAN,
    "emphysema" BOOLEAN,
    "bleedingProblems" BOOLEAN,
    "bloodDiseases" BOOLEAN,
    "headInjuries" BOOLEAN,
    "arthritisRheumatism" BOOLEAN,
    "other" TEXT,

    CONSTRAINT "MedicalConditions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DentalChart" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,

    CONSTRAINT "DentalChart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ToothFinding" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "toothNumber" TEXT NOT NULL,
    "condition" "ToothCondition",

    CONSTRAINT "ToothFinding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ToothRestoration" (
    "id" TEXT NOT NULL,
    "toothId" TEXT NOT NULL,
    "type" "RestorationType" NOT NULL,

    CONSTRAINT "ToothRestoration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ToothSurgery" (
    "id" TEXT NOT NULL,
    "toothId" TEXT NOT NULL,
    "toothSurgery" "SurgeryType" NOT NULL,

    CONSTRAINT "ToothSurgery_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PeriodontalScreening" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "gingivitis" BOOLEAN NOT NULL DEFAULT false,
    "earlyPeriodontitis" BOOLEAN NOT NULL DEFAULT false,
    "moderatePeriodontitis" BOOLEAN NOT NULL DEFAULT false,
    "advancedPeriodontitis" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "PeriodontalScreening_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Occlusion" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "molarClass" BOOLEAN NOT NULL DEFAULT false,
    "overjet" BOOLEAN NOT NULL DEFAULT false,
    "overbite" BOOLEAN NOT NULL DEFAULT false,
    "midlineDeviation" BOOLEAN NOT NULL DEFAULT false,
    "crossbite" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Occlusion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Appliances" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "orthodontic" BOOLEAN NOT NULL DEFAULT false,
    "stayplate" BOOLEAN NOT NULL DEFAULT false,
    "others" TEXT,

    CONSTRAINT "Appliances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tmd" (
    "id" TEXT NOT NULL,
    "dentalChartId" TEXT NOT NULL,
    "clenching" BOOLEAN NOT NULL DEFAULT false,
    "clicking" BOOLEAN NOT NULL DEFAULT false,
    "trismus" BOOLEAN NOT NULL DEFAULT false,
    "muscleSpasm" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Tmd_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DentalHistory_patientId_key" ON "DentalHistory"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalHistory_patientId_key" ON "MedicalHistory"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalAllergies_medicalHistoryId_key" ON "MedicalAllergies"("medicalHistoryId");

-- CreateIndex
CREATE UNIQUE INDEX "ForWomenOnly_medicalHistoryId_key" ON "ForWomenOnly"("medicalHistoryId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalConditions_medicalHistoryId_key" ON "MedicalConditions"("medicalHistoryId");

-- CreateIndex
CREATE UNIQUE INDEX "DentalChart_patientId_key" ON "DentalChart"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "ToothFinding_dentalChartId_toothNumber_key" ON "ToothFinding"("dentalChartId", "toothNumber");

-- CreateIndex
CREATE UNIQUE INDEX "PeriodontalScreening_dentalChartId_key" ON "PeriodontalScreening"("dentalChartId");

-- CreateIndex
CREATE UNIQUE INDEX "Occlusion_dentalChartId_key" ON "Occlusion"("dentalChartId");

-- AddForeignKey
ALTER TABLE "DentalHistory" ADD CONSTRAINT "DentalHistory_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalHistory" ADD CONSTRAINT "MedicalHistory_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalAllergies" ADD CONSTRAINT "MedicalAllergies_medicalHistoryId_fkey" FOREIGN KEY ("medicalHistoryId") REFERENCES "MedicalHistory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ForWomenOnly" ADD CONSTRAINT "ForWomenOnly_medicalHistoryId_fkey" FOREIGN KEY ("medicalHistoryId") REFERENCES "MedicalHistory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalConditions" ADD CONSTRAINT "MedicalConditions_medicalHistoryId_fkey" FOREIGN KEY ("medicalHistoryId") REFERENCES "MedicalHistory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DentalChart" ADD CONSTRAINT "DentalChart_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ToothFinding" ADD CONSTRAINT "ToothFinding_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ToothRestoration" ADD CONSTRAINT "ToothRestoration_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES "ToothFinding"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ToothSurgery" ADD CONSTRAINT "ToothSurgery_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES "ToothFinding"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeriodontalScreening" ADD CONSTRAINT "PeriodontalScreening_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Occlusion" ADD CONSTRAINT "Occlusion_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appliances" ADD CONSTRAINT "Appliances_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tmd" ADD CONSTRAINT "Tmd_dentalChartId_fkey" FOREIGN KEY ("dentalChartId") REFERENCES "DentalChart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
