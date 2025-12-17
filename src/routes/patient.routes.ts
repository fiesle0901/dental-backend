import { Router } from "express";
import {
  getAllPatients,
  getPatient,
  deletePatient,
} from "../controllers/patient.controller";

const router = Router();

router.get("/", getAllPatients);
router.get("/:patientId", getPatient);
router.delete("/patientId", deletePatient);

export default router;
