USE master
GO

--- DROP DATABASE IF EXIST WITHOUT ANY OBTRUCTION
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	--- SET THE CONNECTION TO DATABASE ONLY THIS SQL FILE AND DROP THE DATABASE
	ALTER DATABASE ClinicBookingDatabase
	SET SINGLE_USER
	WITH ROLLBACK IMMEDIATE
	DROP DATABASE ClinicBookingDatabase
END

--- CREATE A NEW DATABASE
CREATE DATABASE ClinicBookingDatabase
GO

--- USE THE NEW DATABASE JUST CREATED
USE ClinicBookingDatabase
GO

CREATE TABLE Patient (
	PatientID INT PRIMARY KEY IDENTITY(1,1),
	AccountName NVARCHAR(255) UNIQUE,
	AccountPassword NVARCHAR(255),
	DayCreated DATETIME DEFAULT GETDATE(),
	Avatar NVARCHAR(255),
	Bio NVARCHAR(550),
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	DOB DATE,
	Gender BIT DEFAULT 0,
	UserAddress NVARCHAR(255),
	PhoneNumber NVARCHAR(15) UNIQUE,
	Email NVARCHAR(50) UNIQUE,
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Staff (
	StaffID INT PRIMARY KEY IDENTITY(1,1),
	JobStatus NVARCHAR(50) DEFAULT 'Available' CHECK (JobStatus IN ('Unavailable', 'Available', 'Retired')) NOT NULL,
	[Role] NVARCHAR(50) CHECK ([Role] IN ('Receptionist', 'Pharmacist', 'Doctor', 'Admin')) NOT NULL,
	AccountName NVARCHAR(255) UNIQUE,
	AccountPassword NVARCHAR(255),
	DayCreated DATETIME DEFAULT GETDATE(),
	Avatar NVARCHAR(255),
	Bio NVARCHAR(550),
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	DOB DATE,
	Gender BIT DEFAULT 0,
	UserAddress NVARCHAR(255),
	PhoneNumber NVARCHAR(15) UNIQUE,
	Email NVARCHAR(50),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Specialty (
	SpecialtyID INT PRIMARY KEY IDENTITY(1,1),
	SpecialtyName NVARCHAR(50),
	Price DECIMAL(20,2) DEFAULT 0 CHECK (Price >= 0)
);

CREATE TABLE Doctor (
	DoctorID INT PRIMARY KEY IDENTITY(1,1),
	StaffID INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
	SpecialtyID INT FOREIGN KEY REFERENCES Specialty(SpecialtyID),
	YearExperience INT
);

CREATE TABLE Degree (
	DegreeID INT PRIMARY KEY IDENTITY(1,1),
	DegreeName NVARCHAR(255),
	DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID) NOT NULL
);

CREATE TABLE Receptionist (
	ReceptionistID INT PRIMARY KEY IDENTITY(1,1),
	StaffID INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL
);

CREATE TABLE Pharmacist (
	PharmacistID INT PRIMARY KEY IDENTITY(1,1),
	StaffID INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL
);

CREATE TABLE DoctorReview (
	DoctorReviewID INT PRIMARY KEY IDENTITY(1,1),
	PatientID INT FOREIGN KEY REFERENCES Patient (PatientID) NOT NULL,
	DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID) NOT NULL,
	Content NVARCHAR(500),
	RateScore INT,
	DateCreate DATETIME DEFAULT GETDATE(),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Appointment (
	AppointmentID INT PRIMARY KEY IDENTITY(1,1),
	PatientID INT FOREIGN KEY REFERENCES Patient(PatientID) NOT NULL,
	DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID) NOT NULL,
	AppointmentStatus NVARCHAR(50) DEFAULT 'Pending' CHECK (AppointmentStatus IN ('Pending', 'Approved', 'Completed', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	DateBegin DATETIME,
	DateEnd DATETIME,
	Note NVARCHAR(550),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Prescription (
	PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
	AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID) NOT NULL,
	PrescriptionStatus NVARCHAR(50) DEFAULT 'Pending' CHECK (PrescriptionStatus IN ('Pending', 'Delivered', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	Note NVARCHAR(550),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Medicine (
	MedicineID INT PRIMARY KEY IDENTITY(1,1),
	MedicineType NVARCHAR(50) CHECK (MedicineType IN ('Tablet', 'Capsule', 'Syrup', 'Ointment', 'Drops')) NOT NULL,
	MedicineStatus BIT DEFAULT 0,
	MedicineName NVARCHAR(200),
	MedicineCode NVARCHAR(50) UNIQUE,
	Quantity INT DEFAULT 0 CHECK (Quantity >= 0),
	Price DECIMAL(20,2) DEFAULT 0 CHECK (Price >= 0),
	DateCreate DATETIME DEFAULT GETDATE(),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE PrescriptionItem (
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID),
	MedicineID INT FOREIGN KEY REFERENCES Medicine(MedicineID),
	PRIMARY KEY (PrescriptionID, MedicineID),
	Dosage INT NOT NULL CHECK(Dosage > 0),
	Instruction NVARCHAR(255) NOT NULL
);

CREATE TABLE MedicalRecord (
	MedicalRecordID INT PRIMARY KEY IDENTITY(1,1),
	AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID) NOT NULL,
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID),
	Symptoms NVARCHAR(255),
	Diagnosis NVARCHAR(255),
	Note NVARCHAR(550),
	DateCreate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Invoice (
	InvoiceID INT PRIMARY KEY IDENTITY(1,1),
	MedicalRecordID INT FOREIGN KEY REFERENCES MedicalRecord(MedicalRecordID) NOT NULL,
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID),
	PaymentType NVARCHAR(50) CHECK (PaymentType IN ('Cash', 'Credit Card', 'Insurance', 'Online Banking', 'E-Wallet')) NOT NULL,
	InvoiceStatus NVARCHAR(50) CHECK (InvoiceStatus IN ('Pending', 'Paid', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	DatePay DATETIME
);

GO
CREATE TRIGGER TR_MedicalRecord_CreateInvoice
ON [dbo].[MedicalRecord]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
    INSERT INTO [dbo].[Invoice] (MedicalRecordID, PaymentType, InvoiceStatus)
    SELECT
        i.MedicalRecordID,
        'Cash',
		'Pending'
    FROM INSERTED i;
END;

GO
CREATE TRIGGER TR_Invoice_InsertPrescription
ON [dbo].[MedicalRecord]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE inv
	SET inv.PrescriptionID = i.PrescriptionID
	FROM [dbo].[Invoice] inv
	JOIN inserted i
	ON inv.MedicalRecordID = i.MedicalRecordID
	WHERE i.PrescriptionID IS NOT NULL;
END;

GO
CREATE TRIGGER TR_Medicine_UpdateMedicineStatus
ON [dbo].[Medicine]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON; 
	UPDATE m
    SET m.MedicineStatus = 0
    FROM [dbo].[Medicine] m
    JOIN inserted i
	ON m.MedicineID = i.MedicineID
    WHERE i.Quantity = 0; 
END;

GO
CREATE TRIGGER TR_Invoice_UpdateMedicineStatus
ON [dbo].[Invoice]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON; 
	UPDATE ap
	SET ap.AppointmentStatus = 'Completed'
	FROM [dbo].[Appointment] ap
	JOIN [dbo].[MedicalRecord] mr
	ON mr.AppointmentID = ap.AppointmentID
	JOIN inserted i
	ON mr.MedicalRecordID = mr.MedicalRecordID
	WHERE i.InvoiceStatus = 'Paid';
END;
