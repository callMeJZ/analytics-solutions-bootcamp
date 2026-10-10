-- Grain: one invoice line. Join invoice header for customer, salesperson and date.
CREATE OR REPLACE TABLE fact_sale AS
SELECT il.InvoiceLineID AS invoice_line_key, i.InvoiceID AS invoice_id,
       i.OrderID AS order_id, i.CustomerID AS customer_key,
       i.SalespersonPersonID AS employee_key,
       il.StockItemID AS stock_item_key,
       CAST(STRFTIME(TRY_CAST(i.InvoiceDate AS DATE), '%Y%m%d') AS INTEGER) AS invoice_date_key,
       TRY_CAST(i.InvoiceDate AS DATE) AS invoice_date,
       il.Quantity AS quantity, il.UnitPrice AS unit_price,
       il.TaxRate AS tax_rate, il.TaxAmount AS tax_amount,
       il.LineProfit AS line_profit, il.ExtendedPrice AS extended_price
FROM sales.invoice_lines il
JOIN sales.invoices i ON il.InvoiceID = i.InvoiceID;
