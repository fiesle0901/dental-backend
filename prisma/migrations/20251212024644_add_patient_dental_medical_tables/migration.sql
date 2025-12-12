-- CreateEnum
CREATE TYPE "Sex" AS ENUM ('M', 'F');

-- CreateEnum
CREATE TYPE "YesNo" AS ENUM ('Yes', 'No');

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
    "previousDentist" TEXT NOT NULL,
    "lastDentalVisit" TEXT NOT NULL,

    CONSTRAINT "DentalHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalHistory" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "physicianName" TEXT NOT NULL,
    "physicianAddress" TEXT NOT NULL,
    "physicianSpecialty" TEXT NOT NULL,
    "physicianOfficeNumber" TEXT NOT NULL,
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
