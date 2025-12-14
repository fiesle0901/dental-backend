import { Router } from "express";
import multer from "multer";

import { uploadPage1Form } from "../controllers/page1_controller";
import { uploadPage2Form } from "../controllers/page2_controller";

const router = Router();
const upload = multer({ storage: multer.memoryStorage() });

router.post("/page-1", upload.single("file"), uploadPage1Form);
router.post("/page-2", upload.single("file"), uploadPage2Form);

export default router;
