######## 1 — Store Format and Regional Performance

# 1. Which store format delivers the highest average net_profit_margin_pct?

SELECT 	store_format AS `Format`,
			ROUND(SUM(total_monthly_revenue_gbp), 2) AS `Total_Revenue`,
				ROUND(SUM(total_monthly_expenses), 2) AS `Total_Expenses`,
					ROUND(SUM(net_profit_gbp), 2) AS `Total_Net_Profit`,
						ROUND(AVG(revenue_per_sqft_gbp), 2) AS `Avg_Revenue_Per_Sqft`,
							ROUND(AVG(net_profit_margin_pct), 2) AS `Avg_Net_Profit_Margin`,
								ROUND(AVG(avg_daily_footfall), 2) AS `Avg_Footfall`
FROM (	SELECT 	st.store_format,
				pr.total_monthly_revenue_gbp,
                pr.net_profit_margin_pct,
				ROUND((pr.total_monthly_cogs_gbp + 
							pr.monthly_rent_gbp + 
								pr.monthly_staffing_cost_gbp + 
									pr.loyalty_redemption_cost_gbp), 2) AS `total_monthly_expenses`,
				pr.revenue_per_sqft_gbp,
				pr.net_profit_gbp,
				pr.avg_daily_footfall
		FROM scc_store AS st
		JOIN scc_profitability AS pr
			ON st.store_id = pr.store_id
	) AS `subquery`
GROUP BY store_format;


# 2.1 Profitability Status Count per Region 

SELECT 
    st.region AS `Region`,
    SUM(CASE WHEN pr.profitability_status = 'Highly-Profitable' THEN 1 ELSE 0 END) AS 'Highly-Profitable',
	SUM(CASE WHEN pr.profitability_status = 'Profitable' THEN 1 ELSE 0 END) AS 'Profitable',
	SUM(CASE WHEN pr.profitability_status = 'Break-Even' THEN 1 ELSE 0 END) AS 'Break-Even', 
	SUM(CASE WHEN pr.profitability_status = 'Loss-Making' THEN 1 ELSE 0 END) AS 'Loss-Making',
	SUM(CASE WHEN pr.profitability_status = 'Structural-Loss' THEN 1 ELSE 0 END) AS 'Structural-Loss'
FROM scc_store AS st
JOIN scc_profitability AS pr 
    ON st.store_id = pr.store_id
GROUP BY st.region;


# 2.2 Which UK regions show the highest concentration of Loss-Making or Structural-Loss in profitability status? 

SELECT 
    st.region AS `Region`,
	SUM(CASE WHEN pr.profitability_status = 'Loss-Making' THEN 1 ELSE 0 END) AS 'Loss-Making',
	SUM(CASE WHEN pr.profitability_status = 'Structural-Loss' THEN 1 ELSE 0 END) AS 'Structural-Loss'
FROM scc_store AS st
JOIN scc_profitability AS pr 
    ON st.store_id = pr.store_id
GROUP BY st.region;


# 3. Do stores with higher monthly_rent_gbp necessarily generate higher total_monthly_revenue_gbp, or does rent erode profit disproportionately in some formats?

SELECT	st.store_name,
		st.store_format,
		ROUND(AVG(st.monthly_rent_gbp), 2) AS 'Monthly_rent_gbp',
        ROUND(AVG(pr.total_monthly_revenue_gbp), 2) AS 'Total_monthly_revenue_gbp',
        ROUND(AVG(pr.total_monthly_revenue_gbp) - AVG(st.monthly_rent_gbp), 2) AS 'Rent-Revenue_gbp'
FROM scc_store AS st
JOIN scc_profitability AS pr 
	ON st.store_id = pr.store_id
GROUP BY st.store_name, st.store_format;


# 4. Which individual stores improved their net_profit_gbp most from 2023 to 2024, and which have deteriorated?

### (2023 VS 2024 - Year)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN dt.year = '2023' THEN pr.net_profit_gbp END), 2) AS "2023",
        ROUND(SUM(CASE WHEN dt.year = '2024' THEN pr.net_profit_gbp END), 2) AS "2024"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

