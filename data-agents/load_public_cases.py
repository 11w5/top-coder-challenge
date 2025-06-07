#!/usr/bin/env python3
"""Minimal data pipeline for exploring public reimbursement cases."""

import json
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "public_cases.json"


def main() -> None:
    with open(DATA_PATH) as f:
        data = json.load(f)

    df = pd.json_normalize(data)
    df.columns = [c.replace("input.", "") for c in df.columns]

    print(f"Loaded {len(df)} records\n")
    print(df.head())
    print("\nSummary statistics:")
    print(df.describe())

    out_csv = Path(__file__).parent / "public_cases.csv"
    df.to_csv(out_csv, index=False)
    print(f"\nSaved CSV to {out_csv}")


if __name__ == "__main__":
    main()
