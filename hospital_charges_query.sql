USE inpatient_hospital_charges_db;
-- Check how many rows were imported
SELECT COUNT(*) AS total_records FROM hospital_charges;

-- Peek at column names and data types
DESCRIBE hospital_charges;

ALTER TABLE hospital_charges
CHANGE `DRG Definition` drg_definition TEXT,
CHANGE `Provider Id` provider_id INT,
CHANGE `Provider Name` provider_name TEXT,
CHANGE `Provider Street Address` provider_street_address TEXT,
CHANGE `Provider City` provider_city TEXT,
CHANGE `Provider State` provider_state TEXT,
CHANGE `Provider Zip Code` provider_zip_code INT,
CHANGE `Hospital Referral Region Description` hospital_referral_region_description TEXT,
CHANGE `Total Discharges` total_discharges INT,
CHANGE `Average Covered Charges` average_covered_charges TEXT,
CHANGE `Average Total Payments` average_total_payments TEXT,
CHANGE `Average Medicare Payments` average_medicare_payments TEXT;

SELECT 
  SUM(provider_id IS NULL) AS missing_provider_id,
  SUM(provider_name IS NULL) AS missing_provider_name,
  SUM(drg_definition IS NULL) AS missing_drg
FROM hospital_charges;

-- Basic row & column info
SELECT 
  COUNT(*) AS total_records,
  COUNT(DISTINCT provider_id) AS unique_providers,
  COUNT(DISTINCT provider_state) AS states_covered
FROM hospital_charges;

-- Confirm value ranges for discharges and payments
-- SELECT 
--   MIN(total_discharges) AS min_discharges,
--   MAX(total_discharges) AS max_discharges,
--   MIN(CAST(average_total_payments AS DECIMAL(10,2))) AS min_payment,
--   MAX(CAST(average_total_payments AS DECIMAL(10,2))) AS max_payment
-- FROM hospital_charges;

SELECT DISTINCT LEFT(average_total_payments, 20)
FROM hospital_charges
LIMIT 20;

UPDATE hospital_charges
SET
  average_total_payments_clean  = CAST(REGEXP_REPLACE(`average_total_payments`,  '[^0-9.]', '') AS DECIMAL(10,2)),
  average_covered_charges_clean = CAST(REGEXP_REPLACE(`average_covered_charges`, '[^0-9.]', '') AS DECIMAL(10,2)),
  average_medicare_payments_clean = CAST(REGEXP_REPLACE(`average_medicare_payments`, '[^0-9.]', '') AS DECIMAL(10,2));

SELECT average_total_payments
FROM hospital_charges 
LIMIT 10;

# ALTER TABLE hospital_charges 
# ADD COLUMN average_total_payments_clean DECIMAL(10,2);

DESCRIBE hospital_charges;

SELECT 
  average_total_payments
FROM hospital_charges
WHERE average_total_payments NOT REGEXP '^[0-9.,$]+$'
   OR average_total_payments IS NULL
LIMIT 50;

ALTER TABLE hospital_charges
ADD COLUMN average_covered_charges_clean DECIMAL(10,2),
ADD COLUMN average_medicare_payments_clean DECIMAL(10,2);

DESCRIBE hospital_charges;

UPDATE hospital_charges
SET
  average_covered_charges_clean =
    CAST(REGEXP_REPLACE(`average_covered_charges`, '[^0-9.]', '') AS DECIMAL(10,2)),
  average_total_payments_clean  =
    CAST(REGEXP_REPLACE(`average_total_payments`,  '[^0-9.]', '') AS DECIMAL(10,2)),
  average_medicare_payments_clean =
    CAST(REGEXP_REPLACE(`average_medicare_payments`, '[^0-9.]', '') AS DECIMAL(10,2));

SELECT 
  MIN(total_discharges) AS min_discharges,
  MAX(total_discharges) AS max_discharges,
  MIN(average_total_payments_clean) AS min_payment,
  MAX(average_total_payments_clean) AS max_payment
FROM hospital_charges;

-- Average Hospital Payment by State
SELECT 
  provider_state,
  ROUND(AVG(average_total_payments_clean), 2) AS avg_total_payment,
  ROUND(AVG(average_medicare_payments_clean), 2) AS avg_medicare_payment,
  COUNT(DISTINCT provider_id) AS hospital_count
FROM hospital_charges
GROUP BY provider_state
ORDER BY avg_total_payment DESC;

-- Top 10 DRGs (Diagnosis-Related Groups) by Average Total Payment
SELECT 
  drg_definition,
  ROUND(AVG(average_total_payments_clean), 2) AS avg_total_payment,
  ROUND(AVG(average_covered_charges_clean), 2) AS avg_covered_charge,
  COUNT(DISTINCT provider_id) AS provider_count
FROM hospital_charges
GROUP BY drg_definition
ORDER BY avg_total_payment DESC
LIMIT 10;

-- Regional Variation — Highest & Lowest Cost States for the Same DRG
SELECT 
  provider_state,
  ROUND(AVG(average_total_payments_clean), 2) AS avg_total_payment,
  COUNT(*) AS record_count
FROM hospital_charges
WHERE drg_definition LIKE '%heart failure%'
GROUP BY provider_state
ORDER BY avg_total_payment DESC
LIMIT 10;

-- Hospital Cost vs. Medicare Payment Gap
SELECT 
  provider_state,
  ROUND(AVG(average_covered_charges_clean), 2) AS avg_covered_charge,
  ROUND(AVG(average_medicare_payments_clean), 2) AS avg_medicare_payment,
  ROUND(AVG(average_covered_charges_clean) - AVG(average_medicare_payments_clean), 2) AS avg_gap,
  COUNT(DISTINCT provider_id) AS hospital_count
FROM hospital_charges
GROUP BY provider_state
ORDER BY avg_gap DESC;


-- Outlier Detection (High-Cost Hospitals)
SELECT 
  provider_name,
  provider_state,
  ROUND(AVG(average_total_payments_clean), 2) AS avg_payment
FROM hospital_charges
GROUP BY provider_name, provider_state
HAVING avg_payment > (
  SELECT AVG(average_total_payments_clean) * 2 
  FROM hospital_charges
)
ORDER BY avg_payment DESC
LIMIT 20;


-- Aggregated DRG Trends — Cost vs. Frequency
SELECT 
  drg_definition,
  COUNT(*) AS occurrence,
  ROUND(AVG(average_total_payments_clean), 2) AS avg_cost
FROM hospital_charges
GROUP BY drg_definition
HAVING occurrence > 50
ORDER BY avg_cost DESC;


-- Optional Visualization Prep (for Tableau or Databricks)
CREATE TABLE state_cost_summary AS
SELECT 
  provider_state,
  ROUND(AVG(average_total_payments_clean), 2) AS avg_payment,
  ROUND(AVG(average_medicare_payments_clean), 2) AS avg_medicare
FROM hospital_charges
GROUP BY provider_state;

DESCRIBE state_cost_summary;

SELECT *
FROM state_cost_summary;

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM hospital_charges
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hospital_charges_clean.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';



-- SELECT * FROM hospital_charges
-- INTO OUTFILE 'C:/path/hospital_charges_clean.csv'
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n';


