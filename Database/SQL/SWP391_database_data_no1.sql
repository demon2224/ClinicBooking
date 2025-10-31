USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	-- 1. Specialties (10) - Không phụ thuộc
	INSERT INTO Specialty (SpecialtyName, Price) VALUES
	('General Practice', 60.00),
	('Cardiology', 120.00),
	('Dermatology', 90.00),
	('Pediatrics', 80.00),
	('Orthopedics', 110.00),
	('Neurology', 150.00),
	('Endocrinology', 100.00),
	('Ophthalmology', 95.00),
	('ENT', 85.00),
	('Psychiatry', 130.00);

	-- 2. PATIENTS (30) - Không phụ thuộc
	INSERT INTO Patient (AccountName, AccountPassword, Avatar, Bio, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
	('patient01','Pass@01',NULL,'No allergies','Alice','Brown','1985-03-12',0,'123 Elm St, Springfield','0901000001','alice.brown@example.com'),
	('patient02','Pass@02',NULL,'Diabetic','Bob','Smith','1978-07-04',1,'45 Oak Ave, Springfield','0901000002','bob.smith@example.com'),
	('patient03','Pass@03',NULL,'Asthma','Cathy','Johnson','1992-11-21',0,'78 Pine Rd, Springfield','0901000003','cathy.johnson@example.com'),
	('patient04','Pass@04',NULL,'Hypertension','David','Lee','1969-01-30',1,'9 Maple St, Springfield','0901000004','david.lee@example.com'),
	('patient05','Pass@05',NULL,'Pregnant','Emma','Garcia','1990-05-14',0,'12 Birch Ln, Springfield','0901000005','emma.garcia@example.com'),
	('patient06','Pass@06',NULL,'High cholesterol','Frank','Martinez','1982-12-08',1,'34 Cedar Blvd, Springfield','0901000006','frank.martinez@example.com'),
	('patient07','Pass@07',NULL,'Smoker','Grace','Lopez','1975-09-19',0,'56 Willow Way, Springfield','0901000007','grace.lopez@example.com'),
	('patient08','Pass@08',NULL,'None','Henry','Gonzalez','2000-02-02',1,'99 Aspen Dr, Springfield','0901000008','henry.gonzalez@example.com'),
	('patient09','Pass@09',NULL,'Allergic to penicillin','Ivy','Wilson','1988-08-08',0,'101 Poplar Cir, Springfield','0901000009','ivy.wilson@example.com'),
	('patient10','Pass@10',NULL,'Seasonal allergies','Jack','Anderson','1995-06-15',1,'121 Spruce St, Springfield','0901000010','jack.anderson@example.com'),
	('patient11','Pass@11',NULL,'Caregiver','Karen','Thomas','1960-04-02',0,'3 River Rd, Springfield','0901000011','karen.thomas@example.com'),
	('patient12','Pass@12',NULL,'Teen patient','Leo','Taylor','2008-10-12',1,'7 Hill St, Springfield','0901000012','leo.taylor@example.com'),
	('patient13','Pass@13',NULL,'Frequent traveler','Mia','Moore','1987-09-01',0,'22 Lakeview, Springfield','0901000013','mia.moore@example.com'),
	('patient14','Pass@14',NULL,'Insulin user','Noah','Jackson','1970-03-03',1,'17 Forest Ln, Springfield','0901000014','noah.jackson@example.com'),
	('patient15','Pass@15',NULL,'Vegetarian','Olivia','Martin','1993-12-12',0,'88 Meadow Rd, Springfield','0901000015','olivia.martin@example.com'),
	('patient16','Pass@16',NULL,'Recovering fracture','Peter','Clark','1989-11-11',1,'77 Ridge St, Springfield','0901000016','peter.clark@example.com'),
	('patient17','Pass@17',NULL,'Chronic migraines','Quinn','Rodriguez','1986-02-20',0,'65 Valley Rd, Springfield','0901000017','quinn.rodriguez@example.com'),
	('patient18','Pass@18',NULL,'Glaucoma history','Rachel','Lewis','1976-07-07',0,'44 Park Ave, Springfield','0901000018','rachel.lewis@example.com'),
	('patient19','Pass@19',NULL,'Hearing loss','Steve','Walker','1958-05-05',1,'5 Ocean Dr, Springfield','0901000019','steve.walker@example.com'),
	('patient20','Pass@20',NULL,'Skin rash','Tina','Hall','1999-09-09',0,'200 Hilltop, Springfield','0901000020','tina.hall@example.com'),
	('patient21','Pass@21',NULL,'Back pain','Uma','Allen','1983-01-01',0,'33 Beacon St, Springfield','0901000021','uma.allen@example.com'),
	('patient22','Pass@22',NULL,'Anxiety','Victor','Young','1991-04-04',1,'66 Central Ave, Springfield','0901000022','victor.young@example.com'),
	('patient23','Pass@23',NULL,'High BMI','Wendy','Hernandez','1984-06-06',0,'11 Garden Rd, Springfield','0901000023','wendy.hernandez@example.com'),
	('patient24','Pass@24',NULL,'Post-op care','Xavier','King','1977-02-02',1,'19 Harbor St, Springfield','0901000024','xavier.king@example.com'),
	('patient25','Pass@25',NULL,'Allergic to nuts','Yara','Wright','1996-10-10',0,'55 Summit Ave, Springfield','0901000025','yara.wright@example.com'),
	('patient26','Pass@26',NULL,'Thyroid issues','Zack','Loft','1981-08-18',1,'6 Sunset Blvd, Springfield','0901000026','zack.loft@example.com'),
	('patient27','Pass@27',NULL,'HIV negative','Amy','Reed','1994-04-09',0,'42 Beacon Rd, Springfield','0901000027','amy.reed@example.com'),
	('patient28','Pass@28',NULL,'Frequent colds','Ben','Cook','1998-12-03',1,'73 Pinecrest, Springfield','0901000028','ben.cook@example.com'),
	('patient29','Pass@29',NULL,'Smoker recovery','Clara','Morgan','1980-03-30',0,'8 Glen St, Springfield','0901000029','clara.morgan@example.com'),
	('patient30','Pass@30',NULL,'Hepatitis B vaccinated','Derek','Bell','1972-11-02',1,'90 Cliff Rd, Springfield','0901000030','derek.bell@example.com');

	-- 3. STAFF (30) - Không phụ thuộc
	-- Doctor Staff IDs: 1-10, 26, 27
	INSERT INTO Staff (JobStatus, [Role], AccountName, AccountPassword, Avatar, Bio, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
	('Available','Doctor','staff_doc01','Doc@01',NULL,'Cardiologist','Aaron','Mills','1975-02-02',1,'10 Staff Lane','0911000001','aaron.mills@clinic.com'), -- ID 1
	('Available','Doctor','staff_doc02','Doc@02',NULL,'Dermatologist','Bella','Reed','1980-03-03',0,'11 Staff Lane','0911000002','bella.reed@clinic.com'), -- ID 2
	('Available','Doctor','staff_doc03','Doc@03',NULL,'Pediatrician','Carl','Perry','1978-04-04',1,'12 Staff Lane','0911000003','carl.perry@clinic.com'), -- ID 3
	('Available','Doctor','staff_doc04','Doc@04',NULL,'Orthopedist','Dana','Kim','1972-05-05',0,'13 Staff Lane','0911000004','dana.kim@clinic.com'), -- ID 4
	('Available','Doctor','staff_doc05','Doc@05',NULL,'Neurologist','Evan','Stone','1968-06-06',1,'14 Staff Lane','0911000005','evan.stone@clinic.com'), -- ID 5
	('Available','Doctor','staff_doc06','Doc@06',NULL,'Endocrinologist','Fiona','Grant','1982-07-07',0,'15 Staff Lane','0911000006','fiona.grant@clinic.com'), -- ID 6
	('Available','Doctor','staff_doc07','Doc@07',NULL,'Ophthalmologist','George','Nash','1976-08-08',1,'16 Staff Lane','0911000007','george.nash@clinic.com'), -- ID 7
	('Available','Doctor','staff_doc08','Doc@08',NULL,'ENT Specialist','Hannah','Cole','1983-09-09',0,'17 Staff Lane','0911000008','hannah.cole@clinic.com'), -- ID 8
	('Available','Doctor','staff_doc09','Doc@09',NULL,'Psychiatrist','Ian','Frost','1974-10-10',1,'18 Staff Lane','0911000009','ian.frost@clinic.com'), -- ID 9
	('Available','Doctor','staff_doc10','Doc@10',NULL,'General Practitioner','Jane','Wells','1985-11-11',0,'19 Staff Lane','0911000010','jane.wells@clinic.com'), -- ID 10

	('Available','Pharmacist','staff_ph01','Pharm@01',NULL,'Senior pharmacist','Karl','Fox','1984-01-01',1,'20 Staff Lane','0911000011','karl.fox@clinic.com'), -- ID 11
	('Available','Pharmacist','staff_ph02','Pharm@02',NULL,'Pharmacist','Lena','Bell','1990-02-02',0,'21 Staff Lane','0911000012','lena.bell@clinic.com'), -- ID 12
	('Available','Pharmacist','staff_ph03','Pharm@03',NULL,'Pharmacist','Mark','Stone','1986-03-03',1,'22 Staff Lane','0911000013','mark.stone@clinic.com'), -- ID 13
	('Available','Pharmacist','staff_ph04','Pharm@04',NULL,'Pharmacy assistant','Nina','Hayes','1992-04-04',0,'23 Staff Lane','0911000014','nina.hayes@clinic.com'), -- ID 14
	('Available','Pharmacist','staff_ph05','Pharm@05',NULL,'Pharmacist','Oscar','Rey','1988-05-05',1,'24 Staff Lane','0911000015','oscar.rey@clinic.com'), -- ID 15

	('Available','Receptionist','staff_rec01','Rec@01',NULL,'Front desk','Paula','Grant','1991-06-06',0,'25 Staff Lane','0911000016','paula.grant@clinic.com'), -- ID 16
	('Available','Receptionist','staff_rec02','Rec@02',NULL,'Front desk','Quinn','Baker','1993-07-07',1,'26 Staff Lane','0911000017','quinn.baker@clinic.com'), -- ID 17
	('Available','Receptionist','staff_rec03','Rec@03',NULL,'Front desk','Rita','Young','1994-08-08',0,'27 Staff Lane','0911000018','rita.young@clinic.com'), -- ID 18
	('Available','Receptionist','staff_rec04','Rec@04',NULL,'Front desk','Sam','Lopez','1995-09-09',1,'28 Staff Lane','0911000019','sam.lopez@clinic.com'), -- ID 19
	('Available','Receptionist','staff_rec05','Rec@05',NULL,'Front desk','Tara','Fox','1989-10-10',0,'29 Staff Lane','0911000020','tara.fox@clinic.com'), -- ID 20

	('Available','Admin','staff_admin01','Adm@01',NULL,'Administrator','Uma','Grant','1980-11-11',0,'30 Staff Lane','0911000021','uma.grant@clinic.com'), -- ID 21
	('Available','Admin','staff_admin02','Adm@02',NULL,'IT Admin','Victor','Kim','1983-12-12',1,'31 Staff Lane','0911000022','victor.kim@clinic.com'), -- ID 22
	('Available','Admin','staff_admin03','Adm@03',NULL,'Billing Admin','Wendy','Lopez','1979-01-13',0,'32 Staff Lane','0911000023','wendy.lopez@clinic.com'), -- ID 23
	('Available','Admin','staff_admin04','Adm@04',NULL,'HR Admin','Xavier','Stone','1972-02-14',1,'33 Staff Lane','0911000024','xavier.stone@clinic.com'), -- ID 24
	('Available','Admin','staff_admin05','Adm@05',NULL,'Records Admin','Yara','Hill','1987-03-15',0,'34 Staff Lane','0911000025','yara.hill@clinic.com'), -- ID 25

	('Available','Doctor','staff_doc11','Doc@11',NULL,'Visiting specialist','Zack','Morse','1971-04-16',1,'35 Staff Lane','0911000026','zack.morse@clinic.com'), -- ID 26
	('Available','Doctor','staff_doc12','Doc@12',NULL,'Visiting specialist','Ava','Noel','1986-05-17',0,'36 Staff Lane','0911000027','ava.noel@clinic.com'), -- ID 27
	('Available','Pharmacist','staff_ph06','Pharm@06',NULL,'Pharmacist','Ben','Carter','1991-06-18',1,'37 Staff Lane','0911000028','ben.carter@clinic.com'), -- ID 28
	('Available','Receptionist','staff_rec06','Rec@06',NULL,'Reception','Cara','Miles','1992-07-19',0,'38 Staff Lane','0911000029','cara.miles@clinic.com'), -- ID 29
	('Available','Admin','staff_admin06','Adm@06',NULL,'Finance','Drew','Yates','1985-08-20',1,'39 Staff Lane','0911000030','drew.yates@clinic.com'); -- ID 30

	-- 4. DOCTORS (12 Doctors) - Phụ thuộc vào Staff (StaffID) và Specialty (SpecialtyID)
	-- Specialty IDs: 1:General Practice, 2:Cardiology, 3:Dermatology, 4:Pediatrics, 5:Orthopedics, 6:Neurology, 7:Endocrinology, 8:Ophthalmology, 9:ENT, 10:Psychiatry
	INSERT INTO Doctor (StaffID, SpecialtyID, YearExperience) VALUES
	(1,2,15),  -- DoctorID 1: Aaron Mills (Staff ID 1) - Cardiology (2)
	(2,3,12),  -- DoctorID 2: Bella Reed (Staff ID 2) - Dermatology (3)
	(3,4,8),   -- DoctorID 3: Carl Perry (Staff ID 3) - Pediatrics (4)
	(4,5,20),  -- DoctorID 4: Dana Kim (Staff ID 4) - Orthopedics (5)
	(5,6,18),  -- DoctorID 5: Evan Stone (Staff ID 5) - Neurology (6)
	(6,7,10),  -- DoctorID 6: Fiona Grant (Staff ID 6) - Endocrinology (7)
	(7,8,14),  -- DoctorID 7: George Nash (Staff ID 7) - Ophthalmology (8)
	(8,9,9),   -- DoctorID 8: Hannah Cole (Staff ID 8) - ENT (9)
	(9,10,11), -- DoctorID 9: Ian Frost (Staff ID 9) - Psychiatry (10)
	(10,1,6),  -- DoctorID 10: Jane Wells (Staff ID 10) - General Practice (1)
	(26,2,7),  -- DoctorID 11: Zack Morse (Staff ID 26) - Cardiology (2)
	(27,4,5);  -- DoctorID 12: Ava Noel (Staff ID 27) - Pediatrics (4)

	-- 5. DEGREES (42 entries) - Phụ thuộc vào Doctor (DoctorID)
	-- *SỬA LỖI: Chèn trực tiếp với DoctorID chính xác sau khi Doctor đã được chèn*
	INSERT INTO Degree (DegreeName, DoctorID) VALUES
	-- Doctor 1: Aaron Mills (Cardiology) - 5 degrees
	('MD', 1),
	('PhD Medicine', 1),
	('Diploma in Cardiology', 1),
	('MSc Clinical Cardiology', 1),
	('Board Certified in Internal Medicine', 1),
	-- Doctor 2: Bella Reed (Dermatology) - 4 degrees
	('MBBS', 2),
	('Diploma in Dermatology', 2),
	('Fellowship in Cosmetic Dermatology', 2),
	('Certificate in Skin Cancer Screening', 2),
	-- Doctor 3: Carl Perry (Pediatrics) - 4 degrees
	('MD', 3),
	('Fellowship Pediatrics', 3),
	('Master of Public Health (MPH)', 3),
	('Certificate in Neonatal Care', 3),
	-- Doctor 4: Dana Kim (Orthopedics) - 4 degrees
	('Master of Surgery', 4),
	('Sports Medicine Fellowship', 4),
	('Diploma in Joint Replacement Surgery', 4),
	('Certified in Trauma Surgery', 4),
	-- Doctor 5: Evan Stone (Neurology) - 4 degrees
	('MD', 5),
	('Certificate in Neurology', 5),
	('Fellowship in Stroke Management', 5),
	('Board Certification in Clinical Neurophysiology', 5),
	-- Doctor 6: Fiona Grant (Endocrinology) - 4 degrees
	('MBBS', 6),
	('Master of Science in Diabetes Management', 6),
	('Clinical Fellowship in Thyroid Disorders', 6),
	('Certified Diabetes Educator', 6),
	-- Doctor 7: George Nash (Ophthalmology) - 4 degrees
	('MD', 7),
	('Residency in Ophthalmic Surgery', 7),
	('Certification in Refractive Surgery', 7),
	('Fellowship in Vitreoretinal Surgery', 7),
	-- Doctor 8: Hannah Cole (ENT) - 4 degrees
	('Doctor of Osteopathy', 8),
	('Fellowship in Rhinology', 8),
	('Diploma in Head and Neck Surgery', 8),
	('Certified in Otology', 8),
	-- Doctor 9: Ian Frost (Psychiatry) - 4 degrees
	('MD', 9),
	('Fellowship in Child and Adolescent Psychiatry', 9),
	('Certification in Addiction Medicine', 9),
	('Certified in Cognitive Behavioral Therapy (CBT)', 9),
	-- Doctor 10: Jane Wells (General Practice) - 4 degrees
	('MBBS', 10),
	('Master of Advanced Clinical Practice', 10),
	('Certification in Travel Medicine', 10),
	('Diploma in Public Health', 10),
	-- Doctor 11: Zack Morse (Cardiology) - 3 degrees
	('MD', 11),
	('Fellowship in Interventional Cardiology', 11),
	('Advanced Cardiac Life Support (ACLS) Instructor', 11),
	-- Doctor 12: Ava Noel (Pediatrics) - 4 degrees
	('MD', 12),
	('Diploma in Tropical Pediatrics', 12),
	('Certified Pediatric Advanced Life Support (PALS)', 12),
	('Certified in Pediatric Nutrition', 12);
	
	-- **BỎ QUA KHỐI UPDATE BẰNG CẤP LỖI**

	-- 6. RECEPTIONISTS (6) - Phụ thuộc vào Staff (StaffID)
	INSERT INTO Receptionist (StaffID) VALUES (16),(17),(18),(19),(20),(29);

	-- 7. PHARMACISTS (6) - Phụ thuộc vào Staff (StaffID)
	INSERT INTO Pharmacist (StaffID) VALUES (11),(12),(13),(14),(15),(28);

	-- 8. MEDICINES (30) - Không phụ thuộc
	INSERT INTO Medicine (MedicineType, MedicineStatus, MedicineName, MedicineCode, Quantity, Price)
	VALUES
	('Tablet',1,'Paracetamol 500mg','MED-PARA-500',200,1.50), -- ID 1
	('Capsule',1,'Amoxicillin 500mg','MED-AMOX-500',150,2.25), -- ID 2
	('Syrup',1,'Cough Syrup 100ml','MED-COUGH-100',80,4.50), -- ID 3
	('Ointment',1,'Hydrocortisone 1%','MED-HYDRO-1',60,3.00), -- ID 4
	('Drops',1,'Eye Drops 10ml','MED-EYE-10',50,5.50), -- ID 5
	('Tablet',1,'Ibuprofen 200mg','MED-IBU-200',180,1.75), -- ID 6
	('Capsule',1,'Omeprazole 20mg','MED-OMEP-20',120,6.00), -- ID 7
	('Tablet',1,'Aspirin 81mg','MED-ASP-81',300,0.90), -- ID 8
	('Capsule',1,'Metformin 500mg','MED-MET-500',160,2.10), -- ID 9
	('Tablet',1,'Loratadine 10mg','MED-LORA-10',140,1.20), -- ID 10
	('Syrup',1,'Children Multivitamin','MED-MULTI-100',90,7.50), -- ID 11
	('Tablet',1,'Prednisone 10mg','MED-PRED-10',50,2.80), -- ID 12
	('Capsule',1,'Doxycycline 100mg','MED-DOXY-100',70,3.60), -- ID 13
	('Ointment',1,'Antifungal Cream','MED-AF-50',40,4.00), -- ID 14
	('Drops',1,'Ear Drops 10ml','MED-EAR-10',30,6.50), -- ID 15
	('Tablet',1,'Clopidogrel 75mg','MED-CLOP-75',60,8.00), -- ID 16
	('Capsule',1,'Levothyroxine 50mcg','MED-LEVO-50',90,3.20), -- ID 17
	('Tablet',1,'Zinc Supplement 50mg','MED-ZINC-50',200,1.10), -- ID 18
	('Capsule',1,'Fluconazole 150mg','MED-FLU-150',45,5.60), -- ID 19
	('Syrup',1,'Antacid Syrup','MED-Acid-100',110,3.90), -- ID 20
	('Tablet',1,'Losartan 50mg','MED-LOS-50',75,2.70), -- ID 21
	('Capsule',1,'Albuterol 2mg','MED-ALB-2',100,4.40), -- ID 22
	('Tablet',1,'Vitamin D 1000IU','MED-VD-1000',210,1.30), -- ID 23
	('Capsule',1,'Nitrofurantoin 100mg','MED-NIT-100',55,4.80), -- ID 24
	('Tablet',1,'Tramadol 50mg','MED-TRAM-50',35,6.75), -- ID 25
	('Ointment',1,'Antiseptic Ointment','MED-ANT-30',40,2.50), -- ID 26
	('Drops',1,'Nasal Drops 15ml','MED-NAS-15',65,3.30), -- ID 27
	('Capsule',1,'Gabapentin 300mg','MED-GABA-300',25,7.20), -- ID 28
	('Tablet',1,'Hydrochlorothiazide 25mg','MED-HCTZ-25',120,1.90), -- ID 29
	('Capsule',1,'Clarithromycin 500mg','MED-CLA-500',50,5.00); -- ID 30

	-- 9. APPOINTMENTS (30) - Phụ thuộc vào Patient (PatientID) và Doctor (DoctorID)
	INSERT INTO Appointment (PatientID, DoctorID, AppointmentStatus, DateCreate, DateBegin, DateEnd, Note)
	VALUES
	(1,1,'Completed','2025-05-01','2025-05-01 09:00','2025-05-01 09:20','Routine check'), -- ID 1
	(2,1,'Completed','2025-05-02','2025-05-02 10:00','2025-05-02 10:30','Chest pain follow-up'), -- ID 2
	(3,2,'Completed','2025-05-03','2025-05-03 11:00','2025-05-03 11:20','Skin rash'), -- ID 3
	(4,3,'Completed','2025-05-04','2025-05-04 09:30','2025-05-04 09:50','Child fever'), -- ID 4
	(5,4,'Completed','2025-05-05','2025-05-05 14:00','2025-05-05 14:20','Knee pain'), -- ID 5
	(6,5,'Completed','2025-05-06','2025-05-06 15:00','2025-05-06 15:25','Headache review'), -- ID 6
	(7,6,'Completed','2025-05-07','2025-05-07 08:30','2025-05-07 08:50','Diabetes review'), -- ID 7
	(8,7,'Approved','2025-05-08','2025-05-10 10:00','2025-05-10 10:20','Eye check'), -- ID 8
	(9,8,'Pending','2025-05-09','2025-05-15 11:00','2025-05-15 11:15','Ear pain'), -- ID 9
	(10,9,'Completed','2025-05-10','2025-05-10 16:00','2025-05-10 16:25','Mental health follow-up'), -- ID 10
	(11,10,'Completed','2025-05-11','2025-05-11 09:10','2025-05-11 09:25','Blood pressure'), -- ID 11
	(12,2,'Completed','2025-05-12','2025-05-12 10:15','2025-05-12 10:35','Acne treatment'), -- ID 12
	(13,3,'Completed','2025-05-13','2025-05-13 11:30','2025-05-13 11:45','Child vaccination'), -- ID 13
	(14,4,'Completed','2025-05-14','2025-05-14 14:40','2025-05-14 14:55','Fracture check'), -- ID 14
	(15,5,'Completed','2025-05-15','2025-05-15 15:50','2025-05-15 16:10','Neurology consult'), -- ID 15
	(16,10,'Canceled','2025-05-16','2025-05-20 08:00','2025-05-20 08:15','Patient canceled'), -- ID 16
	(17,7,'Completed','2025-05-17','2025-05-17 09:00','2025-05-17 09:20','Cataract review'), -- ID 17
	(18,8,'Completed','2025-05-18','2025-05-18 10:10','2025-05-18 10:30','Sinusitis'), -- ID 18
	(19,9,'Completed','2025-05-19','2025-05-19 11:00','2025-05-19 11:25','Depression check'), -- ID 19
	(20,10,'Completed','2025-05-20','2025-05-20 12:00','2025-05-20 12:20','General check'), -- ID 20
	(21,1,'Completed','2025-05-21','2025-05-21 09:15','2025-05-21 09:35','Follow up'), -- ID 21
	(22,2,'Completed','2025-05-22','2025-05-22 10:05','2025-05-22 10:25','Skin follow-up'), -- ID 22
	(23,3,'Completed','2025-05-23','2025-05-23 11:05','2025-05-23 11:25','Pediatric review'), -- ID 23
	(24,4,'Completed','2025-05-24','2025-05-24 14:05','2025-05-24 14:25','Orthopedic therapy'), -- ID 24
	(25,5,'Completed','2025-05-25','2025-05-25 15:05','2025-05-25 15:30','Neuro follow-up'), -- ID 25
	(26,6,'Completed','2025-05-26','2025-05-26 08:45','2025-05-26 09:05','Endocrine consult'), -- ID 26
	(27,7,'Pending','2025-05-27','2025-06-01 10:00','2025-06-01 10:20','Eye symptoms'), -- ID 27
	(28,8,'Approved','2025-05-28','2025-06-03 11:00','2025-06-03 11:30','ENT check'), -- ID 28
	(29,9,'Completed','2025-05-29','2025-05-29 12:00','2025-05-29 12:25','Psych consult'), -- ID 29
	(30,10,'Completed','2025-05-30','2025-05-30 13:00','2025-05-30 13:20','General exam'); -- ID 30

	-- 10. PRESCRIPTIONS (30) - Phụ thuộc vào Appointment (AppointmentID)
	INSERT INTO Prescription (AppointmentID, PrescriptionStatus, DateCreate, Note)
	VALUES
	(1,'Delivered','2025-05-01','Paracetamol for fever'), -- ID 1
	(2,'Delivered','2025-05-02','Antibiotics x7 days'), -- ID 2
	(3,'Delivered','2025-05-03','Topical cream'), -- ID 3
	(4,'Delivered','2025-05-04','Pediatric syrup'), -- ID 4
	(5,'Delivered','2025-05-05','Anti-inflammatory'), -- ID 5
	(6,'Delivered','2025-05-06','Migraine meds'), -- ID 6
	(7,'Delivered','2025-05-07','Diabetes meds refill'), -- ID 7
	(8,'Pending','2025-05-08','Eye drops to be approved'), -- ID 8
	(9,'Pending','2025-05-09','Ear antibiotics pending'), -- ID 9
	(10,'Delivered','2025-05-10','Mood stabilizer'), -- ID 10
	(11,'Delivered','2025-05-11','BP medication'), -- ID 11
	(12,'Delivered','2025-05-12','Acne tablets'), -- ID 12
	(13,'Delivered','2025-05-13','Vaccination record'), -- ID 13
	(14,'Delivered','2025-05-14','Analgesics for pain'), -- ID 14
	(15,'Delivered','2025-05-15','Neuro meds'), -- ID 15
	(16,'Canceled','2025-05-16','Canceled by patient'), -- ID 16 (Associated with Appt 16 Canceled)
	(17,'Delivered','2025-05-17','Eye drops post-op'), -- ID 17
	(18,'Delivered','2025-05-18','Antibiotics for sinus'), -- ID 18
	(19,'Delivered','2025-05-19','Antidepressant refill'), -- ID 19
	(20,'Delivered','2025-05-20','General multivitamin'), -- ID 20
	(21,'Delivered','2025-05-21','Follow up prescription'), -- ID 21
	(22,'Delivered','2025-05-22','Skin ointments'), -- ID 22
	(23,'Delivered','2025-05-23','Pediatric meds'), -- ID 23
	(24,'Delivered','2025-05-24','Joint pain meds'), -- ID 24
	(25,'Delivered','2025-05-25','Neuro supplement'), -- ID 25
	(26,'Delivered','2025-05-26','Thyroid medication'), -- ID 26
	(27,'Pending','2025-05-27','Eye prescription pending'), -- ID 27
	(28,'Pending','2025-05-28','ENT follow-up'), -- ID 28
	(29,'Delivered','2025-05-29','Psych medication'), -- ID 29
	(30,'Delivered','2025-05-30','Routine meds'); -- ID 30

	-- 11. PRESCRIPTION ITEMS - Phụ thuộc vào Prescription (PrescriptionID) và Medicine (MedicineID)
	-- Medicine IDs: 1:Paracetamol, 2:Amoxicillin, 3:Cough Syrup, 4:Hydrocortisone, 5:Eye Drops, 6:Ibuprofen, 9:Metformin, 10:Loratadine, 11:Children Multivitamin, 12:Prednisone, 13:Doxycycline, 14:Antifungal Cream, 17:Levothyroxine, 18:Zinc, 20:Antacid, 21:Losartan, 22:Albuterol, 23:Vitamin D, 24:Nitrofurantoin, 25:Tramadol, 28:Gabapentin
	INSERT INTO PrescriptionItem (PrescriptionID, MedicineID, Dosage, Instruction) VALUES
	(1,1,2,'Take 2 tablets every 6 hours as needed for fever'), -- Paracetamol
	(1,22,1,'Take one capsule daily'), -- Albuterol
	(2,2,1,'One capsule every 8 hours for 7 days'), -- Amoxicillin
	(2,11,1,'Take multivitamin once daily'), -- Multivitamin
	(2,6,1,'Ibuprofen if needed'), -- Ibuprofen (Extra)
	(3,14,2,'Apply twice daily to affected area'), -- Antifungal Cream (Used instead of Hydrocortisone ID 4 - Assuming it's the topical cream)
	(3,9,1,'Metformin (if diabetic)'), -- Metformin (Extra)
	(4,3,5,'5ml twice daily for 5 days'), -- Cough Syrup
	(5,6,1,'Take one tablet every 8 hours after meals'), -- Ibuprofen
	(5,12,1,'Prednisone short course'), -- Prednisone (Extra)
	(6,28,1,'Gabapentin 300mg at night'), -- Gabapentin
	(7,9,1,'Metformin one capsule twice daily'), -- Metformin
	(7,20,1,'Antacid if needed'), -- Antacid (Extra)
	(8,5,1,'Eye drops one drop each eye 3x daily'), -- Eye Drops
	(9,2,1,'Amoxicillin one capsule 3x daily'), -- Amoxicillin
	(10,28,1,'Gabapentin 300mg at night'), -- Gabapentin
	(11,21,1,'Losartan 50mg once daily'), -- Losartan
	(11,8,1,'Aspirin low dose'), -- Aspirin (Extra)
	(12,10,1,'Loratadine once daily'), -- Loratadine
	(13,11,1,'Children vitamin syrup 5ml daily'), -- Multivitamin
	(14,6,1,'Ibuprofen 200mg as needed'), -- Ibuprofen
	(14,25,1,'Tramadol if severe pain'), -- Tramadol (Extra)
	(15,28,1,'Gabapentin 300mg daily'), -- Gabapentin
	(15,17,1,'Levothyroxine per lab orders'), -- Levothyroxine
	(15,24,1,'Nitrofurantoin for UTI'), -- Nitrofurantoin (Extra)
	(17,5,1,'Eye drops as directed'), -- Eye Drops
	(18,2,1,'Amoxicillin one capsule 3x daily'), -- Amoxicillin
	(19,28,1,'Gabapentin per psychiatrist'), -- Gabapentin
	(19,10,1,'Loratadine for allergies'), -- Loratadine (Extra)
	(20,23,1,'Vitamin D once daily'), -- Vitamin D
	(21,1,2,'Paracetamol 2 tablets if needed'), -- Paracetamol
	(22,14,2,'Apply ointment twice daily'), -- Antifungal Cream
	(23,3,5,'Children syrup as prescribed'), -- Cough Syrup
	(24,6,1,'Ibuprofen as needed'), -- Ibuprofen
	(24,13,1,'Doxycycline for infection'), -- Doxycycline (Extra)
	(25,18,1,'Zinc supplement once daily'), -- Zinc
	(26,17,1,'Levothyroxine per doctor'), -- Levothyroxine
	(29,28,1,'Gabapentin per psychiatry'), -- Gabapentin
	(29,1,2,'Paracetamol PRN'), -- Paracetamol (Extra)
	(30,1,1,'Paracetamol 1-2 tablets for pain'); -- Paracetamol

	-- 12. MEDICAL RECORDS (30) - Phụ thuộc vào Appointment (AppointmentID) và Prescription (PrescriptionID)
	-- PrescriptionID có thể là NULL (Nếu DDL cho phép)
	INSERT INTO MedicalRecord (AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note, DateCreate)
	VALUES
	(1,1,'Fever, sore throat','Viral infection','Advised rest and fluids','2025-05-01'), -- Appt 1, Pres 1
	(2,2,'Chest discomfort','Stable angina','EKG done; refill prescribed','2025-05-02'), -- Appt 2, Pres 2
	(3,3,'Rash','Contact dermatitis','Avoid allergen','2025-05-03'), -- Appt 3, Pres 3
	(4,4,'Child fever','Viral illness','Paracetamol given','2025-05-04'), -- Appt 4, Pres 4
	(5,5,'Knee pain','Sprain','Physical therapy referral','2025-05-05'), -- Appt 5, Pres 5
	(6,6,'Migraine','Migraine','New med started','2025-05-06'), -- Appt 6, Pres 6
	(7,7,'High sugar','Type 2 Diabetes','Dose adjusted','2025-05-07'), -- Appt 7, Pres 7
	(8,8,'Eye irritation','Conjunctivitis','Pending delivery of drops','2025-05-08'), -- Appt 8, Pres 8 (Pending)
	(9,9,'Ear pain','Otitis media','Await prescription approval','2025-05-09'), -- Appt 9, Pres 9 (Pending)
	(10,10,'Anxiety','Generalized anxiety disorder','Therapy referral','2025-05-10'), -- Appt 10, Pres 10
	(11,11,'High BP','Hypertension','BP meds adjusted','2025-05-11'), -- Appt 11, Pres 11
	(12,12,'Acne','Acne vulgaris','Topical+oral plan','2025-05-12'), -- Appt 12, Pres 12
	(13,13,'Well child','Healthy','Vaccination recorded','2025-05-13'), -- Appt 13, Pres 13
	(14,14,'Post fracture review','Healing fracture','Continue physiotherapy','2025-05-14'), -- Appt 14, Pres 14
	(15,15,'Numbness','Peripheral neuropathy','Electrodiagnostic planned','2025-05-15'), -- Appt 15, Pres 15
	(16,16,'Canceled appointment','N/A','No record','2025-05-16'), -- Appt 16 (Canceled), Pres 16 (Canceled)
	(17,17,'Post-op eye','Post-op status','Eye drops prescribed','2025-05-17'), -- Appt 17, Pres 17
	(18,18,'Sinus pain','Sinusitis','Antibiotic given','2025-05-18'), -- Appt 18, Pres 18
	(19,19,'Low mood','Major depression','Medication optimized','2025-05-19'), -- Appt 19, Pres 19
	(20,20,'Routine','Healthy','No issues','2025-05-20'), -- Appt 20, Pres 20
	(21,21,'Follow up','Stable','Continue meds','2025-05-21'), -- Appt 21, Pres 21
	(22,22,'Skin follow-up','Resolved','Stop ointment','2025-05-22'), -- Appt 22, Pres 22
	(23,23,'Pediatric check','Well child','Advised nutrition','2025-05-23'), -- Appt 23, Pres 23
	(24,24,'Joint pain','Arthritis','Start NSAID','2025-05-24'), -- Appt 24, Pres 24
	(25,25,'Neuro follow-up','Stable','Continue supplement','2025-05-25'), -- Appt 25, Pres 25
	(26,26,'Thyroid','Hypothyroidism','Dose stable','2025-05-26'), -- Appt 26, Pres 26
	(27,27,'Eye blurry','Possible refractive error','Appointment pending','2025-05-27'), -- Appt 27 (Pending), Pres 27 (Pending)
	(28,28,'ENT complaint','Chronic rhinitis','Further tests scheduled','2025-05-28'), -- Appt 28 (Approved), Pres 28 (Pending)
	(29,29,'Psych follow-up','Stable on meds','Monitor side effects','2025-05-29'), -- Appt 29, Pres 29
	(30,30,'Routine','Healthy','Annual exam','2025-05-30'); -- Appt 30, Pres 30

	-- 13. INVOICES (30) - Phụ thuộc vào MedicalRecord (MedicalRecordID) và Prescription (PrescriptionID)
	-- *SỬA LỖI: Invoice ID 16 phải tham chiếu đến MedicalRecordID 16.*
	INSERT INTO Invoice (MedicalRecordID, PrescriptionID, PaymentType, InvoiceStatus, DateCreate, DatePay)
	VALUES
	(1,1,'Cash','Paid','2025-05-01','2025-05-01'),
	(2,2,'Credit Card','Paid','2025-05-02','2025-05-02'),
	(3,3,'E-Wallet','Paid','2025-05-03','2025-05-03'),
	(4,4,'Cash','Paid','2025-05-04','2025-05-04'),
	(5,5,'Insurance','Paid','2025-05-05','2025-05-06'),
	(6,6,'Credit Card','Paid','2025-05-06','2025-05-06'),
	(7,7,'Cash','Paid','2025-05-07','2025-05-07'),
	(8,8,'Cash','Pending','2025-05-08',NULL), -- MR 8, Pres 8 (Pending)
	(9,9,'Cash','Pending','2025-05-09',NULL), -- MR 9, Pres 9 (Pending)
	(10,10,'Credit Card','Paid','2025-05-10','2025-05-10'),
	(11,11,'E-Wallet','Paid','2025-05-11','2025-05-11'),
	(12,12,'Cash','Paid','2025-05-12','2025-05-12'),
	(13,13,'Insurance','Paid','2025-05-13','2025-05-13'),
	(14,14,'Credit Card','Paid','2025-05-14','2025-05-14'),
	(15,15,'Cash','Paid','2025-05-15','2025-05-15'),
	(16,16,'Cash','Canceled','2025-05-16',NULL), -- MR 16, Pres 16 (Canceled)
	(17,17,'Credit Card','Paid','2025-05-17','2025-05-17'),
	(18,18,'E-Wallet','Paid','2025-05-18','2025-05-18'),
	(19,19,'Cash','Paid','2025-05-19','2025-05-19'),
	(20,20,'Insurance','Paid','2025-05-20','2025-05-20'),
	(21,21,'Credit Card','Paid','2025-05-21','2025-05-21'),
	(22,22,'Cash','Paid','2025-05-22','2025-05-22'),
	(23,23,'E-Wallet','Paid','2025-05-23','2025-05-23'),
	(24,24,'Insurance','Paid','2025-05-24','2025-05-24'),
	(25,25,'Credit Card','Paid','2025-05-25','2025-05-25'),
	(26,26,'Cash','Paid','2025-05-26','2025-05-26'),
	(27,27,'Cash','Pending','2025-05-27',NULL), -- MR 27, Pres 27 (Pending)
	(28,28,'Credit Card','Pending','2025-05-28',NULL), -- MR 28, Pres 28 (Pending)
	(29,29,'E-Wallet','Paid','2025-05-29','2025-05-29'),
	(30,30,'Cash','Paid','2025-05-30','2025-05-30');
END