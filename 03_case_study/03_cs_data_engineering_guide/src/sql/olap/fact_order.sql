-- Grain: one order line. Retain natural IDs for traceability.
CREATE OR REPLACE TABLE fact_order AS
SELECT ol.OrderLineID AS order_line_key, o.OrderID AS order_id,
       o.CustomerID AS customer_key, o.SalespersonPersonID AS employee_key,
       ol.StockItemID AS stock_item_key,
       CAST(STRFTIME(TRY_CAST(o.OrderDate AS DATE), '%Y%m%d') AS INTEGER) AS order_date_key,
       TRY_CAST(o.OrderDate AS DATE) AS order_date,
       ol.Quantity AS quantity, ol.UnitPrice AS unit_price,
       ol.TaxRate AS tax_rate,
       ol.Quantity * ol.UnitPrice AS amount_excluding_tax,
       ol.Quantity * ol.UnitPrice * (1 + ol.TaxRate / 100.0) AS amount_including_tax
FROM sales.order_lines ol
JOIN sales.orders o ON ol.OrderID = o.OrderID;
