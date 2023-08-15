-- the csv files were imported through MySQL Workbench's Table Data Import Wizard --

SELECT * 
FROM avg_palay_price;

SELECT * 
FROM rice_supply;

ALTER TABLE rice_supply
MODIFY COLUMN year INT PRIMARY KEY; 

ALTER TABLE avg_palay_price
ADD FOREIGN KEY (year) REFERENCES rice_supply(year);

-- to show both tables represented by their years -- 
SELECT * FROM rice_supply
JOIN avg_palay_price
ON avg_palay_price.year = rice_supply.year;

-- Question 1 & 2 --

SELECT year,farmgate 
FROM avg_palay_price
ORDER BY farmgate DESC;

SELECT year,wholesale 
FROM avg_palay_price
ORDER BY wholesale DESC;

SELECT year,retail 
FROM avg_palay_price
ORDER BY retail DESC;

SELECT *
FROM avg_palay_price;

-- to remove all NULLs in avg_palay_price, code is:

SELECT year,
IFNULL(farmgate,0) AS farmgate,
IFNULL(wholesale,0) AS wholesale,
IFNULL(retail,0) AS retail
FROM avg_palay_price;

-- or to show only the prices from 2019 and above --

SELECT year,
IFNULL(farmgate,0) AS farmgate,
IFNULL(wholesale,0) AS wholesale,
IFNULL(retail,0) AS retail
FROM avg_palay_price
WHERE year >= 2019;

-- Question 3 --

SELECT year, su_import 
FROM rice_supply;

SELECT year, su_import 
FROM rice_supply
ORDER BY su_import DESC;

-- Question 4 ==

SELECT year,su_production
FROM rice_supply;

SELECT year,su_production
FROM rice_supply
ORDER BY su_production DESC;

SELECT year, su_production, su_import 
FROM rice_supply;

-- Question 5 --

SELECT 
rice_supply.year, su_gross_supply, 
farmgate, wholesale, retail
FROM rice_supply
RIGHT JOIN
avg_palay_price
ON avg_palay_price.year = rice_supply.year
WHERE rice_supply.year < 2021;

SELECT
year, CONCAT(farmgate + wholesale + retail / 3) as price
FROM avg_palay_price;

-- Question 6 --

SELECT year,
(su_production / (su_production + su_import)) AS 'Self-Sufficiency Ratio',
CONCAT(ROUND(su_production / (su_production + su_import) * 100,2), '%') AS 'in percentage',
IF ('Self-Sufficiency Ratio' = 1,
'Sufficient',
'Not sufficient') AS 'status'
FROM rice_supply;

