# Guiding script for Module 3 - Fundamentals of Data Engineering Case Study
This directory consists of boilerplate codes for you to complete the take-home module 3 case study. You don't need to setup Docker and run compose services as we will use DuckDB as database. 

## Setup needed
1. Change your working directory to this folder. `cd 03_case_study/03_cs_data_engineering_guide`. We will run the scripts with `03_cs_data_engineering_guide` as our root folder.
2. Make sure that you have Python 3.11 or newer versions installed.
3. Create your virtual environment. `python -m venv env` or `python3 -m venv env` for Linux/Mac.
4. Activate virtual environment `env/Scripts/activate` or `source env/bin/activate` for Linux/Mac.
5. Install the dependencies. `pip install -r requirements.txt`
6. Run the following scripts in exact order to ingest data into `asb_oltp.duckdb`.
```
python src/00_download_csv.py
python src/01_ingest_csv.py
```

## What you need to accomplish. 
1. For data modeling case study, write your SQL scripts on the following files. Use this reference to build the dimension and fact tables. [WideWorldImportersDW database catalog
](https://learn.microsoft.com/en-us/sql/samples/wide-world-importers-dw-database-catalog?view=sql-server-ver17)
    - `/src/sql/olap/dim_city.sql`
    - `/src/sql/olap/dim_customer.sql`
    - `/src/sql/olap/dim_employee.sql`
    - `/src/sql/olap/dim_stock_item.sql`
    - `/src/sql/olap/fact_order.sql`
    - `/src/sql/olap/fact_sale.sql`
2. For orchestration case study, write your Python script on the following file. 
    - `/run_pipe.py`
3. When everything is done, you may run your script. `python run_pipe.py`

## Week 3 implementation and validation

The completed pipeline transforms Wide World Importers CSV data into an OLTP DuckDB database, then creates an OLAP model with four dimensions and two facts. Each fact table is at the individual order-line or invoice-line grain. The provided `dim_date.sql` also runs as part of OLAP ingestion.

### Running the pipeline

From this directory, install dependencies with `pip install -r requirements.txt`, then run:

```bash
python run_pipe.py
```

To reuse already-downloaded CSVs, run `python run_pipe.py --skip-download`. To reuse an existing `asb_oltp.duckdb` without re-ingesting data, run `python run_pipe.py --olap-only`. The latter requires the existing OLTP database in this directory. Both modes create or refresh `asb_olap.duckdb` using the SQL in `src/sql/olap/`.

### Colab validation (2026-10-10)

Executed `python run_pipe.py --olap-only` successfully using the existing OLTP database (29 imported tables). The following nonzero row counts were observed in `asb_olap.duckdb`:

| OLAP table | Row count |
| --- | ---: |
| dim_city | 37,940 |
| dim_customer | 663 |
| dim_employee | 19 |
| dim_stock_item | 227 |
| fact_order | 231,412 |
| fact_sale | 228,265 |

These counts establish successful creation and population, not complete referential-integrity or data-quality validation. The DuckDB databases and downloaded source data are runtime artifacts and are not required in version control to reproduce the pipeline.
