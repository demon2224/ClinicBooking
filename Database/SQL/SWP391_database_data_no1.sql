USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	-- ---------- LOOKUP DATA ----------
	-- Roles (5)
	INSERT INTO [Role] (RoleName) VALUES
	('doctor'),('pharmacist'),('receptionist'),('admin');

	-- Specialties (10)
	INSERT INTO Specialty (SpecialtyName) VALUES
	('General Practice'),
	('Cardiology'),
	('Dermatology'),
	('Pediatrics'),
	('Orthopedics'),
	('Neurology'),
	('Endocrinology'),
	('Ophthalmology'),
	('ENT'),
	('Psychiatry');

	-- Degrees (10)
	INSERT INTO Degree (DegreeName) VALUES
	('MD'),
	('MBBS'),
	('PhD Medicine'),
	('MSc Clinical'),
	('Diploma in Cardiology'),
	('Diploma in Dermatology'),
	('Master of Surgery'),
	('Fellowship Pediatrics'),
	('Certificate in Neurology'),
	('Doctor of Osteopathy');

	-- ---------- PATIENTS (30) ----------
	INSERT INTO Patient (AccountName, AccountPassword, Avatar, Bio, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
	('patient01','Pass@01','/avatars/p1.png','No allergies','Alice','Brown','1985-03-12',0,'123 Elm St, Springfield','0901000001','alice.brown@example.com'),
	('patient02','Pass@02','/avatars/p2.png','Diabetic','Bob','Smith','1978-07-04',1,'45 Oak Ave, Springfield','0901000002','bob.smith@example.com'),
	('patient03','Pass@03','/avatars/p3.png','Asthma','Cathy','Johnson','1992-11-21',0,'78 Pine Rd, Springfield','0901000003','cathy.johnson@example.com'),
	('patient04','Pass@04','/avatars/p4.png','Hypertension','David','Lee','1969-01-30',1,'9 Maple St, Springfield','0901000004','david.lee@example.com'),
	('patient05','Pass@05','/avatars/p5.png','Pregnant','Emma','Garcia','1990-05-14',0,'12 Birch Ln, Springfield','0901000005','emma.garcia@example.com'),
	('patient06','Pass@06','/avatars/p6.png','High cholesterol','Frank','Martinez','1982-12-08',1,'34 Cedar Blvd, Springfield','0901000006','frank.martinez@example.com'),
	('patient07','Pass@07','/avatars/p7.png','Smoker','Grace','Lopez','1975-09-19',0,'56 Willow Way, Springfield','0901000007','grace.lopez@example.com'),
	('patient08','Pass@08','/avatars/p8.png','None','Henry','Gonzalez','2000-02-02',1,'99 Aspen Dr, Springfield','0901000008','henry.gonzalez@example.com'),
	('patient09','Pass@09','/avatars/p9.png','Allergic to penicillin','Ivy','Wilson','1988-08-08',0,'101 Poplar Cir, Springfield','0901000009','ivy.wilson@example.com'),
	('patient10','Pass@10','/avatars/p10.png','Seasonal allergies','Jack','Anderson','1995-06-15',1,'121 Spruce St, Springfield','0901000010','jack.anderson@example.com'),
	('patient11','Pass@11','/avatars/p11.png','Caregiver','Karen','Thomas','1960-04-02',0,'3 River Rd, Springfield','0901000011','karen.thomas@example.com'),
	('patient12','Pass@12','/avatars/p12.png','Teen patient','Leo','Taylor','2008-10-12',1,'7 Hill St, Springfield','0901000012','leo.taylor@example.com'),
	('patient13','Pass@13','/avatars/p13.png','Frequent traveler','Mia','Moore','1987-09-01',0,'22 Lakeview, Springfield','0901000013','mia.moore@example.com'),
	('patient14','Pass@14','/avatars/p14.png','Insulin user','Noah','Jackson','1970-03-03',1,'17 Forest Ln, Springfield','0901000014','noah.jackson@example.com'),
	('patient15','Pass@15','/avatars/p15.png','Vegetarian','Olivia','Martin','1993-12-12',0,'88 Meadow Rd, Springfield','0901000015','olivia.martin@example.com'),
	('patient16','Pass@16','/avatars/p16.png','Recovering fracture','Peter','Clark','1989-11-11',1,'77 Ridge St, Springfield','0901000016','peter.clark@example.com'),
	('patient17','Pass@17','/avatars/p17.png','Chronic migraines','Quinn','Rodriguez','1986-02-20',0,'65 Valley Rd, Springfield','0901000017','quinn.rodriguez@example.com'),
	('patient18','Pass@18','/avatars/p18.png','Glaucoma history','Rachel','Lewis','1976-07-07',0,'44 Park Ave, Springfield','0901000018','rachel.lewis@example.com'),
	('patient19','Pass@19','/avatars/p19.png','Hearing loss','Steve','Walker','1958-05-05',1,'5 Ocean Dr, Springfield','0901000019','steve.walker@example.com'),
	('patient20','Pass@20','/avatars/p20.png','Skin rash','Tina','Hall','1999-09-09',0,'200 Hilltop, Springfield','0901000020','tina.hall@example.com'),
	('patient21','Pass@21','/avatars/p21.png','Back pain','Uma','Allen','1983-01-01',0,'33 Beacon St, Springfield','0901000021','uma.allen@example.com'),
	('patient22','Pass@22','/avatars/p22.png','Anxiety','Victor','Young','1991-04-04',1,'66 Central Ave, Springfield','0901000022','victor.young@example.com'),
	('patient23','Pass@23','/avatars/p23.png','High BMI','Wendy','Hernandez','1984-06-06',0,'11 Garden Rd, Springfield','0901000023','wendy.hernandez@example.com'),
	('patient24','Pass@24','/avatars/p24.png','Post-op care','Xavier','King','1977-02-02',1,'19 Harbor St, Springfield','0901000024','xavier.king@example.com'),
	('patient25','Pass@25','/avatars/p25.png','Allergic to nuts','Yara','Wright','1996-10-10',0,'55 Summit Ave, Springfield','0901000025','yara.wright@example.com'),
	('patient26','Pass@26','/avatars/p26.png','Thyroid issues','Zack','Loft','1981-08-18',1,'6 Sunset Blvd, Springfield','0901000026','zack.loft@example.com'),
	('patient27','Pass@27','/avatars/p27.png','HIV negative','Amy','Reed','1994-04-09',0,'42 Beacon Rd, Springfield','0901000027','amy.reed@example.com'),
	('patient28','Pass@28','/avatars/p28.png','Frequent colds','Ben','Cook','1998-12-03',1,'73 Pinecrest, Springfield','0901000028','ben.cook@example.com'),
	('patient29','Pass@29','/avatars/p29.png','Smoker recovery','Clara','Morgan','1980-03-30',0,'8 Glen St, Springfield','0901000029','clara.morgan@example.com'),
	('patient30','Pass@30','/avatars/p30.png','Hepatitis B vaccinated','Derek','Bell','1972-11-02',1,'90 Cliff Rd, Springfield','0901000030','derek.bell@example.com');

	-- ---------- STAFF (30) ----------
	-- We'll create 30 staff, with the first 10 being doctors (RoleID=2), next 5 pharmacists (RoleID=3), next 5 receptionists (RoleID=4), rest mixed including admin (RoleID=5).
	INSERT INTO Staff (JobStatus, RoleID, AccountName, AccountPassword, Avatar, Bio, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
	('Available',1,'staff_doc01','Doc@01','/avatars/s1.png','Cardiologist','Aaron','Mills','1975-02-02',1,'10 Staff Lane','0911000001','aaron.mills@clinic.com'),
	('Available',1,'staff_doc02','Doc@02','/avatars/s2.png','Dermatologist','Bella','Reed','1980-03-03',0,'11 Staff Lane','0911000002','bella.reed@clinic.com'),
	('Available',1,'staff_doc03','Doc@03','/avatars/s3.png','Pediatrician','Carl','Perry','1978-04-04',1,'12 Staff Lane','0911000003','carl.perry@clinic.com'),
	('Available',1,'staff_doc04','Doc@04','/avatars/s4.png','Orthopedist','Dana','Kim','1972-05-05',0,'13 Staff Lane','0911000004','dana.kim@clinic.com'),
	('Available',1,'staff_doc05','Doc@05','/avatars/s5.png','Neurologist','Evan','Stone','1968-06-06',1,'14 Staff Lane','0911000005','evan.stone@clinic.com'),
	('Available',1,'staff_doc06','Doc@06','/avatars/s6.png','Endocrinologist','Fiona','Grant','1982-07-07',0,'15 Staff Lane','0911000006','fiona.grant@clinic.com'),
	('Available',1,'staff_doc07','Doc@07','/avatars/s7.png','Ophthalmologist','George','Nash','1976-08-08',1,'16 Staff Lane','0911000007','george.nash@clinic.com'),
	('Available',1,'staff_doc08','Doc@08','/avatars/s8.png','ENT Specialist','Hannah','Cole','1983-09-09',0,'17 Staff Lane','0911000008','hannah.cole@clinic.com'),
	('Available',1,'staff_doc09','Doc@09','/avatars/s9.png','Psychiatrist','Ian','Frost','1974-10-10',1,'18 Staff Lane','0911000009','ian.frost@clinic.com'),
	('Available',1,'staff_doc10','Doc@10','/avatars/s10.png','General Practitioner','Jane','Wells','1985-11-11',0,'19 Staff Lane','0911000010','jane.wells@clinic.com'),

	('Available',2,'staff_ph01','Pharm@01','/avatars/s11.png','Senior pharmacist','Karl','Fox','1984-01-01',1,'20 Staff Lane','0911000011','karl.fox@clinic.com'),
	('Available',2,'staff_ph02','Pharm@02','/avatars/s12.png','Pharmacist','Lena','Bell','1990-02-02',0,'21 Staff Lane','0911000012','lena.bell@clinic.com'),
	('Available',2,'staff_ph03','Pharm@03','/avatars/s13.png','Pharmacist','Mark','Stone','1986-03-03',1,'22 Staff Lane','0911000013','mark.stone@clinic.com'),
	('Available',2,'staff_ph04','Pharm@04','/avatars/s14.png','Pharmacy assistant','Nina','Hayes','1992-04-04',0,'23 Staff Lane','0911000014','nina.hayes@clinic.com'),
	('Available',2,'staff_ph05','Pharm@05','/avatars/s15.png','Pharmacist','Oscar','Rey','1988-05-05',1,'24 Staff Lane','0911000015','oscar.rey@clinic.com'),

	('Available',3,'staff_rec01','Rec@01','/avatars/s16.png','Front desk','Paula','Grant','1991-06-06',0,'25 Staff Lane','0911000016','paula.grant@clinic.com'),
	('Available',3,'staff_rec02','Rec@02','/avatars/s17.png','Front desk','Quinn','Baker','1993-07-07',1,'26 Staff Lane','0911000017','quinn.baker@clinic.com'),
	('Available',3,'staff_rec03','Rec@03','/avatars/s18.png','Front desk','Rita','Young','1994-08-08',0,'27 Staff Lane','0911000018','rita.young@clinic.com'),
	('Available',3,'staff_rec04','Rec@04','/avatars/s19.png','Front desk','Sam','Lopez','1995-09-09',1,'28 Staff Lane','0911000019','sam.lopez@clinic.com'),
	('Available',3,'staff_rec05','Rec@05','/avatars/s20.png','Front desk','Tara','Fox','1989-10-10',0,'29 Staff Lane','0911000020','tara.fox@clinic.com'),

	('Available',4,'staff_admin01','Adm@01','/avatars/s21.png','Administrator','Uma','Grant','1980-11-11',0,'30 Staff Lane','0911000021','uma.grant@clinic.com'),
	('Available',4,'staff_admin02','Adm@02','/avatars/s22.png','IT Admin','Victor','Kim','1983-12-12',1,'31 Staff Lane','0911000022','victor.kim@clinic.com'),
	('Available',4,'staff_admin03','Adm@03','/avatars/s23.png','Billing Admin','Wendy','Lopez','1979-01-13',0,'32 Staff Lane','0911000023','wendy.lopez@clinic.com'),
	('Available',4,'staff_admin04','Adm@04','/avatars/s24.png','HR Admin','Xavier','Stone','1972-02-14',1,'33 Staff Lane','0911000024','xavier.stone@clinic.com'),
	('Available',4,'staff_admin05','Adm@05','/avatars/s25.png','Records Admin','Yara','Hill','1987-03-15',0,'34 Staff Lane','0911000025','yara.hill@clinic.com'),

	('Available',1,'staff_doc11','Doc@11','/avatars/s26.png','Visiting specialist','Zack','Morse','1971-04-16',1,'35 Staff Lane','0911000026','zack.morse@clinic.com'),
	('Available',1,'staff_doc12','Doc@12','/avatars/s27.png','Visiting specialist','Ava','Noel','1986-05-17',0,'36 Staff Lane','0911000027','ava.noel@clinic.com'),
	('Available',2,'staff_ph06','Pharm@06','/avatars/s28.png','Pharmacist','Ben','Carter','1991-06-18',1,'37 Staff Lane','0911000028','ben.carter@clinic.com'),
	('Available',3,'staff_rec06','Rec@06','/avatars/s29.png','Reception','Cara','Miles','1992-07-19',0,'38 Staff Lane','0911000029','cara.miles@clinic.com'),
	('Available',4,'staff_admin06','Adm@06','/avatars/s30.png','Finance','Drew','Yates','1985-08-20',1,'39 Staff Lane','0911000030','drew.yates@clinic.com');

	-- ---------- DOCTORS (10 initial doctors linked to StaffIDs 1-10; plus doctor11/12 map to staff 21/22 respectively) ----------
	-- Need to match StaffIDs: doctors were inserted as first 10 staff rows => StaffID 1..10 for docs, and later 21 and 22 are staff_admin01/admin02? Wait previous insertion order:
	-- Staff rows inserted in one block; staff IDs increment in that order. We ensured first 10 were docs (StaffID 1..10). Later we added more staff; staff_doc11 and staff_doc12 appear later in the list and will have subsequent StaffIDs.
	-- I'll reference doctor StaffIDs: 1..10, 21,22 (approx). For correct referential mapping, let's select exact StaffIDs: they are assigned sequentially in this insert order: we inserted exactly 30 staff rows; doc11 is 26th, doc12 27th in the block. But to avoid ambiguity, we will insert Doctor rows referencing StaffIDs 1..12. That will map to the first 12 staff which are doctors in our plan.

	INSERT INTO Doctor (StaffID, SpecialtyID, YearExperience) VALUES
	(1,2,15),  -- Aaron Mills - Cardiology (SpecialtyID 2)
	(2,3,12),  -- Bella - Dermatology (3)
	(3,4,8),   -- Carl - Pediatrics (4)
	(4,5,20),  -- Dana - Orthopedics (5)
	(5,6,18),  -- Evan - Neurology (6)
	(6,7,10),  -- Fiona - Endocrinology (7)
	(7,8,14),  -- George - Ophthalmology (8)
	(8,9,9),   -- Hannah - ENT (9)
	(9,10,11), -- Ian - Psychiatry (10)
	(10,1,6),  -- Jane - General Practice (1)
	(26,2,7),  -- staff_doc11 (later staff) - Cardiology
	(27,4,5);  -- staff_doc12 - Pediatrics

	-- ---------- DOCTOR DEGREES (15 entries) ----------
	INSERT INTO DoctorDegree (DoctorID, DegreeID, DateEarn, Grantor) VALUES
	(1,1,'2005-06-01','University A'),
	(1,3,'2010-11-15','Institute Cardio'),
	(2,2,'2008-07-20','Medical College B'),
	(3,8,'2012-05-05','Pediatrics Board'),
	(4,7,'1999-09-09','Surgery College'),
	(5,9,'2003-03-03','Neurology Institute'),
	(6,4,'2011-10-10','Clinical Science Univ'),
	(7,1,'2006-12-12','Eye Institute'),
	(8,6,'2014-04-04','ENT Academy'),
	(9,3,'2001-01-01','Psych Board'),
	(10,1,'2015-08-08','GP College'),
	(11,5,'2013-02-02','Cardio Institute'),
	(12,8,'2019-06-06','Pediatrics Board'),
	(2,6,'2016-09-09','Derm Academy'),
	(5,1,'2000-01-01','State Medical Univ');

	-- ---------- RECEPTIONISTS (6) ----------
	-- Receptionist staff must already exist: we created staff with roleID=4 in several entries; we'll link to 16..19,23 or appropriate StaffIDs.
	-- We'll map to the receptionists created earlier (they were placed around staff rows 16..20 and later 29)
	INSERT INTO Receptionist (StaffID) VALUES (16),(17),(18),(19),(20),(29);

	-- ---------- PHARMACISTS (6) ----------
	INSERT INTO Pharmacist (StaffID) VALUES (11),(12),(13),(14),(15),(28);

	-- ---------- MEDICINES (30) ----------
	INSERT INTO Medicine (MedicineType, MedicineStatus, MedicineName, MedicineCode, Quantity, Price)
	VALUES
	('Tablet',1,'Paracetamol 500mg','MED-PARA-500',200,1.50),
	('Capsule',1,'Amoxicillin 500mg','MED-AMOX-500',150,2.25),
	('Syrup',1,'Cough Syrup 100ml','MED-COUGH-100',80,4.50),
	('Ointment',1,'Hydrocortisone 1%','MED-HYDRO-1',60,3.00),
	('Drops',1,'Eye Drops 10ml','MED-EYE-10',50,5.50),
	('Tablet',1,'Ibuprofen 200mg','MED-IBU-200',180,1.75),
	('Capsule',1,'Omeprazole 20mg','MED-OMEP-20',120,6.00),
	('Tablet',1,'Aspirin 81mg','MED-ASP-81',300,0.90),
	('Capsule',1,'Metformin 500mg','MED-MET-500',160,2.10),
	('Tablet',1,'Loratadine 10mg','MED-LORA-10',140,1.20),
	('Syrup',1,'Children Multivitamin','MED-MULTI-100',90,7.50),
	('Tablet',1,'Prednisone 10mg','MED-PRED-10',50,2.80),
	('Capsule',1,'Doxycycline 100mg','MED-DOXY-100',70,3.60),
	('Ointment',1,'Antifungal Cream','MED-AF-50',40,4.00),
	('Drops',1,'Ear Drops 10ml','MED-EAR-10',30,6.50),
	('Tablet',1,'Clopidogrel 75mg','MED-CLOP-75',60,8.00),
	('Capsule',1,'Levothyroxine 50mcg','MED-LEVO-50',90,3.20),
	('Tablet',1,'Zinc Supplement 50mg','MED-ZINC-50',200,1.10),
	('Capsule',1,'Fluconazole 150mg','MED-FLU-150',45,5.60),
	('Syrup',1,'Antacid Syrup','MED-Acid-100',110,3.90),
	('Tablet',1,'Losartan 50mg','MED-LOS-50',75,2.70),
	('Capsule',1,'Albuterol 2mg','MED-ALB-2',100,4.40),
	('Tablet',1,'Vitamin D 1000IU','MED-VD-1000',210,1.30),
	('Capsule',1,'Nitrofurantoin 100mg','MED-NIT-100',55,4.80),
	('Tablet',1,'Tramadol 50mg','MED-TRAM-50',35,6.75),
	('Ointment',1,'Antiseptic Ointment','MED-ANT-30',40,2.50),
	('Drops',1,'Nasal Drops 15ml','MED-NAS-15',65,3.30),
	('Capsule',1,'Gabapentin 300mg','MED-GABA-300',25,7.20),
	('Tablet',1,'Hydrochlorothiazide 25mg','MED-HCTZ-25',120,1.90),
	('Capsule',1,'Clarithromycin 500mg','MED-CLA-500',50,5.00);

	-- ---------- MEDICINE STOCK TRANSACTIONS (30) ----------
	-- For each of the 30 medicines, create at least one import transaction
	INSERT INTO MedicineStockTransaction (MedicineID, Quantity, DateImport, DateExpire)
	VALUES
	(1,200,'2025-01-20','2026-01-19'),
	(2,150,'2025-02-10','2026-02-09'),
	(3,80,'2025-03-02','2026-03-01'),
	(4,60,'2025-01-15','2026-01-14'),
	(5,50,'2025-02-18','2026-02-17'),
	(6,180,'2025-02-25','2026-02-24'),
	(7,120,'2025-03-10','2026-03-09'),
	(8,300,'2025-01-30','2026-01-29'),
	(9,160,'2025-02-05','2026-02-04'),
	(10,140,'2025-03-18','2026-03-17'),
	(11,90,'2025-04-01','2026-03-31'),
	(12,50,'2025-04-05','2026-04-04'),
	(13,70,'2025-04-08','2026-04-07'),
	(14,40,'2025-04-10','2026-04-09'),
	(15,30,'2025-04-12','2026-04-11'),
	(16,60,'2025-04-15','2026-04-14'),
	(17,90,'2025-04-18','2026-04-17'),
	(18,200,'2025-04-20','2026-04-19'),
	(19,45,'2025-04-22','2026-04-21'),
	(20,110,'2025-04-24','2026-04-23'),
	(21,75,'2025-04-26','2026-04-25'),
	(22,100,'2025-04-28','2026-04-27'),
	(23,210,'2025-05-01','2026-04-30'),
	(24,55,'2025-05-03','2026-05-02'),
	(25,35,'2025-05-06','2026-05-05'),
	(26,40,'2025-05-08','2026-05-07'),
	(27,65,'2025-05-10','2026-05-09'),
	(28,25,'2025-05-12','2026-05-11'),
	(29,120,'2025-05-15','2026-05-14'),
	(30,50,'2025-05-18','2026-05-17');

	-- ---------- CONSULTATION FEES (10) ----------
	INSERT INTO ConsultationFee (DoctorID, SpecialtyID, Fee) VALUES
	(1,2,120.00),
	(2,3,90.00),
	(3,4,80.00),
	(4,5,110.00),
	(5,6,150.00),
	(6,7,100.00),
	(7,8,95.00),
	(8,9,85.00),
	(9,10,130.00),
	(10,1,60.00);

	-- ---------- APPOINTMENTS (30) ----------
	-- Create many appointments for multiple patients with various doctors.
	INSERT INTO Appointment (PatientID, DoctorID, AppointmentStatus, DateCreate, DateBegin, DateEnd, Note)
	VALUES
	(1,1,'Completed','2025-05-01','2025-05-01 09:00','2025-05-01 09:20','Routine check'),
	(1,1,'Completed','2025-05-02','2025-05-02 10:00','2025-05-02 10:30','Chest pain follow-up'),
	(1,2,'Completed','2025-05-03','2025-05-03 11:00','2025-05-03 11:20','Skin rash'),
	(1,3,'Completed','2025-05-04','2025-05-04 09:30','2025-05-04 09:50','Child fever'),
	(1,4,'Completed','2025-05-05','2025-05-05 14:00','2025-05-05 14:20','Knee pain'),
	(1,5,'Completed','2025-05-06','2025-05-06 15:00','2025-05-06 15:25','Headache review'),
	(1,6,'Completed','2025-05-07','2025-05-07 08:30','2025-05-07 08:50','Diabetes review'),
	(1,7,'Approved','2025-05-08','2025-05-10 10:00','2025-05-10 10:20','Eye check'),
	(1,8,'Pending','2025-05-09','2025-05-15 11:00','2025-05-15 11:15','Ear pain'),
	(1,9,'Completed','2025-05-10','2025-05-10 16:00','2025-05-10 16:25','Mental health follow-up'),
	(1,1,'Completed','2025-05-11','2025-05-11 09:10','2025-05-11 09:25','Blood pressure'),
	(12,1,'Completed','2025-05-12','2025-05-12 10:15','2025-05-12 10:35','Acne treatment'),
	(13,1,'Completed','2025-05-13','2025-05-13 11:30','2025-05-13 11:45','Child vaccination'),
	(14,1,'Completed','2025-05-14','2025-05-14 14:40','2025-05-14 14:55','Fracture check'),
	(15,1,'Completed','2025-05-15','2025-05-15 15:50','2025-05-15 16:10','Neurology consult'),
	(16,1,'Canceled','2025-05-16','2025-05-20 08:00','2025-05-20 08:15','Patient canceled'),
	(17,1,'Completed','2025-05-17','2025-05-17 09:00','2025-05-17 09:20','Cataract review'),
	(18,1,'Completed','2025-05-18','2025-05-18 10:10','2025-05-18 10:30','Sinusitis'),
	(19,1,'Completed','2025-05-19','2025-05-19 11:00','2025-05-19 11:25','Depression check'),
	(20,1,'Completed','2025-05-20','2025-05-20 12:00','2025-05-20 12:20','General check'),
	(21,1,'Completed','2025-05-21','2025-05-21 09:15','2025-05-21 09:35','Follow up'),
	(22,1,'Completed','2025-05-22','2025-05-22 10:05','2025-05-22 10:25','Skin follow-up'),
	(23,3,'Completed','2025-05-23','2025-05-23 11:05','2025-05-23 11:25','Pediatric review'),
	(24,4,'Completed','2025-05-24','2025-05-24 14:05','2025-05-24 14:25','Orthopedic therapy'),
	(25,5,'Completed','2025-05-25','2025-05-25 15:05','2025-05-25 15:30','Neuro follow-up'),
	(26,6,'Completed','2025-05-26','2025-05-26 08:45','2025-05-26 09:05','Endocrine consult'),
	(27,7,'Pending','2025-05-27','2025-06-01 10:00','2025-06-01 10:20','Eye symptoms'),
	(28,8,'Approved','2025-05-28','2025-06-03 11:00','2025-06-03 11:30','ENT check'),
	(29,9,'Completed','2025-05-29','2025-05-29 12:00','2025-05-29 12:25','Psych consult'),
	(30,10,'Completed','2025-05-30','2025-05-30 13:00','2025-05-30 13:20','General exam');

	-- ---------- PRESCRIPTIONS (30) ----------
	-- For appointments that are Completed, many prescriptions are 'Delivered' (so invoices can be 'Paid')
	INSERT INTO Prescription (AppointmentID, PrescriptionStatus, DateCreate, Note)
	VALUES
	(1,'Delivered','2025-05-01','Paracetamol for fever'),
	(2,'Delivered','2025-05-02','Antibiotics x7 days'),
	(3,'Delivered','2025-05-03','Topical cream'),
	(4,'Delivered','2025-05-04','Pediatric syrup'),
	(5,'Delivered','2025-05-05','Anti-inflammatory'),
	(6,'Delivered','2025-05-06','Migraine meds'),
	(7,'Delivered','2025-05-07','Diabetes meds refill'),
	(8,'Pending','2025-05-08','Eye drops to be approved'),
	(9,'Pending','2025-05-09','Ear antibiotics pending'),
	(10,'Delivered','2025-05-10','Mood stabilizer'),
	(11,'Delivered','2025-05-11','BP medication'),
	(12,'Delivered','2025-05-12','Acne tablets'),
	(13,'Delivered','2025-05-13','Vaccination record'),
	(14,'Delivered','2025-05-14','Analgesics for pain'),
	(15,'Delivered','2025-05-15','Neuro meds'),
	(16,'Canceled','2025-05-16','Canceled by patient'),
	(17,'Delivered','2025-05-17','Eye drops post-op'),
	(18,'Delivered','2025-05-18','Antibiotics for sinus'),
	(19,'Delivered','2025-05-19','Antidepressant refill'),
	(20,'Delivered','2025-05-20','General multivitamin'),
	(21,'Delivered','2025-05-21','Follow up prescription'),
	(22,'Delivered','2025-05-22','Skin ointments'),
	(23,'Delivered','2025-05-23','Pediatric meds'),
	(24,'Delivered','2025-05-24','Joint pain meds'),
	(25,'Delivered','2025-05-25','Neuro supplement'),
	(26,'Delivered','2025-05-26','Thyroid medication'),
	(27,'Pending','2025-05-27','Eye prescription pending'),
	(28,'Pending','2025-05-28','ENT follow-up'),
	(29,'Delivered','2025-05-29','Psych medication'),
	(30,'Delivered','2025-05-30','Routine meds');

	-- ---------- PRESCRIPTION ITEMS ----------
	-- Many prescriptions have multiple medicines; ensure valid MedicineID references. We'll insert multiple items per prescription.
	INSERT INTO PrescriptionItem (PrescriptionID, MedicineID, Dosage, Instruction) VALUES
	(1,1,2,'Take 2 tablets every 6 hours as needed for fever'),
	(1,22,1,'Take one tablet daily as blood thinner'),
	(2,2,1,'One capsule every 8 hours for 7 days'),
	(2,11,1,'Take multivitamin once daily'),
	(3,14,2,'Apply twice daily to affected area'),
	(4,3,5,'5ml twice daily for 5 days'),
	(5,6,1,'Take one tablet every 8 hours after meals'),
	(6,26,1,'Take one capsule nightly for neuropathic pain'),
	(7,9,1,'Metformin one tablet twice daily'),
	(8,5,1,'Eye drops one drop each eye 3x daily'),
	(9,2,1,'Amoxicillin one capsule 3x daily'),
	(10,28,1,'Gabapentin 300mg at night'),
	(11,21,1,'Losartan 50mg once daily'),
	(12,10,1,'Loratadine once daily'),
	(13,11,1,'Children vitamin syrup 5ml daily'),
	(14,6,1,'Ibuprofen 200mg as needed'),
	(15,26,1,'Gabapentin 300mg daily'),
	(15,17,1,'Levothyroxine per lab orders'),
	(17,5,1,'Eye drops as directed'),
	(18,2,1,'Amoxicillin one capsule 3x daily'),
	(19,28,1,'Gabapentin per psychiatrist'),
	(20,22,1,'Vitamin D once daily'),
	(21,1,2,'Paracetamol 2 tablets if needed'),
	(22,14,2,'Apply ointment twice daily'),
	(23,3,5,'Children syrup as prescribed'),
	(24,6,1,'Ibuprofen as needed'),
	(25,18,1,'Zinc supplement once daily'),
	(26,17,1,'Levothyroxine per doctor'),
	(29,28,1,'Gabapentin per psychiatry'),
	(30,1,1,'Paracetamol 1-2 tablets for pain'),
	-- add extra items to create multiple-medicine prescriptions:
	(2,6,1,'Ibuprofen if needed'),
	(5,12,1,'Prednisone short course'),
	(11,8,1,'Aspirin low dose'),
	(19,10,1,'Loratadine for allergies'),
	(14,25,1,'Tramadol if severe pain'),
	(24,13,1,'Doxycycline for infection'),
	(3,9,1,'Metformin (if diabetic)'),
	(7,20,1,'Antacid if needed'),
	(15,23,1,'Nitrofurantoin for UTI'),
	(29,1,2,'Paracetamol PRN');

	-- ---------- MEDICAL RECORDS (30) ----------
	-- Link each MedicalRecord to a completed appointment and its prescription (where applicable)
	INSERT INTO MedicalRecord (AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note, DateCreate)
	VALUES
	(1,1,'Fever, sore throat','Viral infection','Advised rest and fluids','2025-05-01'),
	(2,2,'Chest discomfort','Stable angina','EKG done; refill prescribed','2025-05-02'),
	(3,3,'Rash','Contact dermatitis','Avoid allergen','2025-05-03'),
	(4,4,'Child fever','Viral illness','Paracetamol given','2025-05-04'),
	(5,5,'Knee pain','Sprain','Physical therapy referral','2025-05-05'),
	(6,6,'Migraine','Migraine','New med started','2025-05-06'),
	(7,7,'High sugar','Type 2 Diabetes','Dose adjusted','2025-05-07'),
	(10,10,'Anxiety','Generalized anxiety disorder','Therapy referral','2025-05-10'),
	(11,11,'High BP','Hypertension','BP meds adjusted','2025-05-11'),
	(12,12,'Acne','Acne vulgaris','Topical+oral plan','2025-05-12'),
	(13,13,'Well child','Healthy','Vaccination recorded','2025-05-13'),
	(14,14,'Post fracture review','Healing fracture','Continue physiotherapy','2025-05-14'),
	(15,15,'Numbness','Peripheral neuropathy','Electrodiagnostic planned','2025-05-15'),
	(17,17,'Post-op eye','Post-op status','Eye drops prescribed','2025-05-17'),
	(18,18,'Sinus pain','Sinusitis','Antibiotic given','2025-05-18'),
	(19,19,'Low mood','Major depression','Medication optimized','2025-05-19'),
	(20,20,'Routine','Healthy','No issues','2025-05-20'),
	(21,21,'Follow up','Stable','Continue meds','2025-05-21'),
	(22,22,'Skin follow-up','Resolved','Stop ointment','2025-05-22'),
	(23,23,'Pediatric check','Well child','Advised nutrition','2025-05-23'),
	(24,24,'Joint pain','Arthritis','Start NSAID','2025-05-24'),
	(25,25,'Neuro follow-up','Stable','Continue supplement','2025-05-25'),
	(26,26,'Thyroid','Hypothyroidism','Dose stable','2025-05-26'),
	(29,29,'Psych follow-up','Stable on meds','Monitor side effects','2025-05-29'),
	(30,30,'Routine','Healthy','Annual exam','2025-05-30'),
	(8,8,'Eye irritation','Conjunctivitis','Pending delivery of drops','2025-05-08'),
	(9,9,'Ear pain','Otitis media','Await prescription approval','2025-05-09'),
	(16,16,'Canceled appointment','N/A','No record','2025-05-16'),
	(27,27,'Eye blurry','Possible refractive error','Appointment pending','2025-05-27'),
	(28,28,'ENT complaint','Chronic rhinitis','Further tests scheduled','2025-05-28');

	-- ---------- INVOICES (30) ----------
	-- Business rule: Only create Invoice with InvoiceStatus = 'Paid' when Prescription.PrescriptionStatus = 'Delivered'. For prescriptions pending/canceled, invoice set 'Pending' or not created.
	-- We'll create invoices for many delivered prescriptions and set DatePay accordingly.

	INSERT INTO Invoice (MedicalRecordID, ConsultationFeeID, PrescriptionID, PaymentType, InvoiceStatus, DateCreate, DatePay)
	VALUES
	(1,1,1,'Cash','Paid','2025-05-01','2025-05-01'),
	(2,1,2,'Credit Card','Paid','2025-05-02','2025-05-02'),
	(3,2,3,'E-Wallet','Paid','2025-05-03','2025-05-03'),
	(4,3,4,'Cash','Paid','2025-05-04','2025-05-04'),
	(5,4,5,'Insurance','Paid','2025-05-05','2025-05-06'),
	(6,5,6,'Credit Card','Paid','2025-05-06','2025-05-06'),
	(7,6,7,'Cash','Paid','2025-05-07','2025-05-07'),
	(8,2,8,'Cash','Pending','2025-05-08',NULL), -- prescription 8 is Pending
	(9,3,9,'Insurance','Pending','2025-05-09',NULL), -- prescription 9 pending
	(10,10,10,'Credit Card','Paid','2025-05-10','2025-05-10'),
	(11,1,11,'Cash','Paid','2025-05-11','2025-05-11'),
	(12,2,12,'E-Wallet','Paid','2025-05-12','2025-05-12'),
	(13,3,13,'Insurance','Paid','2025-05-13','2025-05-13'),
	(14,4,14,'Online Banking','Paid','2025-05-14','2025-05-14'),
	(15,5,15,'Cash','Paid','2025-05-15','2025-05-15'),
	(16,6,16,'Cash','Canceled','2025-05-16',NULL), -- prescription canceled
	(17,7,17,'Credit Card','Paid','2025-05-17','2025-05-17'),
	(18,8,18,'Cash','Paid','2025-05-18','2025-05-18'),
	(19,9,19,'Insurance','Paid','2025-05-19','2025-05-19'),
	(20,10,20,'Cash','Paid','2025-05-20','2025-05-20'),
	(21,1,21,'Cash','Paid','2025-05-21','2025-05-21'),
	(22,2,22,'E-Wallet','Paid','2025-05-22','2025-05-22'),
	(23,3,23,'Cash','Paid','2025-05-23','2025-05-23'),
	(24,4,24,'Credit Card','Paid','2025-05-24','2025-05-24'),
	(25,5,25,'Cash','Paid','2025-05-25','2025-05-25'),
	(26,6,26,'Insurance','Paid','2025-05-26','2025-05-26'),
	(27,7,27,'Cash','Pending','2025-05-27',NULL), -- prescription 27 pending
	(28,8,28,'Online Banking','Pending','2025-05-28',NULL), -- prescription 28 pending
	(29,9,29,'Credit Card','Paid','2025-05-29','2025-05-29'),
	(30,10,30,'Cash','Paid','2025-05-30','2025-05-30');

	-- ---------- DOCTOR REVIEWS (15 sample) ----------
	INSERT INTO DoctorReview (PatientID, DoctorID, Content, RateScore, DateCreate) VALUES
	(1,1,'Very professional and attentive',5,'2025-05-02'),
	(2,1,'Explained clearly',4,'2025-05-03'),
	(3,2,'Skin cleared up',5,'2025-05-04'),
	(4,3,'Good with children',5,'2025-05-05'),
	(5,4,'Helpful and thorough',4,'2025-05-06'),
	(6,5,'Great neurologist',5,'2025-05-07'),
	(7,6,'Caring and patient',4,'2025-05-08'),
	(8,7,'Excellent eye care',5,'2025-05-09'),
	(9,8,'Helpful ENT consultation',4,'2025-05-10'),
	(10,9,'Supportive',5,'2025-05-11'),
	(11,1,'Follow up was useful',4,'2025-05-12'),
	(12,2,'Good treatment',4,'2025-05-13'),
	(13,3,'Pediatric nurse supportive',5,'2025-05-14'),
	(14,4,'Recovery good',5,'2025-05-15'),
	(15,5,'Professional',5,'2025-05-16');

END