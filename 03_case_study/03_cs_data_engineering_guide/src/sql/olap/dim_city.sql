-- One row per city; enrich with state/province and country.
CREATE OR REPLACE TABLE dim_city AS
SELECT c.CityID AS city_key, c.CityName AS city_name,
       s.StateProvinceID AS state_province_id,
       s.StateProvinceName AS state_province_name,
       s.SalesTerritory AS sales_territory,
       co.CountryName AS country_name,
       c.Latitude AS latitude, c.Longitude AS longitude,
       c.LatestRecordedPopulation AS latest_recorded_population
FROM application.cities c
LEFT JOIN application.state_provinces s ON c.StateProvinceID = s.StateProvinceID
LEFT JOIN application.countries co ON s.CountryID = co.CountryID;
