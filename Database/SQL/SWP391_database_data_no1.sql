USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'ClinicBookingDatabase')
BEGIN
	USE ClinicBookingDatabase

	-- 1. Specialties (10) - Không phụ thuộc
	INSERT INTO Specialty (SpecialtyName, Price) VALUES
('General Practice', 0.60),
('Cardiology', 0.90),
('Dermatology', 0.50),
('Pediatrics', 0.45),
('Orthopedics', 0.70),
('Neurology', 0.95),
('Endocrinology', 0.55),
('Ophthalmology', 0.52),
('ENT', 0.48),
('Psychiatry', 0.88);


	-- 2. PATIENTS (30) - Không phụ thuộc
	INSERT INTO Patient (AccountName, AccountPassword, Avatar, Bio, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
	-- Password Pass@###(001-030)
	('patient01','175c90696276edd5ac31139f32461822b71478a82ebbcc105738d8c123bc64b7',NULL,'No allergies','Alice','Brown','1985-03-12',0,'123 Elm St, Springfield','0901000001','alice.brown@example.com'),
	('patient02','6209f5021f0d6aae53c3bda9229e9b9ac04022505f31ec70d8c19cb0dcf681fc',NULL,'Diabetic','Bob','Smith','1978-07-04',1,'45 Oak Ave, Springfield','0901000002','bob.smith@example.com'),
	('patient03','2685d33a3ce43e0c1eaa0ca0ad4b0e2cd50c3ad2b5662f54759c0ca4fcc72f7d',NULL,'Asthma','Cathy','Johnson','1992-11-21',0,'78 Pine Rd, Springfield','0901000003','cathy.johnson@example.com'),
	('patient04','76d3c7ae6f8b54043ca901526930af98187a92d1b0d12a2e20ba09c4a43a3946',NULL,'Hypertension','David','Lee','1969-01-30',1,'9 Maple St, Springfield','0901000004','david.lee@example.com'),
	('patient05','21cc5e3e129b17e65bc35a6b9c78f6d80fa37e161efc81f9cc28bf1b12d6aa3a',NULL,'Pregnant','Emma','Garcia','1990-05-14',0,'12 Birch Ln, Springfield','0901000005','emma.garcia@example.com'),
	('patient06','541d9901e2435e4b02b0fe432f4ad281b744176ae193e7bd84eec5d2f19fd6e0',NULL,'High cholesterol','Frank','Martinez','1982-12-08',1,'34 Cedar Blvd, Springfield','0901000006','frank.martinez@example.com'),
	('patient07','023e22655353437ceac349a987446420cc68a94b126b9d937d2ae29700113d78',NULL,'Smoker','Grace','Lopez','1975-09-19',0,'56 Willow Way, Springfield','0901000007','grace.lopez@example.com'),
	('patient08','0114cf13c015ad19b1fcccaa087bda2815dd86542d47cd0d006cb31f39fd2d55',NULL,'None','Henry','Gonzalez','2000-02-02',1,'99 Aspen Dr, Springfield','0901000008','henry.gonzalez@example.com'),
	('patient09','5821707624fde98bd3d99dffecc1819104eee5002a6bf2b70108c0fbc5689196',NULL,'Allergic to penicillin','Ivy','Wilson','1988-08-08',0,'101 Poplar Cir, Springfield','0901000009','ivy.wilson@example.com'),
	('patient10','16aef6f30e774379ec3736ef07dd8e15b87c892abb0ad838eafae657b1365704',NULL,'Seasonal allergies','Jack','Anderson','1995-06-15',1,'121 Spruce St, Springfield','0901000010','jack.anderson@example.com'),
	('patient11','0d0794b61a7c807a76b547f980bec1188ac6ef30da13c7f2c595adc927109985',NULL,'Caregiver','Karen','Thomas','1960-04-02',0,'3 River Rd, Springfield','0901000011','karen.thomas@example.com'),
	('patient12','027dad64f49f94e0e61a1194dab674d96dc8750b5634e86731b090dd9cbdf072',NULL,'Teen patient','Leo','Taylor','2008-10-12',1,'7 Hill St, Springfield','0901000012','leo.taylor@example.com'),
	('patient13','1eb81baf8a46ed8963eb5789248777fa53974f6951102fe14eebf37082bda028',NULL,'Frequent traveler','Mia','Moore','1987-09-01',0,'22 Lakeview, Springfield','0901000013','mia.moore@example.com'),
	('patient14','390d0e3f376a441e0ad1f8ee314d1f8808c3e06793dbbd761571a82a4b08424e',NULL,'Insulin user','Noah','Jackson','1970-03-03',1,'17 Forest Ln, Springfield','0901000014','noah.jackson@example.com'),
	('patient15','a1c5ef0140e03939c3231697e2405ddf0abc78980e7307985bde32b18d90f4e7',NULL,'Vegetarian','Olivia','Martin','1993-12-12',0,'88 Meadow Rd, Springfield','0901000015','olivia.martin@example.com'),
	('patient16','e718259abdf6d1e3477c29f9ad915e2aef7be577ad0aa8a64b658607bdc01b52',NULL,'Recovering fracture','Peter','Clark','1989-11-11',1,'77 Ridge St, Springfield','0901000016','peter.clark@example.com'),
	('patient17','37fc78e602d202efdc11d58e48d4a54551e241d639ba4477cccc9447d11edb2c',NULL,'Chronic migraines','Quinn','Rodriguez','1986-02-20',0,'65 Valley Rd, Springfield','0901000017','quinn.rodriguez@example.com'),
	('patient18','f3e2d37b4bf5a8856da3067d6e112c48d09356a489073932d8720e5b2ce00e17',NULL,'Glaucoma history','Rachel','Lewis','1976-07-07',0,'44 Park Ave, Springfield','0901000018','rachel.lewis@example.com'),
	('patient19','a3bcaf9fa8386095ae4e4ea6e7fc117fd5b4c9e373975abb5e857f6cb8b24496',NULL,'Hearing loss','Steve','Walker','1958-05-05',1,'5 Ocean Dr, Springfield','0901000019','steve.walker@example.com'),
	('patient20','8964af012a3e0d12142ae4702ca3fe69a0cabd0165b695e242c41cc95da1c512',NULL,'Skin rash','Tina','Hall','1999-09-09',0,'200 Hilltop, Springfield','0901000020','tina.hall@example.com'),
	('patient21','a48712690194172072f6e26b69eb1dfb7a6144af36f7e4c899e93c76660b7ebf',NULL,'Back pain','Uma','Allen','1983-01-01',0,'33 Beacon St, Springfield','0901000021','uma.allen@example.com'),
	('patient22','97b7528f884d51d21ce95b6fea4a482f8068cb3275199930fb8afae7864bc69c',NULL,'Anxiety','Victor','Young','1991-04-04',1,'66 Central Ave, Springfield','0901000022','victor.young@example.com'),
	('patient23','6b7b656241d1a7db3c8b9491c0633363aa50248b1980d43cea6e894ea6c1ecd9',NULL,'High BMI','Wendy','Hernandez','1984-06-06',0,'11 Garden Rd, Springfield','0901000023','wendy.hernandez@example.com'),
	('patient24','6d85a2c74d8f63169993f572e6e314f31da95585011a537a01a6e746528fdaad',NULL,'Post-op care','Xavier','King','1977-02-02',1,'19 Harbor St, Springfield','0901000024','xavier.king@example.com'),
	('patient25','19f3f02162223cf1d8fda22bff2e523e2e9c5047d0daaf831df1faa6cb0b4e1b',NULL,'Allergic to nuts','Yara','Wright','1996-10-10',0,'55 Summit Ave, Springfield','0901000025','yara.wright@example.com'),
	('patient26','ff8e167ee88188e02ca64831e5bfcf074df2aaf4d6569cc1bce2db73f1d41c46',NULL,'Thyroid issues','Zack','Loft','1981-08-18',1,'6 Sunset Blvd, Springfield','0901000026','zack.loft@example.com'),
	('patient27','08ed05755efb9ffae55d70843b17dfa6fde8e832966d07094b25ed66e3c2a32a',NULL,'HIV negative','Amy','Reed','1994-04-09',0,'42 Beacon Rd, Springfield','0901000027','amy.reed@example.com'),
	('patient28','044604aa4155af8fcd372331a9ad1c24d356ac57442cb288fb7d38e208149bb5',NULL,'Frequent colds','Ben','Cook','1998-12-03',1,'73 Pinecrest, Springfield','0901000028','ben.cook@example.com'),
	('patient29','29b2efc4400948bca46a4757d496d1587001e7898640219e738d8165f69528bf',NULL,'Smoker recovery','Clara','Morgan','1980-03-30',0,'8 Glen St, Springfield','0901000029','clara.morgan@example.com'),
	('patient30','012a5a700714382b5e69544df5b47ab140bdd8267e530d59316858ef22101580',NULL,'Hepatitis B vaccinated','Derek','Bell','1972-11-02',1,'90 Cliff Rd, Springfield','0901000030','derek.bell@example.com');

	-- 3. STAFF (30) - Không phụ thuộc
	-- Doctor Staff IDs: 1-10, 26, 27
	INSERT INTO Staff (JobStatus, [Role], AccountName, AccountPassword, Avatar, Bio, FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email)
	VALUES
	-- Password Doc@####(0001-0010)
	('Available','Doctor','staffdoc01','bc46ea7276e1093e27d477e25563fcd9bd8f77ddd4231c33394c4ab155becfe7',NULL,'Cardiologist','Aaron','Mills','1975-02-02',1,'10 Staff Lane','0911000001','aaron.mills@clinic.com'), -- ID 1
	('Available','Doctor','staffdoc02','b48252d8341ff489ef057280722a8f57cb33767d2aee5a10e8ecf81751fe8496',NULL,'Dermatologist','Bella','Reed','1980-03-03',0,'11 Staff Lane','0911000002','bella.reed@clinic.com'), -- ID 2
	('Available','Doctor','staffdoc03','b61d9e5e1fff59292e9bf04aff6970013ed1502cf3949abe4a65a65cce143987',NULL,'Pediatrician','Carl','Perry','1978-04-04',1,'12 Staff Lane','0911000003','carl.perry@clinic.com'), -- ID 3
	('Available','Doctor','staffdoc04','fa181b99e0d29bd5dda9b8b110c7c32489328fdf78778168435e7e04dcd68a24',NULL,'Orthopedist','Dana','Kim','1972-05-05',0,'13 Staff Lane','0911000004','dana.kim@clinic.com'), -- ID 4
	('Available','Doctor','staffdoc05','44cf3c4a3c6ef714b34c40ab1babb614492956a85a6a75a74f7db04bfe350ebd',NULL,'Neurologist','Evan','Stone','1968-06-06',1,'14 Staff Lane','0911000005','evan.stone@clinic.com'), -- ID 5
	('Available','Doctor','staffdoc06','e3cd52f9a75e6985c9416f64e550231fa56754cf1a93712e109edbf746e96f3a',NULL,'Endocrinologist','Fiona','Grant','1982-07-07',0,'15 Staff Lane','0911000006','fiona.grant@clinic.com'), -- ID 6
	('Available','Doctor','staffdoc07','9b4085484e2ec25344e0183e1b0e0f7e3c5f188dd4bf8b3c72c1db727630e0ba',NULL,'Ophthalmologist','George','Nash','1976-08-08',1,'16 Staff Lane','0911000007','george.nash@clinic.com'), -- ID 7
	('Available','Doctor','staffdoc08','2e5f3cd964b7b4473e234a6ba141076f03ddec2d39e371d5d36bc526022b6467',NULL,'ENT Specialist','Hannah','Cole','1983-09-09',0,'17 Staff Lane','0911000008','hannah.cole@clinic.com'), -- ID 8
	('Available','Doctor','staffdoc09','1331c38f38202748f5b6237d2e7aecdc6a4414ab7cf54ef8c0b221d8ed94590c',NULL,'Psychiatrist','Ian','Frost','1974-10-10',1,'18 Staff Lane','0911000009','ian.frost@clinic.com'), -- ID 9
	('Available','Doctor','staffdoc10','d24ea0cb5802c09e859f35d03f1a0a9b4ad727e6171fa516452a3c1d4161df5f',NULL,'General Practitioner','Jane','Wells','1985-11-11',0,'19 Staff Lane','0911000010','jane.wells@clinic.com'), -- ID 10

	-- Password Pharm@##(01-05)
	('Available','Pharmacist','staffph01','6395ce58989fc6b35cac6bb2218d6021ff09f09a989ace25f0c5dbff71c8dd86',NULL,'Senior pharmacist','Karl','Fox','1984-01-01',1,'20 Staff Lane','0911000011','karl.fox@clinic.com'), -- ID 11
	('Available','Pharmacist','staffph02','69325524de91b4e3cb285d4a363cc3869f26330b50efe09207b7a8366d94dc74',NULL,'Pharmacist','Lena','Bell','1990-02-02',0,'21 Staff Lane','0911000012','lena.bell@clinic.com'), -- ID 12
	('Available','Pharmacist','staffph03','da99bc9461dabdddb4e7859e9c8b44932bb2f4b960590e1bb260310fabb0da0e',NULL,'Pharmacist','Mark','Stone','1986-03-03',1,'22 Staff Lane','0911000013','mark.stone@clinic.com'), -- ID 13
	('Available','Pharmacist','staffph04','afbf3a3f4f8d6d801f2ad5a7be0369925d652395edab3f09598cc09fd88c91c4',NULL,'Pharmacy assistant','Nina','Hayes','1992-04-04',0,'23 Staff Lane','0911000014','nina.hayes@clinic.com'), -- ID 14
	('Available','Pharmacist','staffph05','f113871bbc50a321080323f539322cd873866a6d89cc1da37a142f7458282151',NULL,'Pharmacist','Oscar','Rey','1988-05-05',1,'24 Staff Lane','0911000015','oscar.rey@clinic.com'), -- ID 15

	-- Password Rec@####(0001-0005)
	('Available','Receptionist','staffrec01','35b7f137ef6498fa40d6f59073c7627209bf890e47601d2af7a54c0c23f06645',NULL,'Front desk','Paula','Grant','1991-06-06',0,'25 Staff Lane','0911000016','paula.grant@clinic.com'), -- ID 16
	('Available','Receptionist','staffrec02','ec768ae499edcb10bb3f5073663ee80608146acc01ac6250e8809e13c8fba0e1',NULL,'Front desk','Quinn','Baker','1993-07-07',1,'26 Staff Lane','0911000017','quinn.baker@clinic.com'), -- ID 17
	('Available','Receptionist','staffrec03','d154deffbc3c6cb400f142715d90de5358d0c581cb7280e6315b617254ce67b0',NULL,'Front desk','Rita','Young','1994-08-08',0,'27 Staff Lane','0911000018','rita.young@clinic.com'), -- ID 18
	('Available','Receptionist','staffrec04','f54f53a5e3362a4548e25122982280a239e9118fcf1396c3f768adc689809b0a',NULL,'Front desk','Sam','Lopez','1995-09-09',1,'28 Staff Lane','0911000019','sam.lopez@clinic.com'), -- ID 19
	('Available','Receptionist','staffrec05','b5d4fe8f26798b8677d606469856ed26913856818c58a0d6c4d3cf7bfc1a68ed',NULL,'Front desk','Tara','Fox','1989-10-10',0,'29 Staff Lane','0911000020','tara.fox@clinic.com'), -- ID 20

	-- Password Adm@####(0001-0005)
	('Available','Admin','staffadmin01','d9c85b4489706daef76fccba67c9db0855db2b3fa69addbbf540c3b667a6dff7',NULL,'Administrator','Uma','Grant','1980-11-11',0,'30 Staff Lane','0911000021','uma.grant@clinic.com'), -- ID 21
	('Available','Admin','staffadmin02','c15a7fa02b0b895e1ee6ee86a62bfa23f4b89d354d17c9fc984f29f217f0a4c7',NULL,'IT Admin','Victor','Kim','1983-12-12',1,'31 Staff Lane','0911000022','victor.kim@clinic.com'), -- ID 22
	('Available','Admin','staffadmin03','f9f16ce53f805d28f3290176cb4aa3ada21d2a7b1603eeb58df1deab2e636072',NULL,'Billing Admin','Wendy','Lopez','1979-01-13',0,'32 Staff Lane','0911000023','wendy.lopez@clinic.com'), -- ID 23
	('Available','Admin','staffadmin04','0ab6fc68d9e2d65de71e1daaef800abe103b44413e38d3b29c120bbe54b8ca0e',NULL,'HR Admin','Xavier','Stone','1972-02-14',1,'33 Staff Lane','0911000024','xavier.stone@clinic.com'), -- ID 24
	('Available','Admin','staffadmin05','e179134b237bf0832ee7e25c8ad89f884502f12e935191d1168dd00dc6c06492',NULL,'Records Admin','Yara','Hill','1987-03-15',0,'34 Staff Lane','0911000025','yara.hill@clinic.com'), -- ID 25

	-- Password Doc@####(0011-0012)
	-- Password Pharm@##(06)
	-- Password Rec@####(0006)
	-- Password Adm@####(0006)
	('Available','Doctor','staffdoc11','6a8866235ce2349a8364a6bb283c309a4c6e962321de31c99b360135253b5523',NULL,'Visiting specialist','Zack','Morse','1971-04-16',1,'35 Staff Lane','0911000026','zack.morse@clinic.com'), -- ID 26
	('Available','Doctor','staffdoc12','8ff46c624ba22a72f7048716659a9b9c46aff19155fe1815675206ddbb89a1ba',NULL,'Visiting specialist','Ava','Noel','1986-05-17',0,'36 Staff Lane','0911000027','ava.noel@clinic.com'), -- ID 27
	('Available','Pharmacist','staffph06','f15bdb1c2cdeb757c9ff10a0078d71092e4ecf6ff94d406358366542849e4443',NULL,'Pharmacist','Ben','Carter','1991-06-18',1,'37 Staff Lane','0911000028','ben.carter@clinic.com'), -- ID 28
	('Available','Receptionist','staffrec06','769fb92612426a23c1cc3f8aeeb494f49016d003079b099e1b887b1b2632cd5b',NULL,'Reception','Cara','Miles','1992-07-19',0,'38 Staff Lane','0911000029','cara.miles@clinic.com'), -- ID 29
	('Available','Admin','staffadmin06','bb8e2b9d0a554432502b84a4c2c2ab7b985a046ba3dad40311342f6b99556e0b',NULL,'Finance','Drew','Yates','1985-08-20',1,'39 Staff Lane','0911000030','drew.yates@clinic.com'); -- ID 30

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
('Tablet',1,'Paracetamol 500mg','MED001',200,0.19), -- ID 1
('Capsule',1,'Amoxicillin 500mg','MED002',150,0.35), -- ID 2
('Syrup',1,'Cough Syrup 100ml','MED003',80,0.49), -- ID 3
('Ointment',1,'Hydrocortisone 1%','MED004',60,0.39), -- ID 4
('Drops',1,'Eye Drops 10ml','MED005',50,0.59), -- ID 5
('Tablet',1,'Ibuprofen 200mg','MED006',180,0.17), -- ID 6
('Capsule',1,'Omeprazole 20mg','MED007',120,0.79), -- ID 7
('Tablet',1,'Aspirin 81mg','MED008',300,0.09), -- ID 8
('Capsule',1,'Metformin 500mg','MED009',160,0.31), -- ID 9
('Tablet',1,'Loratadine 10mg','MED010',140,0.22), -- ID 10
('Syrup',1,'Children Multivitamin','MED011',90,0.69), -- ID 11
('Tablet',1,'Prednisone 10mg','MED012',50,0.29), -- ID 12
('Capsule',1,'Doxycycline 100mg','MED013',70,0.33), -- ID 13
('Ointment',1,'Antifungal Cream','MED014',40,0.25), -- ID 14
('Drops',1,'Ear Drops 10ml','MED015',30,0.59), -- ID 15
('Tablet',1,'Clopidogrel 75mg','MED016',60,0.89), -- ID 16
('Capsule',1,'Levothyroxine 50mcg','MED017',90,0.34), -- ID 17
('Tablet',1,'Zinc Supplement 50mg','MED018',200,0.14), -- ID 18
('Capsule',1,'Fluconazole 150mg','MED019',45,0.56), -- ID 19
('Syrup',1,'Antacid Syrup','MED020',110,0.39), -- ID 20
('Tablet',1,'Losartan 50mg','MED021',75,0.27), -- ID 21
('Capsule',1,'Albuterol 2mg','MED022',100,0.44), -- ID 22
('Tablet',1,'Vitamin D 1000IU','MED023',210,0.13), -- ID 23
('Capsule',1,'Nitrofurantoin 100mg','MED024',55,0.48), -- ID 24
('Tablet',1,'Tramadol 50mg','MED025',35,0.65), -- ID 25
('Ointment',1,'Antiseptic Ointment','MED026',40,0.19), -- ID 26
('Drops',1,'Nasal Drops 15ml','MED027',65,0.33), -- ID 27
('Capsule',1,'Gabapentin 300mg','MED028',25,0.72), -- ID 28
('Tablet',1,'Hydrochlorothiazide 25mg','MED029',120,0.21), -- ID 29
('Capsule',1,'Clarithromycin 500mg','MED030',50,0.50); -- ID 30


	-- 9. APPOINTMENTS - Current date: 2025-11-03 (Tuân thủ các quy tắc đặt lịch)
	-- Rules: 1) Đặt trước 24h, 2) Cách nhau 24h, 3) 7h-17h, 4) Trong 30 ngày, 5) Không trùng giờ bác sĩ, 6) Cách nhau 30 phút
	INSERT INTO Appointment (PatientID, DoctorID, AppointmentStatus, DateCreate, DateBegin, DateEnd, Note)
	VALUES
	-- COMPLETED APPOINTMENTS (Trước 03/11/2025) - Patient 1
	(1,1,'Completed','2025-09-01','2025-09-02 09:00','2025-09-02 09:30','Routine cardiac check'), -- ID 1
	(1,2,'Completed','2025-09-10','2025-09-11 10:00','2025-09-11 10:30','Skin consultation'), -- ID 2
	(1,3,'Completed','2025-09-20','2025-09-21 14:00','2025-09-21 14:30','General health check'), -- ID 3
	(1,4,'Completed','2025-10-01','2025-10-02 11:00','2025-10-02 11:30','Joint pain evaluation'), -- ID 4
	(1,5,'Completed','2025-10-10','2025-10-11 09:00','2025-10-11 09:30','Headache assessment'), -- ID 5
	(1,1,'Completed','2025-10-18','2025-10-19 13:00','2025-10-19 13:30','Cardiology follow-up'), -- ID 6
	(1,6,'Completed','2025-10-25','2025-10-26 15:00','2025-10-26 15:30','Blood sugar check'), -- ID 7
	(1,7,'Completed','2025-10-28','2025-10-29 10:00','2025-10-29 10:30','Vision screening'), -- ID 8
	(1,8,'Completed','2025-10-30','2025-10-31 14:00','2025-10-31 14:30','Ear examination'), -- ID 9
	(1,10,'Completed','2025-11-01','2025-11-02 11:00','2025-11-02 11:30','Annual physical'), -- ID 10
	
	-- APPROVED/PENDING APPOINTMENTS (04/11 - 03/12/2025) - Patient 1
	(1,9,'Approved','2025-11-02','2025-11-05 09:00','2025-11-05 09:30','Stress consultation'), -- ID 11
	(1,2,'Approved','2025-11-02','2025-11-08 13:00','2025-11-08 13:30','Skin follow-up'), -- ID 12
	(1,3,'Pending','2025-11-02','2025-11-12 10:00','2025-11-12 10:30','Preventive care'), -- ID 13
	(1,4,'Pending','2025-11-02','2025-11-16 14:00','2025-11-16 14:30','Orthopedic consultation'), -- ID 14
	(1,5,'Pending','2025-11-02','2025-11-20 11:00','2025-11-20 11:30','Neurology check'), -- ID 15
	(1,1,'Pending','2025-11-02','2025-11-25 09:00','2025-11-25 09:30','Cardiac screening'), -- ID 16
	
	-- CANCELED APPOINTMENT - Patient 1
	(1,6,'Canceled','2025-10-20','2025-11-06 08:00','2025-11-06 08:30','Patient canceled'), -- ID 17
	
	-- DOCTOR 1 (Cardiologist) - Other Patients (Cách nhau 30 phút)
	(2,1,'Completed','2025-09-03','2025-09-04 09:30','2025-09-04 10:00','Chest pain follow-up'), -- ID 18
	(5,1,'Completed','2025-09-15','2025-09-16 10:00','2025-09-16 10:30','Pregnancy heart check'), -- ID 19
	(6,1,'Completed','2025-09-25','2025-09-26 10:30','2025-09-26 11:00','High cholesterol'), -- ID 20
	(7,1,'Completed','2025-10-03','2025-10-04 11:00','2025-10-04 11:30','Smoker cardiac screening'), -- ID 21
	(8,1,'Completed','2025-10-12','2025-10-13 11:30','2025-10-13 12:00','Young adult heart check'), -- ID 22
	(11,1,'Completed','2025-10-20','2025-10-21 13:30','2025-10-21 14:00','Stress-related heart'), -- ID 23
	(14,1,'Completed','2025-10-27','2025-10-28 14:00','2025-10-28 14:30','Cardiac monitoring'), -- ID 24
	(16,1,'Completed','2025-10-29','2025-10-30 14:30','2025-10-30 15:00','Post-fracture cardiac'), -- ID 25
	(19,1,'Completed','2025-10-31','2025-11-01 15:00','2025-11-01 15:30','Heart check'), -- ID 26
	(22,1,'Approved','2025-11-02','2025-11-06 09:30','2025-11-06 10:00','Anxiety cardiac screen'), -- ID 27
	(24,1,'Approved','2025-11-02','2025-11-09 10:00','2025-11-09 10:30','Post-op monitoring'), -- ID 28
	(26,1,'Approved','2025-11-02','2025-11-13 13:00','2025-11-13 13:30','Thyroid heart eval'), -- ID 29
	(28,1,'Pending','2025-11-02','2025-11-18 09:30','2025-11-18 10:00','Cardiac check'), -- ID 30
	(29,1,'Pending','2025-11-02','2025-11-22 14:00','2025-11-22 14:30','Smoker recovery'), -- ID 31
	(30,1,'Pending','2025-11-02','2025-11-27 15:00','2025-11-27 15:30','Heart screening'), -- ID 32
	(12,1,'Canceled','2025-10-28','2025-11-10 11:00','2025-11-10 11:30','Teen patient - canceled'), -- ID 33
	
	-- OTHER DOCTORS - Various Patients (Completed in past)
	(3,2,'Completed','2025-09-05','2025-09-06 11:00','2025-09-06 11:30','Skin rash'), -- ID 34
	(4,3,'Completed','2025-09-12','2025-09-13 09:30','2025-09-13 10:00','Child fever'), -- ID 35
	(5,4,'Completed','2025-09-18','2025-09-19 14:00','2025-09-19 14:30','Knee pain'), -- ID 36
	(6,5,'Completed','2025-09-22','2025-09-23 15:00','2025-09-23 15:30','Headache review'), -- ID 37
	(7,6,'Completed','2025-09-28','2025-09-29 08:00','2025-09-29 08:30','Diabetes review'), -- ID 38
	(8,7,'Completed','2025-10-05','2025-10-06 10:00','2025-10-06 10:30','Eye check'), -- ID 39
	(9,8,'Completed','2025-10-08','2025-10-09 11:00','2025-10-09 11:30','Ear pain'), -- ID 40
	(10,9,'Completed','2025-10-14','2025-10-15 16:00','2025-10-15 16:30','Mental health'), -- ID 41
	(11,10,'Completed','2025-10-16','2025-10-17 09:00','2025-10-17 09:30','Blood pressure'), -- ID 42
	(12,2,'Completed','2025-10-21','2025-10-22 10:00','2025-10-22 10:30','Acne treatment'), -- ID 43
	(13,3,'Completed','2025-10-23','2025-10-24 11:30','2025-10-24 12:00','Child vaccination'), -- ID 44
	(14,4,'Completed','2025-10-26','2025-10-27 14:30','2025-10-27 15:00','Fracture check'), -- ID 45
	(15,5,'Completed','2025-10-28','2025-10-29 15:30','2025-10-29 16:00','Neurology consult'), -- ID 46
	(16,10,'Completed','2025-10-30','2025-10-31 08:00','2025-10-31 08:30','General check'), -- ID 47
	(17,7,'Completed','2025-11-01','2025-11-02 09:00','2025-11-02 09:30','Cataract review'), -- ID 48
	
	-- APPROVED/PENDING - Other Doctors (04/11 - 03/12)
	(18,8,'Approved','2025-11-02','2025-11-07 10:00','2025-11-07 10:30','Sinusitis'), -- ID 49
	(19,9,'Approved','2025-11-02','2025-11-11 11:00','2025-11-11 11:30','Depression check'), -- ID 50
	(20,10,'Approved','2025-11-02','2025-11-14 12:00','2025-11-14 12:30','General check'), -- ID 51
	(21,2,'Pending','2025-11-02','2025-11-19 13:00','2025-11-19 13:30','Skin consultation'), -- ID 52
	(22,3,'Pending','2025-11-02','2025-11-23 11:00','2025-11-23 11:30','Pediatric review'), -- ID 53
	(23,4,'Pending','2025-11-02','2025-11-26 14:00','2025-11-26 14:30','Orthopedic therapy'), -- ID 54
	(25,5,'Pending','2025-11-02','2025-11-29 15:00','2025-11-29 15:30','Neuro follow-up'), -- ID 55
	(26,6,'Pending','2025-11-02','2025-12-02 08:30','2025-12-02 09:00','Endocrine consult'), -- ID 56
	(27,7,'Canceled','2025-10-29','2025-11-15 10:00','2025-11-15 10:30','Patient canceled'), -- ID 57
	(29,9,'Approved','2025-11-02','2025-11-17 12:00','2025-11-17 12:30','Psych consult'), -- ID 58
	(30,10,'Approved','2025-11-02','2025-11-21 13:00','2025-11-21 13:30','General exam'); -- ID 59

	-- 10. PRESCRIPTIONS - CHỈ cho Completed appointments (đã khám xong)
	-- Approved/Pending = chưa khám, không có prescription
	-- Status: Pending = bác sĩ kê đơn nhưng dược sĩ chưa phát, Delivered = đã phát thuốc
	INSERT INTO Prescription (AppointmentID, PrescriptionStatus, DateCreate, Note)
	VALUES
	-- Completed Appointments (Patient 1: ID 1-10)
	(1,'Delivered','2025-09-02','Cardiac medication'), -- ID 1
	(2,'Delivered','2025-09-11','Topical cream for skin'), -- ID 2
	(3,'Delivered','2025-09-21','General vitamins'), -- ID 3
	(4,'Pending','2025-10-02','Anti-inflammatory'), -- ID 4
	(5,'Delivered','2025-10-11','Migraine medication'), -- ID 5
	(6,'Delivered','2025-10-19','Heart medication refill'), -- ID 6
	(7,'Delivered','2025-10-26','Diabetes medication'), -- ID 7
	(8,'Delivered','2025-10-29','Eye drops'), -- ID 8
	-- ID 9 (Appt 9) - Không kê đơn thuốc
	(10,'Delivered','2025-11-02','Annual checkup meds'), -- ID 9
	
	-- Completed (Doctor 1 - Other Patients: ID 18-26)
	(18,'Delivered','2025-09-04','Cardiac meds'), -- ID 10
	(19,'Delivered','2025-09-16','Pregnancy vitamins'), -- ID 11
	(20,'Delivered','2025-09-26','Cholesterol meds'), -- ID 12
	(21,'Pending','2025-10-04','Cardiac screening meds - chưa phát'), -- ID 13
	(22,'Delivered','2025-10-13','Heart medication'), -- ID 14
	(23,'Delivered','2025-10-21','Stress relief meds'), -- ID 15
	(24,'Delivered','2025-10-28','Cardiac monitoring meds'), -- ID 16
	(25,'Delivered','2025-10-30','Post-fracture cardiac meds'), -- ID 17
	(26,'Pending','2025-11-01','Heart check prescription - chưa phát'), -- ID 18
	
	-- Completed (Other Doctors: ID 34-48)
	(34,'Delivered','2025-09-06','Skin rash ointment'), -- ID 19
	(35,'Delivered','2025-09-13','Pediatric fever meds'), -- ID 20
	(36,'Delivered','2025-09-19','Knee pain medication'), -- ID 21
	(37,'Delivered','2025-09-23','Headache meds'), -- ID 22
	(38,'Delivered','2025-09-29','Diabetes control'), -- ID 23
	(39,'Delivered','2025-10-06','Eye drops'), -- ID 24
	(40,'Pending','2025-10-09','Ear antibiotics - chưa phát'), -- ID 25
	(41,'Delivered','2025-10-15','Mental health meds'), -- ID 26
	(42,'Delivered','2025-10-17','BP medication'), -- ID 27
	-- ID 43 (Appt 43) - Không kê đơn thuốc
	(44,'Delivered','2025-10-24','Vaccination vitamins'), -- ID 28
	(45,'Delivered','2025-10-27','Fracture pain relief'), -- ID 29
	(46,'Pending','2025-10-29','Neurology meds - chưa phát'), -- ID 30
	(47,'Delivered','2025-10-31','General vitamins'), -- ID 31
	(48,'Delivered','2025-11-02','Eye care prescription'), -- ID 32
	
	-- Approved (Patient 1: ID 11, 12)
	(11,'Delivered','2025-11-05','Stress relief medication'), -- ID 33
	(12,'Delivered','2025-11-08','Skin treatment'), -- ID 34
	
	-- Approved (Doctor 1 - Other Patients: ID 27, 28, 29)
	(27,'Delivered','2025-11-06','Anxiety medication'), -- ID 35
	(28,'Delivered','2025-11-09','Post-op cardiac meds'), -- ID 36
	(29,'Delivered','2025-11-13','Thyroid medication'), -- ID 37
	
	-- Approved (Other Doctors: ID 49, 50, 51, 58, 59)
	(49,'Delivered','2025-11-07','Sinus medication'), -- ID 38
	(50,'Delivered','2025-11-11','Antidepressants'), -- ID 39
	(51,'Delivered','2025-11-14','General vitamins'), -- ID 40
	(58,'Delivered','2025-11-17','Mental health meds'), -- ID 41
	(59,'Delivered','2025-11-21','Preventive meds'); -- ID 42
	
	-- KHÔNG TẠO prescription cho Pending (ID 13-16,30-32,52-56) - chưa duyệt
	-- KHÔNG TẠO prescription cho Canceled (ID 17,33,57) - đã hủy

	-- 11. PRESCRIPTION ITEMS - Phụ thuộc vào Prescription (PrescriptionID) và Medicine (MedicineID)
	INSERT INTO PrescriptionItem (PrescriptionID, MedicineID, Dosage, Instruction) VALUES
	-- Patient 1 Prescriptions (Completed only)
	-- Prescription 1: Cardiac medication (3 items)
	(1,21,30,'1 tablet once daily in the morning'),
	(1,8,30,'1 tablet once daily with breakfast'),
	(1,23,30,'1 tablet daily for bone health'),
	
	-- Prescription 2: Skin treatment (2 items) 
	(2,14,1,'Apply to affected area twice daily'),
	(2,4,1,'Apply thin layer if irritation persists'),
	
	-- Prescription 3: General vitamins (2 items)
	(3,23,60,'1 tablet daily with breakfast'), 
	(3,18,30,'1 tablet daily for 30 days'),
	
	-- Prescription 4: Anti-inflammatory (3 items)
	(4,6,20,'1 tablet twice daily with food'),
	(4,26,1,'Apply to wounds as needed'),
	(4,1,10,'1 tablet as needed for fever'),
	
	-- Prescription 5: Migraine treatment (3 items)
	(5,28,30,'1 capsule at bedtime'),
	(5,6,20,'1 tablet as needed for headache'),
	(5,10,14,'1 tablet daily if allergic reaction'),
	
	-- Prescription 6: Heart medication refill (2 items)
	(6,21,30,'1 tablet once daily - continue'),
	(6,8,30,'1 tablet daily with breakfast'),
	
	-- Prescription 7: Diabetes medication (4 items)
	(7,9,60,'1 tablet twice daily with meals'),
	(7,23,30,'1 tablet daily'),
	(7,18,30,'1 tablet daily for healing'),
	(7,1,10,'1 tablet as needed for pain'),
	
	-- Prescription 8: Eye care (2 items)
	(8,5,3,'1-2 drops 3 times daily'),
	(8,23,30,'1 tablet daily'),
	
	-- Prescription 9: Annual checkup (3 items)
	(9,23,90,'1 tablet daily for 3 months'),
	(9,18,30,'1 tablet daily'),
	(9,11,1,'1 bottle - take as directed'),
	
	-- Doctor 1 Other Patients (Completed)
	-- Prescription 10: Cardiac meds (3 items)
	(10,21,30,'1 tablet daily for hypertension'),
	(10,8,30,'1 tablet daily for heart protection'),
	(10,16,30,'1 tablet daily as prescribed'),
	
	-- Prescription 11: Pregnancy vitamins (4 items)
	(11,23,90,'1 tablet daily for bone health'),
	(11,11,3,'1 bottle monthly prenatal vitamin'),
	(11,18,60,'1 tablet daily for immune support'),
	(11,1,20,'1 tablet as needed for minor pain'),
	
	-- Prescription 12: Cholesterol management (3 items)
	(12,9,60,'1 tablet daily for glucose control'),
	(12,21,30,'1 tablet daily for blood pressure'),
	(12,23,30,'1 tablet daily'),
	
	-- Prescription 13: Cardiac screening (2 items)
	(13,21,14,'1 tablet daily for 2 weeks'),
	(13,8,14,'1 tablet daily for 2 weeks'),
	
	-- Prescription 14: Heart medication (3 items)
	(14,21,30,'1 tablet daily for hypertension'),
	(14,8,30,'1 tablet daily for heart health'),
	(14,23,30,'1 tablet daily supplement'),
	
	-- Prescription 15: Stress relief (4 items)
	(15,28,30,'1 capsule at bedtime for anxiety'),
	(15,10,14,'1 tablet daily if needed'),
	(15,23,30,'1 tablet daily for mood support'),
	(15,1,10,'1 tablet as needed for headaches'),
	
	-- Prescription 16: Cardiac monitoring (2 items)
	(16,21,60,'1 tablet daily - 2 month supply'),
	(16,8,60,'1 tablet daily - continue'),
	
	-- Prescription 17: Post-fracture care (4 items)
	(17,6,40,'1 tablet twice daily for inflammation'),
	(17,25,20,'1 tablet as needed for severe pain'),
	(17,23,60,'1 tablet daily for bone healing'),
	(17,18,30,'1 tablet daily for tissue repair'),
	
	-- Prescription 18: Heart check (2 items)
	(18,21,30,'1 tablet daily maintenance'),
	(18,23,30,'1 tablet daily supplement'),
	
	-- Other Doctors (Completed)
	-- Prescription 19: Skin treatment (3 items)
	(19,14,2,'Apply twice daily to affected area'),
	(19,4,1,'Apply for inflammation as needed'),
	(19,26,1,'Apply for healing wounds'),
	
	-- Prescription 20: Pediatric fever (3 items)
	(20,1,20,'1/2 tablet twice daily for fever'),
	(20,11,1,'1 bottle children multivitamin'),
	(20,23,30,'1/2 tablet daily for recovery'),
	
	-- Prescription 21: Knee pain (3 items)
	(21,6,20,'1 tablet twice daily with food'),
	(21,26,1,'Apply to cuts as needed'),
	(21,1,10,'1 tablet as backup pain relief'),
	
	-- Prescription 22: Headache treatment (3 items)
	(22,28,14,'1 capsule at night for 2 weeks'),
	(22,6,10,'1 tablet as needed for headache'),
	(22,1,10,'1 tablet alternate pain relief'),
	
	-- Prescription 23: Diabetes control (4 items)
	(23,9,60,'1 tablet twice daily with meals'),
	(23,23,30,'1 tablet daily for bone health'),
	(23,18,30,'1 tablet daily for wound healing'),
	(23,1,10,'1 tablet as needed for minor pain'),
	
	-- Prescription 24: Eye care (2 items)
	(24,5,2,'1-2 drops 3 times daily'),
	(24,23,30,'1 tablet daily for general health'),
	
	-- Prescription 25: Ear infection (3 items)
	(25,2,14,'1 capsule twice daily for 7 days'),
	(25,15,1,'2 drops twice daily in affected ear'),
	(25,1,10,'1 tablet for pain relief as needed'),
	
	-- Prescription 26: Mental health (3 items)
	(26,28,30,'1 capsule daily for anxiety'),
	(26,23,30,'1 tablet daily for mood support'),
	(26,11,1,'1 bottle multivitamin monthly'),
	
	-- Prescription 27: Blood pressure (3 items)
	(27,21,30,'1 tablet daily for hypertension'),
	(27,29,30,'1 tablet daily as diuretic'),
	(27,23,30,'1 tablet daily supplement'),
	
	-- Prescription 28: Vaccination support (2 items)
	(28,11,1,'1 bottle for immune support'),
	(28,23,14,'1 tablet daily for 2 weeks'),
	
	-- Prescription 29: Fracture pain management (4 items)
	(29,6,40,'1 tablet twice daily for inflammation'),
	(29,25,30,'1 tablet as needed for severe pain'),
	(29,23,60,'1 tablet daily for bone healing'),
	(29,18,30,'1 tablet daily for tissue repair'),
	
	-- Prescription 30: Neurology treatment (3 items)
	(30,28,30,'1 capsule daily for neuropathy'),
	(30,23,30,'1 tablet daily for nerve health'),
	(30,11,1,'1 bottle multivitamin'),
	
	-- Prescription 31: General health (2 items)
	(31,23,90,'1 tablet daily for 3 months'),
	(31,18,30,'1 tablet daily for immunity'),
	
	-- Prescription 32: Eye post-op care (3 items)
	(32,5,2,'1-2 drops 4 times daily post-surgery'),
	(32,23,30,'1 tablet daily for healing'),
	(32,1,10,'1 tablet as needed for discomfort'),
	
	-- Approved Appointments (Patient 1: ID 33, 34)
	-- Prescription 33: Stress management (4 items)
	(33,28,30,'1 capsule at bedtime for stress'),
	(33,10,14,'1 tablet daily for stress allergies'),
	(33,23,30,'1 tablet daily for mood support'),
	(33,11,1,'1 bottle multivitamin monthly'),
	
	-- Prescription 34: Skin eczema treatment (3 items)
	(34,14,2,'Apply twice daily to affected area'),
	(34,4,1,'Apply for inflammation as needed'),
	(34,23,30,'1 tablet daily for skin health'),
	
	-- Approved (Doctor 1 - Other Patients: ID 35, 36, 37)
	-- Prescription 35: Anxiety cardiac care (4 items)
	(35,21,30,'1 tablet daily for blood pressure'),
	(35,8,30,'1 tablet daily for heart protection'),
	(35,28,30,'1 capsule daily for anxiety'),
	(35,23,30,'1 tablet daily for mood and bone health'),
	
	-- Prescription 36: Post-op cardiac care (3 items)
	(36,21,60,'1 tablet daily - 2 month supply'),
	(36,8,60,'1 tablet daily for cardiac protection'),
	(36,23,30,'1 tablet daily for healing support'),
	
	-- Prescription 37: Thyroid treatment (3 items)
	(37,17,90,'1 capsule daily on empty stomach'),
	(37,23,30,'1 tablet daily (4 hours after thyroid med)'),
	(37,18,30,'1 tablet daily for thyroid support'),
	
	-- Approved (Other Doctors: ID 38, 39, 40, 41, 42)
	-- Prescription 38: Sinus infection (4 items)
	(38,2,14,'1 capsule twice daily for 7 days'),
	(38,27,1,'2 drops twice daily for congestion'),
	(38,1,20,'1 tablet twice daily for pain'),
	(38,10,14,'1 tablet daily for allergic component'),
	
	-- Prescription 39: Depression treatment (3 items)
	(39,28,30,'1 capsule daily for depression anxiety'),
	(39,23,90,'1 tablet daily for mood support'),
	(39,11,3,'1 bottle monthly nutritional support'),
	
	-- Prescription 40: General wellness (3 items)
	(40,23,90,'1 tablet daily for 3 months'),
	(40,18,60,'1 tablet daily for 2 months'),
	(40,11,1,'1 bottle for overall health'),
	
	-- Prescription 41: Anxiety disorder (4 items)
	(41,28,30,'1 capsule at bedtime for anxiety'),
	(41,10,30,'1 tablet daily for stress allergies'),
	(41,23,30,'1 tablet daily for mood stabilization'),
	(41,1,20,'1 tablet as needed for tension headaches'),
	
	-- Prescription 42: Preventive care (3 items)
	(42,23,90,'1 tablet daily for bone health'),
	(42,18,60,'1 tablet daily for immune support'),
	(42,11,3,'1 bottle for comprehensive nutrition');

	-- 12. MEDICAL RECORDS - Cho Completed và Approved appointments
	-- Completed = đã khám xong
	-- Approved = đã duyệt, có thể bắt đầu khám
	-- Pending = chưa duyệt → KHÔNG có medical record
	-- Canceled = đã hủy → KHÔNG có medical record
	INSERT INTO MedicalRecord (AppointmentID, PrescriptionID, Symptoms, Diagnosis, Note, DateCreate)
	VALUES
	-- Patient 1 - Completed (ID 1-10)
	(1,1,'Chest discomfort','Stable condition','Cardiac check completed','2025-09-02'),
	(2,2,'Skin irritation','Mild dermatitis','Topical treatment','2025-09-11'),
	(3,3,'Routine checkup','Healthy','No issues found','2025-09-21'),
	(4,4,'Joint pain','Minor inflammation','Physical therapy advised','2025-10-02'),
	(5,5,'Headache','Tension headache','Medication prescribed','2025-10-11'),
	(6,6,'Heart palpitations','Normal rhythm','Continue monitoring','2025-10-19'),
	(7,7,'High blood sugar','Diabetes controlled','Medication adjusted','2025-10-26'),
	(8,8,'Blurry vision','Eye strain','Eye drops prescribed','2025-10-29'),
	(9,NULL,'Ear discomfort','Minor infection','No medication needed','2025-10-31'),
	(10,9,'Annual physical','Healthy','All tests normal','2025-11-02'),
	
	-- Doctor 1 Other Patients - Completed (ID 18-26)
	(18,11,'Chest pain','Angina','Cardiac medication','2025-09-04'),
	(19,12,'Pregnancy checkup','Normal','Vitamins prescribed','2025-09-16'),
	(20,13,'High cholesterol','Hyperlipidemia','Medication started','2025-09-26'),
	(21,14,'Cardiac screening','Normal','Preventive care','2025-10-04'),
	(22,15,'Heart check','Healthy','Continue monitoring','2025-10-13'),
	(23,16,'Stress-related','Anxiety','Medication prescribed','2025-10-21'),
	(24,17,'Cardiac monitoring','Stable','Continue treatment','2025-10-28'),
	(25,18,'Post-fracture check','Healing well','Pain management','2025-10-30'),
	(26,19,'Heart screening','Normal','Routine checkup','2025-11-01'),
	
	-- Other Doctors - Completed (ID 34-48)
	(34,19,'Skin rash','Contact dermatitis','Ointment prescribed','2025-09-06'),
	(35,20,'Child fever','Viral infection','Medication given','2025-09-13'),
	(36,21,'Knee pain','Sprain','Pain relief prescribed','2025-09-19'),
	(37,22,'Headache','Migraine','Treatment started','2025-09-23'),
	(38,23,'High sugar','Diabetes','Medication adjusted','2025-09-29'),
	(39,24,'Eye check','Normal vision','Preventive care','2025-10-06'),
	(40,25,'Ear pain','Otitis media','Antibiotics given','2025-10-09'),
	(41,26,'Mental health','Anxiety','Therapy recommended','2025-10-15'),
	(42,27,'High BP','Hypertension','BP meds prescribed','2025-10-17'),
	(43,NULL,'Acne','Acne vulgaris','No medication needed','2025-10-22'),
	(44,28,'Vaccination','Healthy','Vaccination completed','2025-10-24'),
	(45,29,'Fracture review','Healing','Continue therapy','2025-10-27'),
	(46,30,'Numbness','Neuropathy','Medication prescribed','2025-10-29'),
	(47,31,'General check','Healthy','No issues','2025-10-31'),
	(48,32,'Eye review','Post-op normal','Healing well','2025-11-02'),
	
	-- Approved - Patient 1 (ID 11, 12)
	(11,33,'Stress and anxiety','Stress disorder','Counseling recommended','2025-11-05'),
	(12,34,'Skin irritation','Eczema flare-up','Topical treatment','2025-11-08'),
	
	-- Approved - Doctor 1 Other Patients (ID 27, 28, 29)
	(27,35,'Heart palpitations','Anxiety-induced','Cardiac monitoring','2025-11-06'),
	(28,36,'Post-operative check','Recovery on track','Continue medication','2025-11-09'),
	(29,37,'Thyroid symptoms','Hypothyroidism','Medication adjustment','2025-11-13'),
	
	-- Approved - Other Doctors (ID 49, 50, 51, 58, 59)
	(49,38,'Sinus pain','Acute sinusitis','Antibiotics prescribed','2025-11-07'),
	(50,39,'Depression symptoms','Major depressive disorder','Therapy initiated','2025-11-11'),
	(51,40,'Routine checkup','Healthy','Preventive care','2025-11-14'),
	(58,41,'Anxiety disorder','Generalized anxiety','Medication started','2025-11-17'),
	(59,42,'Annual physical','Normal results','Follow-up in 1 year','2025-11-21');
	
	-- KHÔNG TẠO Medical Record cho Canceled (ID 17,33,57) - đã hủy
	-- KHÔNG TẠO Medical Record cho Pending (ID 13-16,30-32,52-56) - chưa duyệt

	-- 13. INVOICES - TỰ ĐỘNG SINH khi có Medical Record
	-- Completed = đã khám → có Medical Record → có Invoice
	-- Approved = đã duyệt → có Medical Record → có Invoice
	-- Pending = chưa duyệt → KHÔNG có Medical Record → KHÔNG có Invoice
	-- Canceled = đã hủy → KHÔNG có Medical Record → KHÔNG có Invoice
	-- Invoice với Prescription.Delivered = Paid
	-- Invoice với Prescription.Pending = Pending (chưa thanh toán do chưa phát thuốc)
	-- Patient 1 - Completed (MR ID 1-10)
	UPDATE Invoice SET MedicalRecordID=1, PrescriptionID=1, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-02' WHERE InvoiceID=1;
	UPDATE Invoice SET MedicalRecordID=2, PrescriptionID=2, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-09-11' WHERE InvoiceID=2;
	UPDATE Invoice SET MedicalRecordID=3, PrescriptionID=3, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-09-21' WHERE InvoiceID=3;
	UPDATE Invoice SET MedicalRecordID=4, PrescriptionID=4, PaymentType=NULL, InvoiceStatus='Pending', DatePay=NULL WHERE InvoiceID=4;
	UPDATE Invoice SET MedicalRecordID=5, PrescriptionID=5, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-11' WHERE InvoiceID=5;
	UPDATE Invoice SET MedicalRecordID=6, PrescriptionID=6, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-10-19' WHERE InvoiceID=6;
	UPDATE Invoice SET MedicalRecordID=7, PrescriptionID=7, PaymentType=NULL, InvoiceStatus='Pending', DatePay='2025-10-26' WHERE InvoiceID=7;
	UPDATE Invoice SET MedicalRecordID=8, PrescriptionID=8, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-29' WHERE InvoiceID=8;
	UPDATE Invoice SET MedicalRecordID=9, PrescriptionID=NULL, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-01' WHERE InvoiceID=9;
	UPDATE Invoice SET MedicalRecordID=10, PrescriptionID=9, PaymentType=NULL, InvoiceStatus='Pending', DatePay='2025-11-02' WHERE InvoiceID=10;

	-- Doctor 1 Other Patients - Completed (MR ID 11-19)
	UPDATE Invoice SET MedicalRecordID=11, PrescriptionID=10, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-09-04' WHERE InvoiceID=11;
	UPDATE Invoice SET MedicalRecordID=12, PrescriptionID=11, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-17' WHERE InvoiceID=12;
	UPDATE Invoice SET MedicalRecordID=13, PrescriptionID=12, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-26' WHERE InvoiceID=13;
	UPDATE Invoice SET MedicalRecordID=14, PrescriptionID=13, PaymentType=NULL, InvoiceStatus='Pending', DatePay=NULL WHERE InvoiceID=14;
	UPDATE Invoice SET MedicalRecordID=15, PrescriptionID=14, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-10-13' WHERE InvoiceID=15;
	UPDATE Invoice SET MedicalRecordID=16, PrescriptionID=15, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-21' WHERE InvoiceID=16;
	UPDATE Invoice SET MedicalRecordID=17, PrescriptionID=16, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-29' WHERE InvoiceID=17;
	UPDATE Invoice SET MedicalRecordID=18, PrescriptionID=17, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-30' WHERE InvoiceID=18;
	UPDATE Invoice SET MedicalRecordID=19, PrescriptionID=18, PaymentType=NULL, InvoiceStatus='Pending', DatePay=NULL WHERE InvoiceID=19;

	-- Other Doctors - Completed (MR ID 20-34)
	UPDATE Invoice SET MedicalRecordID=20, PrescriptionID=19, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-06' WHERE InvoiceID=20;
	UPDATE Invoice SET MedicalRecordID=21, PrescriptionID=20, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-09-13' WHERE InvoiceID=21;
	UPDATE Invoice SET MedicalRecordID=22, PrescriptionID=21, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-19' WHERE InvoiceID=22;
	UPDATE Invoice SET MedicalRecordID=23, PrescriptionID=22, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-24' WHERE InvoiceID=23;
	UPDATE Invoice SET MedicalRecordID=24, PrescriptionID=23, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-09-29' WHERE InvoiceID=24;
	UPDATE Invoice SET MedicalRecordID=25, PrescriptionID=24, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-10-06' WHERE InvoiceID=25;
	UPDATE Invoice SET MedicalRecordID=26, PrescriptionID=25, PaymentType=NULL, InvoiceStatus='Pending', DatePay=NULL WHERE InvoiceID=26;
	UPDATE Invoice SET MedicalRecordID=27, PrescriptionID=26, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-16' WHERE InvoiceID=27;
	UPDATE Invoice SET MedicalRecordID=28, PrescriptionID=27, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-17' WHERE InvoiceID=28;
	UPDATE Invoice SET MedicalRecordID=29, PrescriptionID=NULL, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-10-22' WHERE InvoiceID=29;
	UPDATE Invoice SET MedicalRecordID=30, PrescriptionID=28, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-24' WHERE InvoiceID=30;
	UPDATE Invoice SET MedicalRecordID=31, PrescriptionID=29, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-10-28' WHERE InvoiceID=31;
	UPDATE Invoice SET MedicalRecordID=32, PrescriptionID=30, PaymentType=NULL, InvoiceStatus='Pending', DatePay=NULL WHERE InvoiceID=32;
	UPDATE Invoice SET MedicalRecordID=33, PrescriptionID=31, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-10-31' WHERE InvoiceID=33;
	UPDATE Invoice SET MedicalRecordID=34, PrescriptionID=32, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-02' WHERE InvoiceID=34;

	-- Approved - Patient 1 (MR ID 35-36)
	UPDATE Invoice SET MedicalRecordID=35, PrescriptionID=33, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-11-05' WHERE InvoiceID=35;
	UPDATE Invoice SET MedicalRecordID=36, PrescriptionID=34, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-08' WHERE InvoiceID=36;

	-- Approved - Doctor 1 Other Patients (MR ID 37-39)
	UPDATE Invoice SET MedicalRecordID=37, PrescriptionID=35, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-06' WHERE InvoiceID=37;
	UPDATE Invoice SET MedicalRecordID=38, PrescriptionID=36, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-09' WHERE InvoiceID=38;
	UPDATE Invoice SET MedicalRecordID=39, PrescriptionID=37, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-11-13' WHERE InvoiceID=39;

	-- Approved - Other Doctors (MR ID 40-44)
	UPDATE Invoice SET MedicalRecordID=40, PrescriptionID=38, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-11-07' WHERE InvoiceID=40;
	UPDATE Invoice SET MedicalRecordID=41, PrescriptionID=39, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-11' WHERE InvoiceID=41;
	UPDATE Invoice SET MedicalRecordID=42, PrescriptionID=40, PaymentType='Cash', InvoiceStatus='Paid', DatePay='2025-11-14' WHERE InvoiceID=42;
	UPDATE Invoice SET MedicalRecordID=43, PrescriptionID=41, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-17' WHERE InvoiceID=43;
	UPDATE Invoice SET MedicalRecordID=44, PrescriptionID=42, PaymentType='Credit Card', InvoiceStatus='Paid', DatePay='2025-11-21' WHERE InvoiceID=44;
	
	-- KHÔNG TẠO Invoice cho Pending (ID 13-16,30-32,52-56) - chưa duyệt
	-- KHÔNG TẠO Invoice cho Canceled (ID 17,33,57) - đã hủy

	-- ---------- DOCTOR REVIEWS (30 sample) - Chỉ cho Completed appointments ----------
	INSERT INTO DoctorReview (PatientID, DoctorID, Content, RateScore, DateCreate) VALUES
	-- Patient 1 reviews (After completed appointments)
	(1,1,'Very professional cardiologist',5,'2025-09-03'),
	(1,2,'Excellent dermatologist, very thorough',5,'2025-09-12'),
	(1,3,'Great general practitioner',4,'2025-09-22'),
	(1,4,'Helpful orthopedic consultation',4,'2025-10-03'),
	(1,5,'Experienced neurologist',5,'2025-10-12'),
	(1,1,'Follow-up was very helpful',5,'2025-10-20'),
	(1,6,'Good endocrinologist',4,'2025-10-27'),
	(1,7,'Excellent eye care',5,'2025-10-30'),
	(1,8,'Professional ENT specialist',4,'2025-11-01'),
	
	-- Other patients reviews
	(2,1,'Cardiac care excellent',5,'2025-09-05'),
	(5,1,'Very caring doctor',5,'2025-09-17'),
	(6,1,'Thorough examination',4,'2025-09-27'),
	(7,1,'Excellent cardiac screening',5,'2025-10-05'),
	(8,1,'Young and knowledgeable',5,'2025-10-14'),
	(11,1,'Very professional',4,'2025-10-22'),
	(14,1,'Great follow-up care',5,'2025-10-29'),
	(16,1,'Comprehensive check',4,'2025-10-31'),
	(19,1,'Excellent heart specialist',5,'2025-11-02'),
	
	-- Other doctors reviews
	(3,2,'Skin problem solved',5,'2025-09-07'),
	(4,3,'Good with children',5,'2025-09-14'),
	(5,4,'Helpful orthopedist',4,'2025-09-20'),
	(6,5,'Excellent neurologist',5,'2025-09-24'),
	(7,6,'Good diabetes management',4,'2025-09-30'),
	(8,7,'Professional eye doctor',5,'2025-10-07'),
	(9,8,'ENT specialist helpful',4,'2025-10-10'),
	(10,9,'Supportive psychiatrist',5,'2025-10-16'),
	(11,10,'Good general practitioner',4,'2025-10-18'),
	(12,2,'Acne treatment effective',5,'2025-10-23'),
	(13,3,'Pediatrician very caring',5,'2025-10-25'),
	(15,5,'Neurology consultation helpful',4,'2025-10-30');
END
