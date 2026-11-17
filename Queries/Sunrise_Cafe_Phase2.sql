### Staging

DROP TABLE IF EXISTS `scc_date`;
CREATE TABLE `scc_date` AS 
SELECT * FROM `raw_date`;

DROP TABLE IF EXISTS `scc_product`;
CREATE TABLE `scc_product` AS 
SELECT * FROM `raw_product`;

DROP TABLE IF EXISTS `scc_store`;
CREATE TABLE `scc_store` AS 
SELECT * FROM `raw_store`;

DROP TABLE IF EXISTS `scc_sales`;
CREATE TABLE `scc_sales` AS 
SELECT * FROM `raw_daily_sales`;

DROP TABLE IF EXISTS `scc_profitability`;
CREATE TABLE `scc_profitability` AS 
SELECT * FROM `raw_monthly_profitability`;


### Data Standardization

SELECT * FROM `scc_date`;
UPDATE `scc_date`
SET	`date_id` = NULLIF(TRIM(`date_id`),''),
	`full_date` = NULLIF(TRIM(`full_date`),''),
	`year` = NULLIF(TRIM(`year`),''),
	`month_number` = NULLIF(TRIM(`month_number`),''),
	`month_name` = NULLIF(TRIM(`month_name`),''),
	`quarter` = NULLIF(TRIM(`quarter`),''),
	`week_number` = NULLIF(TRIM(`week_number`),''),
	`day_of_week` = NULLIF(TRIM(`day_of_week`),''),
	`is_weekend` = NULLIF(TRIM(`is_weekend`),''),
	`is_uk_bank_holiday` = NULLIF(TRIM(`is_uk_bank_holiday`),''),
	`uk_trading_calendar` = NULLIF(TRIM(`uk_trading_calendar`),'')
    ;

SELECT * FROM `scc_product`;
UPDATE `scc_product`
SET	`product_id` = NULLIF(TRIM(`product_id`),''),
	`product_name` = NULLIF(TRIM(`product_name`),''),
	`product_category` = NULLIF(TRIM(`product_category`),''),
	`unit_price_gbp` = NULLIF(TRIM(`unit_price_gbp`),''),
	`unit_cost_gbp` = NULLIF(TRIM(`unit_cost_gbp`),''),
	`gross_margin_pct`= NULLIF(TRIM(`gross_margin_pct`),''),
	`is_loyalty_eligible` = NULLIF(TRIM(`is_loyalty_eligible`),''),
	`product_status` = NULLIF(TRIM(`product_status`),''),
	`launch_date` = NULLIF(TRIM(`launch_date`),'')
    ;

SELECT * FROM `scc_store`;
UPDATE `scc_store`
SET	`store_id` = NULLIF(TRIM(`store_id`),''),
	`store_name` = NULLIF(TRIM(`store_name`),''),
	`store_format` = NULLIF(TRIM(`store_format`),''),
	`location_type` = NULLIF(TRIM(`location_type`),''),
	`city` = NULLIF(TRIM(`city`),''),
	`region` = NULLIF(TRIM(`region`),''),
	`monthly_rent_gbp` = NULLIF(TRIM(`monthly_rent_gbp`),''),
	`staff_headcount` = NULLIF(TRIM(`staff_headcount`),''),
	`monthly_staffing_cost_gbp` = NULLIF(TRIM(`monthly_staffing_cost_gbp`),''),
	`loyalty_adoption_rate` = NULLIF(TRIM(`loyalty_adoption_rate`),''),
	`seating_capacity` = NULLIF(TRIM(`seating_capacity`),''),
	`opening_year` = NULLIF(TRIM(`opening_year`),''),	
	`store_status` = NULLIF(TRIM(`store_status`),'')
    ;

SELECT * FROM `scc_sales`;
UPDATE `scc_sales`
SET	`daily_sale_id` = NULLIF(TRIM(`daily_sale_id`),''),
	`store_id` = NULLIF(TRIM(`store_id`),''),
	`date_id` = NULLIF(TRIM(`date_id`),''),
	`product_id` = NULLIF(TRIM(`product_id`),''),
	`total_revenue_gbp` = NULLIF(TRIM(`total_revenue_gbp`),''),
	`total_transactions` = NULLIF(TRIM(`total_transactions`),''),
	`avg_transaction_value_gbp` = NULLIF(TRIM(`avg_transaction_value_gbp`),''),
	`loyalty_transactions` = NULLIF(TRIM(`loyalty_transactions`),''),
	`loyalty_redemption_cost_gbp` = NULLIF(TRIM(`loyalty_redemption_cost_gbp`),''),
	`footfall` = NULLIF(TRIM(`footfall`),''),
	`espresso_revenue_gbp` = NULLIF(TRIM(`espresso_revenue_gbp`),''),
	`filter_revenue_gbp` = NULLIF(TRIM(`filter_revenue_gbp`),''),
	`food_revenue_gbp` = NULLIF(TRIM(`food_revenue_gbp`),''),
	`retail_beans_revenue_gbp` = NULLIF(TRIM(`retail_beans_revenue_gbp`),''),
	`daily_gross_profit_gbp` = NULLIF(TRIM(`daily_gross_profit_gbp`),''),
	`staff_count` = NULLIF(TRIM(`staff_count`),''),
	`total_staff_hours` = NULLIF(TRIM(`total_staff_hours`),''),
	`shift_pattern` = NULLIF(TRIM(`shift_pattern`),''),
	`avg_dwell_time_minutes` = NULLIF(TRIM(`avg_dwell_time_minutes`),'')
    ;
    
