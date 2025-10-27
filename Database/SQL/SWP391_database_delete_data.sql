USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	IF EXISTS (SELECT 1 FROM Invoice)
		DBCC CHECKIDENT (Invoice, RESEED, 0);
		DELETE FROM Invoice;

	IF EXISTS (SELECT 1 FROM MedicalRecord)
		DBCC CHECKIDENT (MedicalRecord, RESEED, 0);
		DELETE FROM MedicalRecord;

	IF EXISTS (SELECT 1 FROM ConsultationFee)
		DELETE FROM ConsultationFee;

	IF EXISTS (SELECT 1 FROM MedicineStockTransaction)
		DBCC CHECKIDENT (MedicineStockTransaction, RESEED, 0);
		DELETE FROM MedicineStockTransaction;

	IF EXISTS (SELECT 1 FROM PrescriptionItem)
		DELETE FROM PrescriptionItem;

	IF EXISTS (SELECT 1 FROM Medicine)
		DBCC CHECKIDENT (Medicine, RESEED, 0);
		DELETE FROM Medicine;

	IF EXISTS (SELECT 1 FROM Prescription)
		DBCC CHECKIDENT (Prescription, RESEED, 0);
		DELETE FROM Prescription;

	IF EXISTS (SELECT 1 FROM Appointment)
		DBCC CHECKIDENT (Appointment, RESEED, 0);
		DELETE FROM Appointment;

	IF EXISTS (SELECT 1 FROM DoctorReview)
		DBCC CHECKIDENT (DoctorReview, RESEED, 0);
		DELETE FROM DoctorReview;

	IF EXISTS (SELECT 1 FROM Pharmacist)
		DBCC CHECKIDENT (Pharmacist, RESEED, 0);
		DELETE FROM Pharmacist;

	IF EXISTS (SELECT 1 FROM Receptionist)
		DBCC CHECKIDENT (Receptionist, RESEED, 0);
		DELETE FROM Receptionist;

	IF EXISTS (SELECT 1 FROM DoctorDegree)
		DELETE FROM DoctorDegree;

	IF EXISTS (SELECT 1 FROM Degree)
		DBCC CHECKIDENT (Degree, RESEED, 0);
		DELETE FROM Degree;

	IF EXISTS (SELECT 1 FROM Doctor)
		DBCC CHECKIDENT (Doctor, RESEED, 0);
		DELETE FROM Doctor;

	IF EXISTS (SELECT 1 FROM Specialty)
		DBCC CHECKIDENT (Specialty, RESEED, 0);
		DELETE FROM Specialty;

	IF EXISTS (SELECT 1 FROM Staff)
		DBCC CHECKIDENT (Staff, RESEED, 0);
		DELETE FROM Staff;

	IF EXISTS (SELECT 1 FROM [Role])
		DBCC CHECKIDENT ([Role], RESEED, 0);
		DELETE FROM [Role];

	IF EXISTS (SELECT 1 FROM Patient)
		DBCC CHECKIDENT (Patient, RESEED, 0);
		DELETE FROM Patient;

END;