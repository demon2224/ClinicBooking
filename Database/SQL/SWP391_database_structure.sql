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
	Bio TEXT,
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	DOB DATE,
	Gender BIT DEFAULT 0,
	UserAddress TEXT,
	PhoneNumber NVARCHAR(15) UNIQUE,
	Email NVARCHAR(50)
);

CREATE TABLE [Role] (
	RoleID INT PRIMARY KEY IDENTITY(1,1),
	RoleName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Staff (
	StaffID INT PRIMARY KEY IDENTITY(1,1),
	JobStatus VARCHAR(50) DEFAULT 'Unavailable' CHECK (JobStatus IN ('Unavailable', 'Available', 'Retired')) NOT NULL,
	RoleID INT FOREIGN KEY REFERENCES [Role](RoleID),
	AccountName NVARCHAR(255) UNIQUE,
	AccountPassword NVARCHAR(255),
	DayCreated DATETIME DEFAULT GETDATE(),
	Avatar NVARCHAR(255),
	Bio TEXT,
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	DOB DATE,
	Gender BIT DEFAULT 0,
	UserAddress TEXT,
	PhoneNumber NVARCHAR(15) UNIQUE,
	Email NVARCHAR(50)
);

CREATE TABLE Specialty (
	SpecialtyID INT PRIMARY KEY IDENTITY(1,1),
	SpecialtyName NVARCHAR(50)
);

CREATE TABLE Doctor (
	DoctorID INT PRIMARY KEY IDENTITY(1,1),
	StaffID INT FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
	SpecialtyID INT FOREIGN KEY REFERENCES Specialty(SpecialtyID),
	YearExperience INT
);

CREATE TABLE Degree (
	DegreeID INT PRIMARY KEY IDENTITY(1,1),
	DegreeName NVARCHAR(255)
);

CREATE TABLE DoctorDegree (
	DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID),
	DegreeID INT FOREIGN KEY REFERENCES Degree(DegreeID),
	PRIMARY KEY (DoctorID, DegreeID),
	DateEarn DATE,
	Grantor NVARCHAR(255)
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
	Content TEXT,
	RateScore INT,
	DateCreate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Appointment (
	AppointmentID INT PRIMARY KEY IDENTITY(1,1),
	PatientID INT FOREIGN KEY REFERENCES Patient(PatientID) NOT NULL,
	DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID) NOT NULL,
	AppointmentStatus NVARCHAR(50) DEFAULT 'Pending' CHECK (AppointmentStatus IN ('Pending', 'Approved', 'Completed', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	DateBegin DATETIME,
	DateEnd DATETIME,
	Note TEXT
);

CREATE TABLE Prescription (
	PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
	AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID) NOT NULL,
	PrescriptionStatus NVARCHAR(50) DEFAULT 'Pending' CHECK (PrescriptionStatus IN ('Pending', 'Delivered', 'Canceled')) NOT NULL,
	DateCreate DATETIME DEFAULT GETDATE(),
	Note TEXT
);

CREATE TABLE Medicine (
	MedicineID INT PRIMARY KEY IDENTITY(1,1),
	MedicineType NVARCHAR(50) CHECK (MedicineType IN ('Tablet', 'Capsule', 'Syrup', 'Ointment', 'Drops')) NOT NULL,
	MedicineStatus BIT DEFAULT 0,
	MedicineName NVARCHAR(200),
	MedicineCode NVARCHAR(100),
	Quantity INT DEFAULT 0,
	Price DECIMAL(20,2) DEFAULT 0,
	DateCreate DATETIME DEFAULT GETDATE()
);

CREATE TABLE PrescriptionItem (
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID),
	MedicineID INT FOREIGN KEY REFERENCES Medicine(MedicineID),
	PRIMARY KEY (PrescriptionID, MedicineID),
	Dosage INT NOT NULL CHECK(Dosage > 0),
	Instruction TEXT NOT NULL
);

CREATE TABLE MedicineStockTransaction (
	StockTransactionID INT PRIMARY KEY IDENTITY(1,1),
	MedicineID INT FOREIGN KEY REFERENCES Medicine(MedicineID),
	Quantity INT DEFAULT 0 CHECK (Quantity > 0),
	DateImport DATETIME DEFAULT GETDATE(),
	DateExpire DATETIME NOT NULL
);

CREATE TABLE ConsultationFee (
	ConsultationFeeID INT PRIMARY KEY IDENTITY(1,1),
    DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID),
	SpecialtyID INT FOREIGN KEY REFERENCES Specialty(SpecialtyID),
    Fee DECIMAL(20,2) DEFAULT 0 NOT NULL
);

CREATE TABLE MedicalRecord (
	MedicalRecordID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID) NOT NULL,
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID),
    Symptoms TEXT,
    Diagnosis TEXT,
    Note TEXT,
    DateCreate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
	MedicalRecordID INT FOREIGN KEY REFERENCES MedicalRecord(MedicalRecordID) NOT NULL,
	ConsultationFeeID INT FOREIGN KEY REFERENCES ConsultationFee(ConsultationFeeID) NOT NULL,
	PrescriptionID INT FOREIGN KEY REFERENCES Prescription(PrescriptionID),
	PaymentType NVARCHAR(50) CHECK (PaymentType IN ('Cash', 'Credit Card', 'Insurance', 'Online Banking', 'E-Wallet')) NOT NULL,
    InvoiceStatus NVARCHAR(50) CHECK (InvoiceStatus IN ('Pending', 'Paid', 'Canceled')) NOT NULL,
    DateCreate DATETIME DEFAULT GETDATE(),
	DatePay DATETIME
);
