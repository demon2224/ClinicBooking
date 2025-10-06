USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	IF EXISTS (SELECT 1 FROM "Role")
		DBCC CHECKIDENT ("Role", RESEED, 0);
		DELETE FROM "Role";
	INSERT INTO "Role"(RoleName)
	VALUES
		('Patient'),('Receptionist'),('Pharmacist'),('Doctor'),('Admin');

	IF EXISTS (SELECT 1 FROM JobStatus)
		DBCC CHECKIDENT (JobStatus, RESEED, 0);
		DELETE FROM JobStatus;
	INSERT INTO JobStatus(JobStatusDescription)
	VALUES
		('Available'),('Unavailable'),('Retired');
	
	IF EXISTS (SELECT 1 FROM AppointmentStatus)
		DBCC CHECKIDENT (AppointmentStatus, RESEED, 0);
		DELETE FROM AppointmentStatus;
	INSERT INTO AppointmentStatus(AppointmentStatusName)
	VALUES
		('Peding'),('Approved'),('Completed'),('Canceled');
	
	IF EXISTS (SELECT 1 FROM PrescriptionStatus)
		DBCC CHECKIDENT (PrescriptionStatus, RESEED, 0);
		DELETE FROM PrescriptionStatus;
	INSERT INTO PrescriptionStatus(PrescriptionStatusName)
	VALUES
		('Pending'),('Delivered'),('Canceled');

	IF EXISTS (SELECT 1 FROM "User")
		DBCC CHECKIDENT ("User", RESEED, 0);
		DELETE FROM "User";
	INSERT INTO "User"(RoleID)
	VALUES
		(1),(5),(5),(5),(5),
		(5),(2),(2),(2),(3),
		(3),(4),(4),(5),(5),
		(5),(5),(5),(2),(2),
		(3),(3),(4),(4),(5);

	INSERT INTO Account(UserAccountID, AccountName, AccountPassword, Avatar, Bio)
	VALUES
		(1,'admin01','123456',null,'System administrator'),
		(2,'TuanLA','CE180950',null,'System administrator'),
		(3,'KhangNM','CE190728',null,'System administrator'),
		(4,'HungNQ','CE191184',null,'System administrator'),
		(5,'TriLT','CE191249',null,'System administrator'),
		(6,'KhangVM','CE191371',null,'System administrator'),
		(7,'dr_smith','abc123',null,'Cardiologist'),
		(8,'dr_anna','abc123',null,'Dermatologist'),
		(9,'dr_kien','abc123',null,'Dentist'),
		(10,'rec_hue','abc123',null,'Receptionist'),
		(11,'rec_minh','abc123',null,'Receptionist'),
		(12,'pharm_hoang','abc123',null,'Pharmacist'),
		(13,'pharm_hien','abc123',null,'Pharmacist'),
		(14,'pat_long','abc123',null,'Patient'),
		(15,'pat_lan','abc123',null,'Patient'),
		(16,'pat_hoa','abc123',null,'Patient'),
		(17,'pat_nam','abc123',null,'Patient'),
		(18,'pat_trang','abc123',null,'Patient'),
		(19,'dr_hieu','abc123',null,'Pediatrician'),
		(20,'dr_thao','abc123',null,'Ophthalmologist'),
		(21,'rec_khanh','abc123',null,'Receptionist'),
		(22,'rec_dung','abc123',null,'Receptionist'),
		(23,'pharm_tuan','abc123',null,'Pharmacist'),
		(24,'pharm_ly','abc123',null,'Pharmacist'),
		(25,'pat_hung','abc123',null,'Patient');

	INSERT INTO "Profile"(UserProfileID, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
		(1,'System','Admin','1980-01-01',1,'Hanoi','0900000001','admin@clinic.vn'),
		(2,'System','Admin','1980-01-01',1,'Hanoi','0900000002','TuanLACE180905@fpt.edu,vn'),
		(3,'System','Admin','1980-01-01',1,'Hanoi','0900000003','KhangNMCE190728@gmail.com'),
		(4,'System','Admin','1980-01-01',1,'Hanoi','0900000004','HungNQCE191184@gmail.com'),
		(5,'System','Admin','1980-01-01',1,'Hanoi','0900000005','TriLTCE191249@gmail.com'),
		(6,'System','Admin','1980-01-01',1,'Hanoi','0900000006','KhangVMCE191371@gmai.com'),
		(7,'John','Smith','1985-03-15',1,'Can Tho','0900000007','smith@clinic.vn'),
		(8,'Anna','Tran','1990-05-10',0,'HCMC','0900000008','anna@clinic.vn'),
		(9,'Kien','Nguyen','1988-07-12',1,'Danang','0900000009','kien@clinic.vn'),
		(10,'Hue','Le','1995-09-20',0,'Hanoi','0900000010','hue@clinic.vn'),
		(11,'Minh','Pham','1994-11-30',1,'HCMC','0900000011','minh@clinic.vn'),
		(12,'Hoang','Vo','1987-01-22',1,'Hue','0900000012','hoang@clinic.vn'),
		(13,'Hien','Do','1992-04-25',0,'Can Tho','0900000013','hien@clinic.vn'),
		(14,'Long','Pham','2000-08-17',1,'HCMC','0900000014','long@clinic.vn'),
		(15,'Lan','Nguyen','1998-12-10',0,'Hanoi','0900000015','lan@clinic.vn'),
		(16,'Hoa','Tran','1999-10-05',0,'Hue','0900000016','hoa@clinic.vn'),
		(17,'Nam','Bui','2001-06-25',1,'Danang','0900000017','nam@clinic.vn'),
		(18,'Trang','Le','2002-07-01',0,'Can Tho','0900000018','trang@clinic.vn'),
		(19,'Hieu','Pham','1989-09-09',1,'Hanoi','0900000019','hieu@clinic.vn'),
		(20,'Thao','Vu','1991-04-11',0,'HCMC','0900000020','thao@clinic.vn'),
		(21,'Khanh','Do','1993-02-17',1,'Hue','0900000021','khanh@clinic.vn'),
		(22,'Dung','Tran','1996-05-22',1,'Danang','0900000022','dung@clinic.vn'),
		(23,'Tuan','Le','1994-08-13',1,'Hanoi','0900000023','tuan@clinic.vn'),
		(24,'Ly','Ho','1995-03-19',0,'Can Tho','0900000024','ly@clinic.vn'),
		(25,'Hung','Nguyen','1999-11-29',1,'HCMC','0900000025','hung@clinic.vn');

	IF EXISTS (SELECT 1 FROM Specialty)
		DBCC CHECKIDENT(Specialty, RESEED, 0);
		DELETE FROM Specialty;
	INSERT INTO Specialty (SpecialtyName)
	VALUES
		(N'Cardiology'),(N'Dermatology'),(N'Dentistry'),(N'Pediatrics'),(N'Ophthalmology');

	INSERT INTO Doctor(DoctorID, JobStatusID, SpecialtyID, YearExperience)
	VALUES
		(2,1,1,10),(3,1,2,8),(4,1,3,12),(14,2,4,6),(15,1,5,7);

	IF EXISTS (SELECT 1 FROM Degree)
		DBCC CHECKIDENT (Degree, RESEED, 0);
		DELETE FROM Degree;
	INSERT INTO Degree(DegreeName)
	VALUES
		('MD'),('PhD'),('Specialist I'),('Specialist II'),('Resident');

	
	INSERT INTO DoctorDegree(DoctorID, DegreeID, DateEarn, Grantor)
	VALUES
		(2,1,'2010-05-10','HCMC Medical University'),
		(2,3,'2015-06-01','Hanoi Health Dept'),
		(3,1,'2011-07-22','Can Tho University'),
		(4,1,'2009-09-01','Hue Medical University'),
		(15,2,'2014-03-15','Hanoi Medical University'),
		(14,1,'2013-01-01','Danang Medical University');

	INSERT INTO Receptionist(ReceptionistID, JobStatusID)
	VALUES
		(5,1),(6,1),(16,1),(17,1);

	INSERT INTO Pharmacist(PharmacistID, JobStatusID)
	VALUES
		(7,1),(8,1),(18,1),(19,1);

	IF EXISTS (SELECT 1 FROM DoctorReview)
		DBCC CHECKIDENT (DoctorReview, RESEED, 0);
		DELETE FROM DoctorReview;
	INSERT INTO DoctorReview(UserID, DoctorID, Content, RateScore)
	VALUES
		(9,2,'Great doctor, very kind',5),
		(10,3,'Helpful and professional',4),
		(11,4,'Fast service',4),
		(12,14,'Very patient with kids',5),
		(13,15,'Explained everything clearly',5);

	IF EXISTS (SELECT 1 FROM Appointment)
		DBCC CHECKIDENT (Appointment, RESEED, 0);
		DELETE FROM Appointment;
	INSERT INTO Appointment(UserID, DoctorID, AppointmentStatusID, DateBegin, DateEnd, Note)
	VALUES
		(9,2,2,'2025-10-10 09:00','2025-10-10 09:30','Check-up'),
		(10,3,1,'2025-10-11 10:00','2025-10-11 10:30','Skin issue'),
		(11,4,2,'2025-10-12 11:00','2025-10-12 11:45','Toothache'),
		(12,14,3,'2025-10-13 14:00','2025-10-13 14:30','Fever'),
		(13,15,4,'2025-10-14 15:00','2025-10-14 15:45','Eye check');

	IF EXISTS (SELECT 1 FROM Prescription)
		DBCC CHECKIDENT (Prescription, RESEED, 0);
		DELETE FROM Prescription;
	INSERT INTO Prescription(AppointmentID, PrescriptionStatusID, Note)
	VALUES
		(1,2,'Basic medicine'),(2,2,'Ointment'),(3,2,'Pain relief'),(4,1,'Cough syrup'),(5,3,'Vision support');

	IF EXISTS (SELECT 1 FROM MedicineType)
		DBCC CHECKIDENT (MedicineType, RESEED, 0);
		DELETE FROM MedicineType;
	INSERT INTO MedicineType(MedicineTypeName)
	VALUES
		('Tablet'),('Capsule'),('Syrup'),('Ointment'),('Drops');

	IF EXISTS (SELECT 1 FROM Medicine)
		DBCC CHECKIDENT (Medicine, RESEED, 0);
		DELETE FROM Medicine;
	INSERT INTO Medicine(MedicineType, MedicineStatus, MedicineName, MedicineCode, Quantity, Price)
	VALUES
		(1,1,'Paracetamol','TBL001',100,20000),
		(2,1,'Amoxicillin','CAP002',150,30000),
		(3,1,'Cough Syrup','SYR003',50,50000),
		(4,1,'Skin Cream','OINT004',70,60000),
		(5,1,'Eye Drops','DRP005',60,40000);

	INSERT INTO PrescriptionItem(PrescriptionID, MedicineID, Dosage, Instruction)
	VALUES
		(1,1,2,'Take twice daily'),
		(2,4,1,'Apply to skin area'),
		(3,2,3,'After meals'),
		(4,3,2,'Morning and night'),
		(5,5,1,'1 drop per eye');

	IF EXISTS (SELECT 1 FROM  StockTransaction)
		DBCC CHECKIDENT ( StockTransaction, RESEED, 0);
		DELETE FROM  StockTransaction;
	INSERT INTO StockTransaction(MedicineID, Quantity, DateExpire)
	VALUES
		(1,100,'2026-12-31'),(2,150,'2026-11-30'),(3,80,'2026-09-30'),(4,70,'2026-07-31'),(5,60,'2026-10-15');

	IF EXISTS (SELECT 1 FROM ConsultationFee)
		DBCC CHECKIDENT (ConsultationFee, RESEED, 0);
		DELETE FROM ConsultationFee;
	INSERT INTO ConsultationFee(DoctorID, SpecialtyID, Fee)
	VALUES
		(2,1,200000),(3,2,180000),(4,3,150000),(14,4,170000),(15,5,190000);

	IF EXISTS (SELECT 1 FROM MedicalRecord)
		DBCC CHECKIDENT (MedicalRecord, RESEED, 0);
		DELETE FROM MedicalRecord;
	INSERT INTO MedicalRecord(AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note)
	VALUES
		(1,1,'Headache','Flu','Basic check'),
		(2,2,'Rash','Dermatitis','Allergy'),
		(3,3,'Pain','Tooth decay','Cavity fix'),
		(4,4,'Cough','Cold','Viral'),
		(5,5,'Blurred vision','Myopia','Need glasses');

	IF EXISTS (SELECT 1 FROM PaymentType)
		DBCC CHECKIDENT (PaymentType, RESEED, 0);
		DELETE FROM PaymentType;
	INSERT INTO PaymentType(PaymentTypeName)
	VALUES
		('Cash'),('Credit Card'),('Insurance'),('Online Banking'),('E-Wallet');

	IF EXISTS (SELECT 1 FROM Invoice)
		DBCC CHECKIDENT (Invoice, RESEED, 0);
		DELETE FROM Invoice;
	INSERT INTO Invoice(MedicalRecordID, ConsultationFeeID, PrescriptionID, PaymentTypeID, InvoiceStatus)
	VALUES
		(1,1,1,1,1),(2,2,2,2,1),(3,3,3,3,0),(4,4,4,4,1),(5,5,5,5,0);

END