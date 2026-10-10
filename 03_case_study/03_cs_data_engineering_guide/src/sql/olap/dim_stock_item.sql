-- One row per stock item.
CREATE OR REPLACE TABLE dim_stock_item AS
SELECT si.StockItemID AS stock_item_key, si.StockItemName AS stock_item_name,
       si.SupplierID AS supplier_id, si.Brand AS brand, si.Size AS size,
       si.UnitPrice AS unit_price, si.RecommendedRetailPrice AS recommended_retail_price,
       si.TaxRate AS tax_rate, si.IsChillerStock AS is_chiller_stock,
       si.LeadTimeDays AS lead_time_days
FROM warehouse.stock_items si;
