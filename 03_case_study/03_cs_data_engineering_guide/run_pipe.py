"""Run the Week 3 CSV -> OLTP -> OLAP pipeline from this directory.

Usage:
    python run_pipe.py
    python run_pipe.py --skip-download  # reuse downloaded CSVs
    python run_pipe.py --olap-only      # reuse existing OLTP DuckDB database
"""
from pathlib import Path
import argparse
import subprocess
import sys

ROOT = Path(__file__).resolve().parent


def run(script: str) -> None:
    print(f"\nRunning {script}...", flush=True)
    subprocess.run([sys.executable, str(ROOT / "src" / script)], cwd=ROOT, check=True)


def main() -> None:
    parser = argparse.ArgumentParser(description="Wide World Importers data pipeline")
    parser.add_argument("--skip-download", action="store_true", help="Reuse CSVs in data/")
    parser.add_argument("--olap-only", action="store_true", help="Reuse existing OLTP database")
    args = parser.parse_args()

    if not args.olap_only:
        if not args.skip_download:
            run("00_download_csv.py")
        if not (ROOT / "data" / "Application.Cities.csv").is_file():
            parser.error("CSV dataset missing. Download it before ingestion.")
        run("01_ingest_csv.py")
    elif not (ROOT / "asb_oltp.duckdb").is_file():
        parser.error("asb_oltp.duckdb is missing; run OLTP ingestion first.")

    run("02_ingest_olap.py")
    print("\nPipeline completed successfully.", flush=True)


if __name__ == "__main__":
    main()
