import { prisma } from "../config/prisma";

export const ensureRecordIsEditable = async (recordId: string) => {
  const record = await prisma.dentalRecord.findUnique({
    where: { id: recordId },
    select: { status: true },
  });

  if (!record) {
    throw new Error("RECORD_NOT_FOUND");
  }

  if (record.status === "FINALIZED") {
    throw new Error("RECORD_FINALIZED");
  }

  return record;
};
