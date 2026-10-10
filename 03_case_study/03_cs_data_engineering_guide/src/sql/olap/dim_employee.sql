-- One row per employee; salesperson is a role flag.
CREATE OR REPLACE TABLE dim_employee AS
SELECT PersonID AS employee_key, FullName AS employee_name,
       PreferredName AS preferred_name, IsSalesperson AS is_salesperson
FROM application.people
WHERE TRY_CAST(IsEmployee AS BOOLEAN) = TRUE;
