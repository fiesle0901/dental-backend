import { Router } from "express";
import multer from "multer";

import { uploadPage1Form } from "../controllers/page1_controller";
import { uploadPage2Form } from "../controllers/page2_controller";
import { uploadPage3Form } from "../controllers/page3_controller";

const router = Router();
const upload = multer({ storage: multer.memoryStorage() });

router.post("/page-1", upload.single("file"), uploadPage1Form);
router.post("/page-2", upload.single("file"), uploadPage2Form);
router.post("/page-3", upload.single("file"), uploadPage3Form);

export default router;
