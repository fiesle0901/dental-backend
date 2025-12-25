-- CreateEnum
CREATE TYPE "RecordStatus" AS ENUM ('DRAFT', 'FINALIZED');

-- AlterTable
ALTER TABLE "DentalRecord" ADD COLUMN     "status" "RecordStatus" NOT NULL DEFAULT 'DRAFT';
