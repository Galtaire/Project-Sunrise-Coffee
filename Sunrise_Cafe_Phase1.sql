CREATE DATABASE `sunrise`;

### A. Table Creation 

DROP TABLE IF EXISTS `raw_date`;
CREATE TABLE `raw_date`(
	`date_id` INT NOT NULL, 
	`full_date` VARCHAR(255) NOT NULL,
	`year` INT NOT NULL,
	`month_number` INT NOT NULL, 
	`month_name` VARCHAR(255) NOT NULL,
	`quarter` INT NOT NULL, 
	`week_number` INT NOT NULL,
	`day_of_week` VARCHAR(255) NOT NULL,
	`is_weekend` VARCHAR(255) NOT NULL,
	`is_uk_bank_holiday` VARCHAR(255) NOT NULL,
	`uk_trading_calendar` VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS `raw_product`;
CREATE TABLE `raw_product`(
	`product_id` INT NOT NULL, 
	`product_name` VARCHAR(255) NOT NULL,
	`product_category` VARCHAR(255) NOT NULL,
	`unit_price_gbp` FLOAT NOT NULL, 
	`unit_cost_gbp` FLOAT NOT NULL,
	`gross_margin_pct` FLOAT NOT NULL,
	`is_loyalty_eligible` VARCHAR(255) NOT NULL,
	`product_status` VARCHAR(255) NOT NULL,
	`launch_date` VARCHAR(255)
); 

DROP TABLE IF EXISTS `raw_store`;
CREATE TABLE `raw_store` (
	`store_id` INT NOT NULL,
	`store_name` VARCHAR(255) NOT NULL,
	`store_format` VARCHAR(255) NOT NULL,
	`location_type` VARCHAR(255) NOT NULL,
	`city` VARCHAR(255) NOT NULL,
	`region` VARCHAR(255) NOT NULL,	
	`monthly_rent_gbp` FLOAT NOT NULL,
	`staff_headcount` INT NOT NULL,	
	`monthly_staffing_cost_gbp` FLOAT NOT NULL,
	`loyalty_adoption_rate` FLOAT NOT NULL, 
	`seating_capacity` INT NOT NULL,
	`opening_year` INT NOT NULL,	
	`store_status` VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS `raw_daily_sales`;
CREATE TABLE `raw_daily_sales` (
	`daily_sale_id` INT NOT NULL,
	`store_id` INT NOT NULL,
	`date_id` INT NOT NULL,
	`product_id` INT NOT NULL,	
	`total_revenue_gbp` FLOAT NOT NULL,
	`total_transactions` INT NOT NULL,
	`avg_transaction_value_gbp` FLOAT NOT NULL,
	`loyalty_transactions` INT NOT NULL,
	`loyalty_redemption_cost_gbp` FLOAT NOT NULL,
	`footfall` INT NOT NULL,
	`espresso_revenue_gbp` FLOAT NOT NULL,
	`filter_revenue_gbp` FLOAT NOT NULL,
	`food_revenue_gbp` FLOAT NOT NULL,
	`retail_beans_revenue_gbp` FLOAT NOT NULL,
	`daily_gross_profit_gbp` FLOAT NOT NULL,
	`staff_count` INT NOT NULL,
	`total_staff_hours` FLOAT NOT NULL,
	`shift_pattern` VARCHAR(255) NOT NULL,
	`avg_dwell_time_minutes` FLOAT NOT NULL
);

DROP TABLE IF EXISTS `raw_monthly_profitability`;
CREATE TABLE `raw_monthly_profitability` ( 
	`monthly_profit_id`	INT NOT NULL,
	`store_id`INT NOT NULL,
	`date_id`INT NOT NULL,	
	`month_id` VARCHAR(255) NOT NULL,
	`total_monthly_revenue_gbp` FLOAT NOT NULL,
	`total_monthly_cogs_gbp`FLOAT NOT NULL,
	`monthly_rent_gbp` FLOAT NOT NULL,
	`monthly_staffing_cost_gbp`	FLOAT NOT NULL,
	`loyalty_redemption_cost_gbp` FLOAT NOT NULL,
	`net_profit_gbp` FLOAT NOT NULL,
	`net_profit_margin_pct` FLOAT NOT NULL,
	`avg_daily_footfall` FLOAT NOT NULL,
	`loyalty_member_revenue_pct` FLOAT NOT NULL,
	`loyalty_member_spend_gbp` FLOAT NOT NULL,
	`non_member_spend_gbp` FLOAT NOT NULL,
	`revenue_per_sqft_gbp` FLOAT NOT NULL,
	`peak_hour_transactions` INT NOT NULL,
	`dead_hour_transactions` INT NOT NULL,
	`avg_dwell_time_minutes` FLOAT NOT NULL,
	`rent_band` VARCHAR(255) NOT NULL,
	`profitability_status` VARCHAR(255) NOT NULL
);


### B. Data Ingestion 

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sunrise/raw_date.csv'
INTO TABLE `raw_date`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (
	`date_id`,
	`full_date`,
	`year`,
	`month_number`,
	`month_name`,
	`quarter`,
	`week_number`,
	`day_of_week`,
	`is_weekend`,
	`is_uk_bank_holiday`,
	`uk_trading_calendar`
    );
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sunrise/raw_product.csv'
INTO TABLE `raw_product`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (
	`product_id`,
	`product_name`,
	`product_category`,
	`unit_price_gbp`,
	`unit_cost_gbp`,
	`gross_margin_pct`,
	`is_loyalty_eligible`,
	`product_status`,
	`launch_date`
    );

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sunrise/raw_store.csv'
INTO TABLE `raw_store`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (
	`store_id`,
	`store_name`,
	`store_format`,
	`location_type`,
	`city`,
	`region`,	
	`monthly_rent_gbp`,
	`staff_headcount`,
	`monthly_staffing_cost_gbp`,
	`loyalty_adoption_rate`,
	`seating_capacity`,
	`opening_year`,	
	`store_status`
    );

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sunrise/raw_daily_sales.csv'
INTO TABLE `raw_daily_sales`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (
	`daily_sale_id`,
	`store_id`,
	`date_id`,
	`product_id`,
	`total_revenue_gbp`,
	`total_transactions`,
	`avg_transaction_value_gbp`,
	`loyalty_transactions`,
	`loyalty_redemption_cost_gbp`,
	`footfall`,
	`espresso_revenue_gbp`,
	`filter_revenue_gbp`,
	`food_revenue_gbp`,
	`retail_beans_revenue_gbp`,
	`daily_gross_profit_gbp`,
	`staff_count`,
	`total_staff_hours`,
	`shift_pattern`,
	`avg_dwell_time_minutes`
    );

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sunrise/raw_monthly_profitability.csv'
INTO TABLE `raw_monthly_profitability`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (
	`monthly_profit_id`,
	`store_id`,
	`date_id`,
	`month_id`,
	`total_monthly_revenue_gbp`,
	`total_monthly_cogs_gbp`,
	`monthly_rent_gbp`,
	`monthly_staffing_cost_gbp`,
	`loyalty_redemption_cost_gbp`,
	`net_profit_gbp`,
	`net_profit_margin_pct`,
	`avg_daily_footfall`,
	`loyalty_member_revenue_pct`,
	`loyalty_member_spend_gbp`,
	`non_member_spend_gbp`,
	`revenue_per_sqft_gbp`,
	`peak_hour_transactions`,
	`dead_hour_transactions`,
	`avg_dwell_time_minutes`,
	`rent_band`,
	`profitability_status`
    );
    
SELECT * FROM raw_date;
SELECT * FROM raw_product;
SELECT * FROM raw_store;
SELECT * FROM raw_daily_sales;
SELECT * FROM raw_monthly_profitability;













	