### (Quarterly - 2023 Only)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN `quarter` = '1' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q1_2023",
        ROUND(SUM(CASE WHEN `quarter` = '2' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q2_2023",
        ROUND(SUM(CASE WHEN `quarter` = '3' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q3_2023",
        ROUND(SUM(CASE WHEN `quarter` = '4' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q4_2023"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

### (Quarterly - 2024 Only)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN `quarter` = '1' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q1_2024",
        ROUND(SUM(CASE WHEN `quarter` = '2' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q2_2024",
        ROUND(SUM(CASE WHEN `quarter` = '3' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q3_2024",
        ROUND(SUM(CASE WHEN `quarter` = '4' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q4_2024"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

### (Quarterly - 2023 - 2024 Only)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN `quarter` = '1' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q1_2023",
        ROUND(SUM(CASE WHEN `quarter` = '2' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q2_2023",
        ROUND(SUM(CASE WHEN `quarter` = '3' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q3_2023",
        ROUND(SUM(CASE WHEN `quarter` = '4' AND `year` = '2023' THEN pr.net_profit_gbp END), 2) AS "Q4_2023",
        ROUND(SUM(CASE WHEN `quarter` = '1' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q1_2024",
        ROUND(SUM(CASE WHEN `quarter` = '2' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q2_2024",
        ROUND(SUM(CASE WHEN `quarter` = '3' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q3_2024",
        ROUND(SUM(CASE WHEN `quarter` = '4' AND `year` = '2024' THEN pr.net_profit_gbp END), 2) AS "Q4_2024"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

### (Monthly - 2023 Only)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 1 THEN pr.net_profit_gbp END), 2) AS "Jan_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 2 THEN pr.net_profit_gbp END), 2) AS "Feb_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 3 THEN pr.net_profit_gbp END), 2) AS "Mar_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 4 THEN pr.net_profit_gbp END), 2) AS "Apr_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 5 THEN pr.net_profit_gbp END), 2) AS "May_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 6 THEN pr.net_profit_gbp END), 2) AS "Jun_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 7 THEN pr.net_profit_gbp END), 2) AS "Jul_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 8 THEN pr.net_profit_gbp END), 2) AS "Aug_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 9 THEN pr.net_profit_gbp END), 2) AS "Sep_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 10 THEN pr.net_profit_gbp END), 2) AS "Oct_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 11 THEN pr.net_profit_gbp END), 2) AS "Nov_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 12 THEN pr.net_profit_gbp END), 2) AS "Dec_2023"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

### (Monthly - 2024 Only)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 1 THEN pr.net_profit_gbp END), 2) AS "Jan_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 2 THEN pr.net_profit_gbp END), 2) AS "Feb_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 3 THEN pr.net_profit_gbp END), 2) AS "Mar_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 4 THEN pr.net_profit_gbp END), 2) AS "Apr_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 5 THEN pr.net_profit_gbp END), 2) AS "May_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 6 THEN pr.net_profit_gbp END), 2) AS "Jun_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 7 THEN pr.net_profit_gbp END), 2) AS "Jul_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 8 THEN pr.net_profit_gbp END), 2) AS "Aug_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 9 THEN pr.net_profit_gbp END), 2) AS "Sep_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 10 THEN pr.net_profit_gbp END), 2) AS "Oct_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 11 THEN pr.net_profit_gbp END), 2) AS "Nov_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 12 THEN pr.net_profit_gbp END), 2) AS "Dec_2024"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

### (Monthly - 2023-2024 Combined)
SELECT 	st.store_name,
		ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 1 THEN pr.net_profit_gbp END), 2) AS "Jan_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 2 THEN pr.net_profit_gbp END), 2) AS "Feb_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 3 THEN pr.net_profit_gbp END), 2) AS "Mar_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 4 THEN pr.net_profit_gbp END), 2) AS "Apr_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 5 THEN pr.net_profit_gbp END), 2) AS "May_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 6 THEN pr.net_profit_gbp END), 2) AS "Jun_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 7 THEN pr.net_profit_gbp END), 2) AS "Jul_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 8 THEN pr.net_profit_gbp END), 2) AS "Aug_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 9 THEN pr.net_profit_gbp END), 2) AS "Sep_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 10 THEN pr.net_profit_gbp END), 2) AS "Oct_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 11 THEN pr.net_profit_gbp END), 2) AS "Nov_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2023' AND MONTH(dt.full_date) = 12 THEN pr.net_profit_gbp END), 2) AS "Dec_2023",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 1 THEN pr.net_profit_gbp END), 2) AS "Jan_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 2 THEN pr.net_profit_gbp END), 2) AS "Feb_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 3 THEN pr.net_profit_gbp END), 2) AS "Mar_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 4 THEN pr.net_profit_gbp END), 2) AS "Apr_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 5 THEN pr.net_profit_gbp END), 2) AS "May_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 6 THEN pr.net_profit_gbp END), 2) AS "Jun_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 7 THEN pr.net_profit_gbp END), 2) AS "Jul_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 8 THEN pr.net_profit_gbp END), 2) AS "Aug_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 9 THEN pr.net_profit_gbp END), 2) AS "Sep_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 10 THEN pr.net_profit_gbp END), 2) AS "Oct_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 11 THEN pr.net_profit_gbp END), 2) AS "Nov_2024",
        ROUND(SUM(CASE WHEN YEAR(dt.full_date) = '2024' AND MONTH(dt.full_date) = 12 THEN pr.net_profit_gbp END), 2) AS "Dec_2024"
