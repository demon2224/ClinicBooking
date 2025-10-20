USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	INSERT INTO Appointment(UserID, DoctorID, AppointmentStatusID, DateBegin, DateEnd, Note)
	VALUES
	(14, 7, 3, '2025-10-15 09:00', '2025-10-15 09:30', 'Follow-up Headache'),
	(14, 7, 1, '2025-10-20 10:00', NULL, 'Flu symptoms'),
	(14, 7, 1, '2025-10-25 11:00', NULL, 'Routine check-up');

	INSERT INTO Prescription(AppointmentID, PrescriptionStatusID, Note)
	VALUES
	(6, 1, 'Pain killer'),
	(7, 1, 'Flu treatment'),
	(8, 1, 'Routine vitamins');

	INSERT INTO PrescriptionItem(PrescriptionID, MedicineID, Dosage, Instruction)
	VALUES
	(6, 1, 2, 'Take twice daily'),
	(7, 1, 2, 'Take twice daily'),
	(7, 3, 1, 'Take before bed'),
	(8, 1, 1, 'One tablet daily');

	INSERT INTO MedicalRecord(AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note)
	VALUES
	(6, 6, 'Headache', 'Tension headache', 'Follow-up visit'),
	(7, 7, 'Fever, Cough', 'Seasonal Flu', 'Prescribed syrup'),
	(8, 8, 'Routine', 'Healthy', 'No issues');

	INSERT INTO Invoice(MedicalRecordID, ConsultationFeeID, PrescriptionID, PaymentTypeID, InvoiceStatusID)
	VALUES
	(6, 1, 6, 1, 1),
	(7, 1, 7, 2, 1),
	(8, 1, 8, 3, 3);

	INSERT INTO Appointment(UserID, DoctorID, AppointmentStatusID, DateBegin, DateEnd, Note)
	VALUES
	(14, 8, 2, '2025-10-30 09:00', null, 'Allergy check-up'),
	(14, 8, 3, '2025-11-05 14:00', '2025-11-05 14:45', 'Toothache follow-up'),
	(14, 8, 1, '2025-11-12 08:30', NULL, 'Annual health check');

	INSERT INTO Prescription(AppointmentID, PrescriptionStatusID, Note)
	VALUES
	(9, 1, 'Allergy treatment'),
	(10, 2, 'Pain relief'),
	(11, 1, 'Vitamin support');

	INSERT INTO PrescriptionItem(PrescriptionID, MedicineID, Dosage, Instruction)
	VALUES
	(9, 4, 1, 'Apply to affected area'),
	(10, 1, 2, 'Take twice daily'),
	(11, 1, 1, 'Take after breakfast');

	INSERT INTO MedicalRecord(AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note)
	VALUES
	(9, 9, 'Itchy skin', 'Allergy', 'Prescribed cream'),
	(10, 10, 'Toothache', 'Dental pain', 'Painkillers prescribed'),
	(11, 11, 'General check', 'Healthy', 'Routine exam');

	INSERT INTO Invoice(MedicalRecordID, ConsultationFeeID, PrescriptionID, PaymentTypeID, InvoiceStatusID)
	VALUES
	(9, 1, 9, 4, 1),
	(10, 1, 10, 5, 1),
	(11, 1, 11, 3, 3);

	INSERT INTO Appointment (UserID, DoctorID, AppointmentStatusID, DateBegin, DateEnd, Note)
	VALUES
	(14, 8, 2, '2025-10-10 09:00', null, 'Regular check-up'),
	(14, 8, 3, '2025-10-15 14:00', '2025-10-15 14:30', 'Allergy consultation'),
	(14, 8, 3, '2025-10-22 10:15', '2025-10-22 10:45', 'Stomach pain evaluation'),
	(14, 8, 2, '2025-11-01 08:45', null, 'Blood pressure follow-up'),
	(14, 8, 4, '2025-11-10 16:00', null, 'Headache diagnosis');

	INSERT INTO Prescription (AppointmentID, PrescriptionStatusID, Note)
	VALUES
	(12, 1, 'Prescribed basic supplements'),
	(13, 1, 'Antihistamines for seasonal allergy'),
	(14, 1, 'Antacid treatment'),
	(15, 1, 'Hypertension medication'),
	(16, 1, 'Pain relief medication');

	INSERT INTO PrescriptionItem (PrescriptionID, MedicineID, Dosage, Instruction)
	VALUES
	(12, 1, 1, 'Take 1 tablet daily after breakfast'),
	(13, 2, 1, 'Take 1 tablet at night'),
	(14, 3, 1, 'Take 1 capsule before meals'),
	(15, 4, 1, 'Take 1 tablet in the morning'),
	(16, 5, 2, 'Take 2 tablets when pain occurs');

	INSERT INTO MedicalRecord (AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note)
	VALUES
	(12, 1, 'Fatigue and mild cough', 'Common cold', 'Drink water and rest'),
	(13, 2, 'Sneezing, runny nose', 'Allergic rhinitis', 'Avoid pollen exposure'),
	(14, 3, 'Burning sensation after meals', 'Gastritis', 'Follow antacid treatment'),
	(15, 4, 'High blood pressure', 'Hypertension', 'Monitor daily pressure'),
	(16, 5, 'Severe headache', 'Tension headache', 'Reduce stress and rest');

	INSERT INTO Invoice (MedicalRecordID, ConsultationFeeID, PrescriptionID, PaymentTypeID, InvoiceStatusID, DatePay)
	VALUES
	(12, 1, 1, 1, 1, '2025-10-10'),
	(13, 2, 2, 2, 1, '2025-10-15'),
	(14, 3, 3, 3, 1, '2025-10-22'),
	(15, 4, 4, 1, 1, '2025-11-01'),
	(16, 5, 5, 2, 1, '2025-11-10');

END