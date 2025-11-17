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

CREATE TABLE Account (
	AccountID INT PRIMARY KEY IDENTITY(1,1),
	Username NVARCHAR(255) UNIQUE,
	[Password] NVARCHAR(255),
	DayCreated DATETIME DEFAULT GETDATE(),
	Avatar NVARCHAR(255),
	[Address] NVARCHAR(255),
	PhoneNumber NVARCHAR(15) UNIQUE,
	Email NVARCHAR(50) UNIQUE,
	[Hidden] BIT DEFAULT 0,
	OTP NVARCHAR(6)
);

CREATE TABLE Specialty (
	SpecialtyID INT PRIMARY KEY IDENTITY(1,1),
	SpecialtyName NVARCHAR(50),
	Price INT DEFAULT 0 CHECK (Price >= 0)
);

CREATE TABLE Staff (
	StaffID INT PRIMARY KEY IDENTITY(1,1),
	JobStatus NVARCHAR(50) DEFAULT 'Available' CHECK (JobStatus IN ('Unavailable', 'Available', 'Retired')) NOT NULL,
	[Role] NVARCHAR(50) CHECK ([Role] IN ('Receptionist', 'Pharmacist', 'Doctor', 'Admin')) NOT NULL,
	[Username] NVARCHAR(255) UNIQUE,
	[Password] NVARCHAR(255),
	DayCreated DATETIME DEFAULT GETDATE(),
	Avatar NVARCHAR(255),
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	DOB DATE,
	Gender BIT DEFAULT 0,
	[Address] NVARCHAR(255),
	PhoneNumber NVARCHAR(15) UNIQUE,
	Email NVARCHAR(50) UNIQUE,
	[Hidden] BIT DEFAULT 0,
	YearExperience INT,
	SpecialtyID INT FOREIGN KEY REFERENCES Specialty(SpecialtyID)
);

CREATE TABLE Degree (
	DegreeID INT PRIMARY KEY IDENTITY(1,1),
	DegreeName NVARCHAR(255),
	Staff INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL
);

CREATE TABLE DoctorReview (
	DoctorReviewID INT PRIMARY KEY IDENTITY(1,1),
	AccountID INT FOREIGN KEY REFERENCES Account(AccountID) NOT NULL,
	DoctorID INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
	Content NVARCHAR(500),
	RateScore INT CHECK (RateScore BETWEEN 1 AND 5),
	DateCreate DATETIME DEFAULT GETDATE(),
	[Hidden] BIT DEFAULT 0,
);

CREATE TABLE Appointment (
	AppointmentID INT PRIMARY KEY IDENTITY(1,1),
	AccountID INT FOREIGN KEY REFERENCES Account(AccountID) NOT NULL,
	DoctorID INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
	AppointmentStatus NVARCHAR(50) DEFAULT 'Pending' CHECK (AppointmentStatus IN ('Pending', 'Confirmed', 'Approved', 'Completed', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	DateBegin DATETIME,
	DateEnd DATETIME,
	Note NVARCHAR(550),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Patient (
	AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID) NOT NULL,
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	DOB DATE CHECK(DOB < GETDATE()),
	Gender BIT DEFAULT 0
);

CREATE TABLE AppointmentInvoice (
	AppointmentInvoiceID INT PRIMARY KEY IDENTITY(1,1),
	AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID) NOT NULL,
	PaymentType NVARCHAR(50) CHECK (PaymentType IN ('Cash', 'Credit Card')),
	InvoiceStatus NVARCHAR(50) CHECK (InvoiceStatus IN ('Pending', 'Paid', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	DatePay DATETIME
);

CREATE TABLE Medicine (
	MedicineID INT PRIMARY KEY IDENTITY(1,1),
	MedicineType NVARCHAR(50) CHECK (MedicineType IN ('Tablet', 'Capsule', 'Syrup', 'Ointment', 'Drops')) NOT NULL,
	MedicineStatus BIT DEFAULT 0,
	MedicineName NVARCHAR(200),
	MedicineCode NVARCHAR(50) UNIQUE,
	Quantity INT DEFAULT 0 CHECK (Quantity >= 0),
	Price INT DEFAULT 0 CHECK (Price >= 0),
	DateCreate DATETIME DEFAULT GETDATE(),
	[Hidden] BIT DEFAULT 0
);

CREATE TABLE Prescription (
	PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
	PrescriptionStatus NVARCHAR(50) DEFAULT 'Pending' CHECK (PrescriptionStatus IN ('Pending', 'Delivered', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	Note NVARCHAR(550),
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

CREATE TABLE PrescriptionInvoice (
	PrescriptionInvoiceID INT PRIMARY KEY IDENTITY(1,1),
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID) NOT NULL,
	PaymentType NVARCHAR(50) CHECK (PaymentType IN ('Cash', 'Credit Card')),
	InvoiceStatus NVARCHAR(50) CHECK (InvoiceStatus IN ('Pending', 'Paid', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	DatePay DATETIME
);

GO
CREATE TRIGGER TR_MedicalRecord_CreateAppointmentInvoice
ON [dbo].[Appointment]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
    INSERT INTO [dbo].[AppointmentInvoice] (AppointmentID, InvoiceStatus)
		SELECT
        i.AppointmentID,
		'Pending'
		FROM INSERTED i;
END;

GO
CREATE TRIGGER TR_Medicine_UpdateMedicineStatus
ON [dbo].[Medicine]
AFTER UPDATE, INSERT
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
CREATE TRIGGER TR_Prescription_UpdateOutDatePrescriptionStatus
ON [dbo].[Prescription]
AFTER UPDATE, INSERT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE p
	SET p.PrescriptionStatus = 'Canceled'
		FROM inserted i
		JOIN [dbo].[Prescription] p
		ON p.PrescriptionID = i.PrescriptionID
		WHERE DATEDIFF(HOUR, p.DateCreate, GETDATE()) >= 24
		AND p.PrescriptionStatus = 'Pending';
END

GO
CREATE TRIGGER TR_Prescription_CreatePrescriptionInvoice
ON [dbo].[Prescription]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
    INSERT INTO [dbo].[PrescriptionInvoice] (PrescriptionID, InvoiceStatus)
		SELECT
        i.PrescriptionID,
		'Pending'
		FROM INSERTED i;
END

GO
CREATE TRIGGER TR_Prescription_UpdateCancelPrescriptionInvoice
ON [dbo].[PrescriptionInvoice]
AFTER UPDATE, INSERT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE p
	SET p.PrescriptionStatus = 'Canceled'
		FROM inserted i
		JOIN [dbo].[Prescription] p
		ON p.PrescriptionID = i.PrescriptionID
		WHERE i.InvoiceStatus = 'Canceled';

	UPDATE m
    SET m.Quantity = m.Quantity + pit.Dosage
		FROM Medicine m
		JOIN PrescriptionItem pit
		ON m.MedicineID = pit.MedicineID
		JOIN inserted i
		ON pit.PrescriptionID = i.PrescriptionID
		JOIN deleted d
		ON d.PrescriptionID = i.PrescriptionID
		WHERE i.InvoiceStatus = 'Canceled'
		AND d.InvoiceStatus <> 'Canceled';	
END

