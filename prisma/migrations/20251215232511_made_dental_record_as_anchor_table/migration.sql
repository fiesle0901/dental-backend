/*
  Warnings:

  - You are about to drop the column `patientId` on the `DentalChart` table. All the data in the column will be lost.
  - You are about to drop the column `patientId` on the `DentalHistory` table. All the data in the column will be lost.
  - You are about to drop the column `dentalChartId` on the `InformedConsent` table. All the data in the column will be lost.
  - You are about to drop the column `patientId` on the `MedicalHistory` table. All the data in the column will be lost.
  - You are about to drop the column `age` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `cellMobileNo` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `consultationReason` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `dentalInsurance` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `effectiveDate` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `emailAddress` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `faxNo` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `homeAddress` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `homeNo` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `middleName` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `nickname` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `occupation` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `officeNo` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `parentGuardianName` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `parentOccupation` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `referredBy` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `religion` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `dentalChartId` on the `TreatmentRecord` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[dentalRecordId]` on the table `DentalChart` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[dentalRecordId]` on the table `DentalHistory` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[dentalRecordId]` on the table `InformedConsent` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[dentalRecordId]` on the table `MedicalHistory` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `dentalRecordId` to the `DentalChart` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dentalRecordId` to the `DentalHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dentalRecordId` to the `InformedConsent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `InformedConsent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dentalRecordId` to the `MedicalHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dentalRecordId` to the `TreatmentRecord` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "DentalChart" DROP CONSTRAINT "DentalChart_patientId_fkey";

-- DropForeignKey
ALTER TABLE "DentalHistory" DROP CONSTRAINT "DentalHistory_patientId_fkey";

-- DropForeignKey
ALTER TABLE "InformedConsent" DROP CONSTRAINT "InformedConsent_dentalChartId_fkey";

-- DropForeignKey
ALTER TABLE "MedicalHistory" DROP CONSTRAINT "MedicalHistory_patientId_fkey";

-- DropForeignKey
ALTER TABLE "TreatmentRecord" DROP CONSTRAINT "TreatmentRecord_dentalChartId_fkey";

-- DropIndex
DROP INDEX "DentalChart_patientId_key";

-- DropIndex
DROP INDEX "DentalHistory_patientId_key";

-- DropIndex
DROP INDEX "InformedConsent_dentalChartId_key";

-- DropIndex
DROP INDEX "MedicalHistory_patientId_key";

-- AlterTable
ALTER TABLE "DentalChart" DROP COLUMN "patientId",
ADD COLUMN     "dentalRecordId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "DentalHistory" DROP COLUMN "patientId",
ADD COLUMN     "dentalRecordId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "InformedConsent" DROP COLUMN "dentalChartId",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "dentalRecordId" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "MedicalHistory" DROP COLUMN "patientId",
ADD COLUMN     "dentalRecordId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Patient" DROP COLUMN "age",
DROP COLUMN "cellMobileNo",
DROP COLUMN "consultationReason",
DROP COLUMN "dentalInsurance",
DROP COLUMN "effectiveDate",
DROP COLUMN "emailAddress",
DROP COLUMN "faxNo",
DROP COLUMN "homeAddress",
DROP COLUMN "homeNo",
DROP COLUMN "middleName",
DROP COLUMN "nickname",
DROP COLUMN "occupation",
DROP COLUMN "officeNo",
DROP COLUMN "parentGuardianName",
DROP COLUMN "parentOccupation",
DROP COLUMN "referredBy",
DROP COLUMN "religion";

-- AlterTable
ALTER TABLE "TreatmentRecord" DROP COLUMN "dentalChartId",
ADD COLUMN     "dentalRecordId" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "DentalRecord" (
    "id" TEXT NOT NULL,
    "patientId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "page1Completed" BOOLEAN NOT NULL DEFAULT false,
    "page2Completed" BOOLEAN NOT NULL DEFAULT false,
    "page3Completed" BOOLEAN NOT NULL DEFAULT false,
    "page4Completed" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "DentalRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PatientSnapshot" (
    "id" TEXT NOT NULL,
    "dentalRecordId" TEXT NOT NULL,
    "lastName" TEXT,
    "firstName" TEXT,
    "middleName" TEXT,
    "birthdate" TIMESTAMP(3),
    "sex" "Sex",
    "nationality" TEXT DEFAULT 'Filipino',
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

    CONSTRAINT "PatientSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PatientSnapshot_dentalRecordId_key" ON "PatientSnapshot"("dentalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "DentalChart_dentalRecordId_key" ON "DentalChart"("dentalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "DentalHistory_dentalRecordId_key" ON "DentalHistory"("dentalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "InformedConsent_dentalRecordId_key" ON "InformedConsent"("dentalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalHistory_dentalRecordId_key" ON "MedicalHistory"("dentalRecordId");

-- AddForeignKey
ALTER TABLE "DentalRecord" ADD CONSTRAINT "DentalRecord_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientSnapshot" ADD CONSTRAINT "PatientSnapshot_dentalRecordId_fkey" FOREIGN KEY ("dentalRecordId") REFERENCES "DentalRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DentalHistory" ADD CONSTRAINT "DentalHistory_dentalRecordId_fkey" FOREIGN KEY ("dentalRecordId") REFERENCES "DentalRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalHistory" ADD CONSTRAINT "MedicalHistory_dentalRecordId_fkey" FOREIGN KEY ("dentalRecordId") REFERENCES "DentalRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DentalChart" ADD CONSTRAINT "DentalChart_dentalRecordId_fkey" FOREIGN KEY ("dentalRecordId") REFERENCES "DentalRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InformedConsent" ADD CONSTRAINT "InformedConsent_dentalRecordId_fkey" FOREIGN KEY ("dentalRecordId") REFERENCES "DentalRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TreatmentRecord" ADD CONSTRAINT "TreatmentRecord_dentalRecordId_fkey" FOREIGN KEY ("dentalRecordId") REFERENCES "DentalRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;