FROM scc_profitability AS pr
JOIN scc_date AS dt
	ON	pr.date_id = dt.date_id
JOIN scc_store AS st
	ON st.store_id = pr.store_id
GROUP BY st.store_name;

############################################################################################################################################################################################################################

######## 2 — Loyalty Programme Effectiveness

# 1. Correlation between loyalty_adoption_rate and loyalty_member_revenue_pct

### loyalty_adoption_rate vs. loyalty_member_revenue_pct (Whole) 
SELECT	st.store_name,
		st.region,
        ROUND(st.loyalty_adoption_rate, 2) AS "Loyalty_Adoption_Rate",
        ROUND(AVG(pr.loyalty_member_revenue_pct), 2) AS "Loyalty_Member_Revenue"
FROM scc_store AS st
JOIN scc_profitability AS pr 
	ON st.store_id = pr.store_id
GROUP BY st.store_id
ORDER BY Loyalty_Member_Revenue ASC;

### loyalty_adoption_rate vs. loyalty_member_revenue_pct (High Loyalty_Member_Revenue Only)
WITH lar_vs_lmr AS ( 
		SELECT	st.store_name,
				st.region,
				ROUND(st.loyalty_adoption_rate, 2) AS "Loyalty_Adoption_Rate",
				ROUND(AVG(pr.loyalty_member_revenue_pct), 2) AS "Loyalty_Member_Revenue"
		FROM scc_store AS st
		JOIN scc_profitability AS pr 
			ON st.store_id = pr.store_id
		GROUP BY st.store_id
		ORDER BY Loyalty_Member_Revenue ASC)
	SELECT * 
    FROM lar_vs_lmr
    WHERE Loyalty_Adoption_Rate < Loyalty_Member_Revenue
    ORDER BY Loyalty_Member_Revenue DESC;

### loyalty_adoption_rate vs. loyalty_member_revenue_pct (High Loyalty_Adoption_Rate Only)
WITH lar_vs_lmr AS ( 
		SELECT	st.store_name,
				st.region,
				ROUND(st.loyalty_adoption_rate, 2) AS "Loyalty_Adoption_Rate",
				ROUND(AVG(pr.loyalty_member_revenue_pct), 2) AS "Loyalty_Member_Revenue"
		FROM scc_store AS st
		JOIN scc_profitability AS pr 
			ON st.store_id = pr.store_id
		GROUP BY st.store_id
		ORDER BY Loyalty_Member_Revenue ASC)
	SELECT * 
    FROM lar_vs_lmr
    WHERE Loyalty_Adoption_Rate > Loyalty_Member_Revenue
    ORDER BY Loyalty_Adoption_Rate DESC;


# 2. Loyalty Member Spending and Non-Member Spending per Transaction based on Avg_Transaction_Value_gbp 

