/*
  Warnings:

  - The `localAnesthetic` column on the `MedicalAllergies` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `penicillin` column on the `MedicalAllergies` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `antibiotics` column on the `MedicalAllergies` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `sulfaDrugs` column on the `MedicalAllergies` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `aspirin` column on the `MedicalAllergies` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `latex` column on the `MedicalAllergies` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "MedicalAllergies" DROP COLUMN "localAnesthetic",
ADD COLUMN     "localAnesthetic" BOOLEAN,
DROP COLUMN "penicillin",
ADD COLUMN     "penicillin" BOOLEAN,
DROP COLUMN "antibiotics",
ADD COLUMN     "antibiotics" BOOLEAN,
DROP COLUMN "sulfaDrugs",
ADD COLUMN     "sulfaDrugs" BOOLEAN,
DROP COLUMN "aspirin",
ADD COLUMN     "aspirin" BOOLEAN,
DROP COLUMN "latex",
ADD COLUMN     "latex" BOOLEAN;
