USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	IF EXISTS (SELECT 1 FROM Account)
		DELETE FROM Account;

	IF EXISTS (SELECT 1 FROM "Profile")
		DELETE FROM "Profile";

	IF EXISTS (SELECT 1 FROM Invoice)
		DBCC CHECKIDENT (Invoice, RESEED, 0);
		DELETE FROM Invoice;

	IF EXISTS (SELECT 1 FROM InvoiceStatus)
		DBCC CHECKIDENT (InvoiceStatus, RESEED, 0);
		DELETE FROM InvoiceStatus;

	IF EXISTS (SELECT 1 FROM PaymentType)
		DBCC CHECKIDENT (PaymentType, RESEED, 0);
		DELETE FROM PaymentType;

	IF EXISTS (SELECT 1 FROM ConsultationFee)
		DBCC CHECKIDENT (ConsultationFee, RESEED, 0);
		DELETE FROM ConsultationFee;

	IF EXISTS (SELECT 1 FROM DoctorDegree)
		DELETE FROM DoctorDegree;
	
	IF EXISTS (SELECT 1 FROM Degree)
		DBCC CHECKIDENT (Degree, RESEED, 0);
		DELETE FROM Degree;

	IF EXISTS (SELECT 1 FROM DoctorReview)
		DBCC CHECKIDENT (DoctorReview, RESEED, 0);
		DELETE FROM DoctorReview;

	IF EXISTS (SELECT 1 FROM MedicalRecord)
		DBCC CHECKIDENT (MedicalRecord, RESEED, 0);
		DELETE FROM MedicalRecord;

	IF EXISTS (SELECT 1 FROM MedicineStockTransaction)
		DBCC CHECKIDENT (MedicineStockTransaction, RESEED, 0);
		DELETE FROM MedicineStockTransaction;

	IF EXISTS (SELECT 1 FROM PrescriptionItem)
		DELETE FROM PrescriptionItem;

	IF EXISTS (SELECT 1 FROM Medicine)
		DBCC CHECKIDENT (Medicine, RESEED, 0);
		DELETE FROM Medicine;

	IF EXISTS (SELECT 1 FROM MedicineType)
		DBCC CHECKIDENT (MedicineType, RESEED, 0);
		DELETE FROM MedicineType;

	IF EXISTS (SELECT 1 FROM Prescription)
		DBCC CHECKIDENT (Prescription, RESEED, 0);
		DELETE FROM Prescription;

	IF EXISTS (SELECT 1 FROM PrescriptionStatus)
		DBCC CHECKIDENT (PrescriptionStatus, RESEED, 0);
		DELETE FROM PrescriptionStatus;

	IF EXISTS (SELECT 1 FROM Appointment)
		DBCC CHECKIDENT (Appointment, RESEED, 0);
		DELETE FROM Appointment;

	IF EXISTS (SELECT 1 FROM AppointmentStatus)
		DBCC CHECKIDENT (AppointmentStatus, RESEED, 0);
		DELETE FROM AppointmentStatus;

	IF EXISTS (SELECT 1 FROM Doctor)
		DELETE FROM Doctor;

	IF EXISTS (SELECT 1 FROM Specialty)
		DBCC CHECKIDENT (Specialty, RESEED, 0);
		DELETE FROM Specialty;

	IF EXISTS (SELECT 1 FROM Pharmacist)
		DELETE FROM Pharmacist;

	IF EXISTS (SELECT 1 FROM Receptionist)
		DELETE FROM Receptionist;

	IF EXISTS (SELECT 1 FROM JobStatus)
		DBCC CHECKIDENT (JobStatus, RESEED, 0);
		DELETE FROM JobStatus;

	IF EXISTS (SELECT 1 FROM "User")
		DBCC CHECKIDENT ("User", RESEED, 0);
		DELETE FROM "User";

	IF EXISTS (SELECT 1 FROM "Role")
		DBCC CHECKIDENT ("Role", RESEED, 0);
		DELETE FROM "Role";

END;