WITH avg_transaction_v AS (
	SELECT 	store_id,
			date_id,
			ROUND(AVG(avg_transaction_value_gbp), 2) AS `avg_daily_transaction_value`,
			SUM(total_transactions) AS `Total_Transactions`,
			SUM(loyalty_transactions) AS `Loyalty_Transactions`
	FROM scc_sales
	GROUP BY store_id, date_id
) 
SELECT 	st.store_id,
		st.store_name,
			ROUND(AVG(pr.non_member_spend_gbp), 2) AS `Non-Member_Spending`,
				ROUND(AVG(tv.Total_Transactions) - AVG(tv.Loyalty_Transactions), 0) AS `Non-Member_Transactions`,
					ROUND(AVG(pr.loyalty_member_spend_gbp), 2) AS `Loyalty_Member_Spending`,
						ROUND(AVG(tv.loyalty_transactions), 0) AS `Loyalty_Member_Transactions`,
							ROUND(AVG(pr.non_member_spend_gbp) - AVG(pr.loyalty_member_spend_gbp), 2) AS `Spending_Difference`,
								ROUND(AVG(tv.avg_daily_transaction_value), 2) AS `Avg_Transaction_Value`
FROM avg_transaction_v AS `tv`
	JOIN scc_store AS `st` 
	ON st.store_id = tv.store_id
		JOIN scc_date AS `dt`
		ON dt.date_id = tv.date_id
			JOIN scc_profitability AS `pr`
				ON pr.store_id = tv.store_id 
				AND pr.date_id = tv.date_id
GROUP BY st.store_id, st.store_name;


# 3. Net value of the Loyalty Programme per Store: loyalty_member_contribution minus loyalty_redemption_cost_gbp

SELECT	pr.store_id,
		st.store_name,
		ROUND(SUM(pr.loyalty_member_spend_gbp) - SUM(pr.loyalty_redemption_cost_gbp), 2) AS `Loyalty_Programme_Net_Value`
FROM scc_store AS st
JOIN scc_profitability AS pr
	ON st.store_id = pr.store_id
GROUP BY pr.store_id, st.store_name;


############################################################################################################################################################################################################################

######## 3 - Revenue Mix

# 1. Average Daily Revenue of Products per Store 

SELECT 	st.store_name AS `Store_Name`,
			st.store_format AS `Format`,
				st.location_type AS `Location_Type`,
					st.region AS `Region`,
		ROUND(AVG(sl.espresso_revenue_gbp), 2) AS `Espresso`, 
			ROUND(AVG(sl.filter_revenue_gbp), 2) AS `Filter`, 
				ROUND(AVG(sl.food_revenue_gbp), 2) AS `Food`, 
					ROUND(AVG(sl.retail_beans_revenue_gbp), 2) AS `Retail_Beans`, 
						ROUND(AVG(sl.daily_gross_profit_gbp), 2) AS `Daily_Gross_Profit`
FROM scc_sales AS sl
JOIN scc_store AS st
	ON sl.store_id = st.store_id
GROUP BY st.store_name, st.store_format, st.location_type, st.region;


# 2. Gross_margin_pct growth per product category

WITH category_margins AS (
    SELECT 
        product_category,
        ROUND(AVG(gross_margin_pct), 2) AS `avg_gross_margin_pct`
    FROM scc_product
    GROUP BY product_category
),
monthly_category_revenue AS (
    SELECT 
        dt.year,
        dt.month_number,
        pd.product_category,
        SUM(sl.total_revenue_gbp) AS `category_revenue`
    FROM scc_sales AS sl
    JOIN scc_product AS pd 
        ON sl.product_id = pd.product_id
    JOIN scc_date AS dt 
        ON sl.date_id = dt.date_id
    GROUP BY dt.year, dt.month_number, pd.product_category
),
monthly_total_revenue AS (
    SELECT 
        year,
        month_number,
        SUM(category_revenue) AS `total_monthly_revenue`
    FROM monthly_category_revenue
    GROUP BY year, month_number
)
SELECT 
    mcr.year,
    mcr.month_number,
    mcr.product_category,
    cm.avg_gross_margin_pct,
    mcr.category_revenue,
    ROUND(
        (mcr.category_revenue / mtr.total_monthly_revenue) * 100, 
        2
    ) AS `revenue_share_pct`
FROM monthly_category_revenue AS mcr
JOIN category_margins AS cm 
    ON mcr.product_category = cm.product_category
JOIN monthly_total_revenue AS mtr 
    ON mcr.year = mtr.year 
    AND mcr.month_number = mtr.month_number
ORDER BY cm.avg_gross_margin_pct DESC, mcr.year, mcr.month_number;

############################################################################################################################################################################################################################



