USE ClinicBookingDatabase
GO

-- Update doctor bios with detailed information
UPDATE Account 
SET Bio = 'Dr. John Smith is a highly experienced cardiologist with over 10 years of practice in cardiovascular medicine. He specializes in heart disease prevention, cardiac catheterization, and interventional cardiology. Dr. Smith completed his medical degree at Harvard Medical School and his cardiology fellowship at Johns Hopkins Hospital. He is board-certified and has published numerous research papers on heart health and preventive cardiology.'
WHERE UserAccountID = 7;

UPDATE Account 
SET Bio = 'Dr. Anna Tran is a dedicated dermatologist with 8 years of experience in medical and cosmetic dermatology. She specializes in skin cancer detection, acne treatment, and anti-aging procedures. Dr. Tran earned her medical degree from Can Tho University and completed her dermatology residency at Cho Ray Hospital. She is passionate about helping patients achieve healthy, beautiful skin through evidence-based treatments.'
WHERE UserAccountID = 8;

UPDATE Account 
SET Bio = 'Dr. Kien Nguyen is an experienced dentist with 12 years of practice in general and cosmetic dentistry. He specializes in dental implants, orthodontics, and oral surgery. Dr. Nguyen graduated from Hanoi Medical University and has advanced training in implantology and smile design. He is committed to providing painless, high-quality dental care in a comfortable environment.'
WHERE UserAccountID = 9;

UPDATE Account 
SET Bio = 'Dr. Hieu Pham is a compassionate pediatrician with 6 years of experience caring for children from infancy through adolescence. He specializes in child development, immunizations, and pediatric emergency care. Dr. Pham completed his medical training at University of Medicine and Pharmacy at Ho Chi Minh City and his pediatric residency at Children''s Hospital 1. He is dedicated to promoting child health and family wellness.'
WHERE UserAccountID = 19;

UPDATE Account 
SET Bio = 'Dr. Thao Vu is a skilled ophthalmologist with 7 years of experience in comprehensive eye care. She specializes in cataract surgery, glaucoma treatment, and retinal disorders. Dr. Vu earned her medical degree from Hue University of Medicine and Pharmacy and completed her ophthalmology residency at Vietnam National Eye Hospital. She is committed to preserving and improving her patients'' vision through advanced medical and surgical treatments.'
WHERE UserAccountID = 20;