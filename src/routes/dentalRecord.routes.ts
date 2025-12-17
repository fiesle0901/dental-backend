import { Router } from "express";
import multer from "multer";

import { uploadPage1Form } from "../controllers/page1_controller";
import { uploadPage2Form } from "../controllers/page2_controller";
import { uploadPage3Form } from "../controllers/page3_controller";
import { uploadPage4Form } from "../controllers/page4_controller";
import {
  createDentalRecord,
  getDentalRecord,
  deleteDentalRecord,
} from "../controllers/dentalRecord_controller";

const router = Router();
const upload = multer({ storage: multer.memoryStorage() });

router.post("/", createDentalRecord);
router.get("/:recordId", getDentalRecord);
router.delete("/:recordId", deleteDentalRecord);

router.post("/:recordId/page-1", upload.single("file"), uploadPage1Form);
router.post("/:recordId/page-2", upload.single("file"), uploadPage2Form);
router.post("/:recordId/page-3", upload.single("file"), uploadPage3Form);
router.post("/:recordId/page-4", upload.single("file"), uploadPage4Form);

export default router;
