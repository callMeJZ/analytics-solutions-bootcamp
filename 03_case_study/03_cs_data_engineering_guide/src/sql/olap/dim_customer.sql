-- One row per customer; include category and delivery city.
CREATE OR REPLACE TABLE dim_customer AS
SELECT c.CustomerID AS customer_key, c.CustomerName AS customer_name,
       c.BillToCustomerID AS bill_to_customer_id,
       cat.CustomerCategoryName AS customer_category,
       c.DeliveryCityID AS city_key,
       c.AccountOpenedDate AS account_opened_date,
       c.CreditLimit AS credit_limit,
       c.StandardDiscountPercentage AS standard_discount_percentage,
       c.IsOnCreditHold AS is_on_credit_hold
FROM sales.customers c
LEFT JOIN sales.customer_categories cat ON c.CustomerCategoryID = cat.CustomerCategoryID;