SELECT * FROM `scc_profitability`;
UPDATE `scc_profitability`
SET	`monthly_profit_id` = NULLIF(TRIM(`monthly_profit_id`),''),
	`store_id` = NULLIF(TRIM(`store_id`),''),
	`date_id` = NULLIF(TRIM(`date_id`),''),
	`month_id` = NULLIF(TRIM(`month_id`),''),
	`total_monthly_revenue_gbp` = NULLIF(TRIM(`total_monthly_revenue_gbp`),''),
	`total_monthly_cogs_gbp` = NULLIF(TRIM(`total_monthly_cogs_gbp`),''),
	`monthly_rent_gbp` = NULLIF(TRIM(`monthly_rent_gbp`),''),
	`monthly_staffing_cost_gbp` = NULLIF(TRIM(`monthly_staffing_cost_gbp`),''),
	`loyalty_redemption_cost_gbp` = NULLIF(TRIM(`loyalty_redemption_cost_gbp`),''),
	`net_profit_gbp` = NULLIF(TRIM(`net_profit_gbp`),''),
	`net_profit_margin_pct` = NULLIF(TRIM(`net_profit_margin_pct`),''),
	`avg_daily_footfall` = NULLIF(TRIM(`avg_daily_footfall`),''),
	`loyalty_member_revenue_pct` = NULLIF(TRIM(`loyalty_member_revenue_pct`),''),
	`loyalty_member_spend_gbp` = NULLIF(TRIM(`loyalty_member_spend_gbp`),''),
	`non_member_spend_gbp` = NULLIF(TRIM(`non_member_spend_gbp`),''),
	`revenue_per_sqft_gbp` = NULLIF(TRIM(`revenue_per_sqft_gbp`),''),
	`peak_hour_transactions` = NULLIF(TRIM(`peak_hour_transactions`),''),
	`dead_hour_transactions` = NULLIF(TRIM(`dead_hour_transactions`),''),
	`avg_dwell_time_minutes` = NULLIF(TRIM(`avg_dwell_time_minutes`),''),
	`rent_band` = NULLIF(TRIM(`rent_band`),''),
	`profitability_status` = NULLIF(TRIM(`profitability_status`),'')
    ;

SELECT * FROM scc_date;
SELECT * FROM scc_store;
SELECT * FROM scc_product;
SELECT * FROM scc_sales;
SELECT * FROM scc_profitability;

ALTER TABLE scc_date
MODIFY COLUMN full_date DATE;

ALTER TABLE scc_product
DROP COLUMN launch_date;

### Primary Keys 

ALTER TABLE scc_date
	MODIFY COLUMN `date_id` INT AUTO_INCREMENT,
	ADD PRIMARY KEY (`date_id`);

ALTER TABLE scc_store
	MODIFY COLUMN `store_id` INT AUTO_INCREMENT,
	ADD PRIMARY KEY (`store_id`);

ALTER TABLE scc_product
	MODIFY COLUMN `product_id` INT AUTO_INCREMENT,
	ADD PRIMARY KEY (`product_id`);

ALTER TABLE scc_sales
	MODIFY COLUMN `daily_sale_id` INT AUTO_INCREMENT,
	ADD PRIMARY KEY (`daily_sale_id`);

ALTER TABLE scc_profitability
	MODIFY COLUMN `monthly_profit_id` INT AUTO_INCREMENT,
	ADD PRIMARY KEY (`monthly_profit_id`);

### Foreign Keys 

ALTER TABLE scc_sales
	ADD CONSTRAINT fk_store_id
	FOREIGN KEY (`store_id`)
	REFERENCES scc_store(`store_id`);

ALTER TABLE scc_sales
	ADD CONSTRAINT fk_date_id
	FOREIGN KEY (`date_id`)
	REFERENCES scc_date(`date_id`);
    
ALTER TABLE scc_sales
	ADD CONSTRAINT fk_product_id
	FOREIGN KEY (`product_id`)
	REFERENCES scc_product(`product_id`);
    
ALTER TABLE scc_profitability
	ADD CONSTRAINT fk_store_id_p
	FOREIGN KEY (`store_id`)
	REFERENCES scc_store(`store_id`);  

ALTER TABLE scc_profitability
	ADD CONSTRAINT fk_date_id_p
	FOREIGN KEY (`date_id`)
	REFERENCES scc_date(`date_id`);












