CREATE TABLE dim_household (
    household_key INT PRIMARY KEY,
    age_desc VARCHAR(10),
    marital_status_code VARCHAR(2),
    income_desc VARCHAR(10),
    homeowner_desc VARCHAR(15),
    hh_comp_desc VARCHAR(20),
    household_size_desc VARCHAR(15),
    kid_category_desc VARCHAR(20)
);

CREATE TABLE dim_campaign (
    campaign_key INT PRIMARY KEY,
    campaign_desc VARCHAR(10),
    start_day INT,
    end_day INT
);




CREATE TABLE dim_product (
    product_key INT PRIMARY KEY,
    commodity_desc VARCHAR(30),
    sub_commodity_desc VARCHAR(30),
    manufacturer_key INT,
    department VARCHAR(20),
    brand VARCHAR(20),
    curr_size_of_product VARCHAR(20),
    FOREIGN KEY (manufacturer_key) REFERENCES dim_manufacturer(manufacturer_key)
);

CREATE TABLE dim_store (
    store_key INT PRIMARY KEY,
    store_name VARCHAR(30),
    store_city VARCHAR(30),
    store_state VARCHAR(2),
    store_region VARCHAR(20)
);



CREATE TABLE dim_coupon (
    coupon_key BIGINT PRIMARY KEY,
    campaign_key INT,
    product_key INT,
    FOREIGN KEY (campaign_key) REFERENCES dim_campaign(campaign_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

CREATE TABLE fact_transaction (
    transaction_key BIGINT PRIMARY KEY,
    household_key INT,
    basket_id BIGINT,
    product_key INT,
    quantity INT,
    sales_value NUMERIC(10,2),
    store_key INT,
    coupon_match_disc NUMERIC(10,2),
    coupon_disc NUMERIC(10,2),
    retail_disc NUMERIC(10,2),
    trans_time INT,
    time_key INT,
    FOREIGN KEY (household_key) REFERENCES dim_household(household_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (time_key) REFERENCES dim_time(time_key)
);

CREATE TABLE fact_coupon_redemption (
    household_key INT,
    day INT,
    coupon_key BIGINT,
    transaction_key BIGINT,
    FOREIGN KEY (household_key) REFERENCES dim_household(household_key),
    FOREIGN KEY (coupon_key) REFERENCES dim_coupon(coupon_key),
    FOREIGN KEY (transaction_key) REFERENCES fact_transaction(transaction_key)
);

CREATE TABLE dim_promotion (
    promotion_key INT PRIMARY KEY,
    promotion_name VARCHAR(30),
    promotion_type VARCHAR(30)
);

CREATE TABLE dim_promotion_time (
    promotion_key INT,
    time_key INT,
    FOREIGN KEY (promotion_key) REFERENCES dim_promotion(promotion_key),
    FOREIGN KEY (time_key) REFERENCES dim_time(time_key)
);

CREATE TABLE dim_promotion_store (
    promotion_key INT,
    store_key INT,
    FOREIGN KEY (promotion_key) REFERENCES dim_promotion(promotion_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key)
);

CREATE TABLE dim_promotion_product (
    promotion_key INT,
    product_key INT,
    FOREIGN KEY (promotion_key) REFERENCES dim_promotion(promotion_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

CREATE TABLE fact_spending_trend (
    household_key INT,
    time_key INT,
    spending_amt NUMERIC(10,2),
    trend_type VARCHAR(10),
    product_key INT,
    FOREIGN KEY (household_key) REFERENCES dim_household(household_key),
    FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);
