# EDA Findings

This document summarizes observations from `notebooks/01_EDA.ipynb`, which explores `public_cases.json`.

## Summary statistics

The loader script normalizes the dataset into `public_cases.csv`. Basic statistics provide averages and spreads for trip duration, miles traveled, total receipts, and the expected reimbursement.

Using the loader script, the dataset of 1000 public cases was normalized into `public_cases.csv`. Basic statistics show mean and median values for trip duration, miles traveled and total receipts, along with the expected reimbursement.


## Key patterns

- **Five-day bonus:** Trips lasting exactly five days tend to reimburse slightly more than nearby durations.
- **Mileage tapering:** Reimbursement growth slows once mileage exceeds ~100 miles.
- **Receipts range:** Higher reimbursements cluster around total receipts of $600–$800 (about $100–$120 per day).
- **Duration effect:** Mean reimbursement by trip duration shows a moderate upward trend with some bumps.

These patterns match the interview hints. `FORECAST_DOC_VALIDATION.md` explains why we treat the data as a deterministic rule set rather than a forecasting problem.

## Additional boundaries

- **Low receipts penalty:** Totals below $50 often receive less than the base per diem.
- **High receipts plateau:** Totals above ~$2,000 yield little extra reimbursement.
- **Long trip taper:** Daily reimbursement drops sharply after day 8.
- **Mileage plateau:** Per-mile rates level off once mileage exceeds about 1,000 miles.
- **Receipt rounding quirk:** Amounts ending in `.49` or `.99` occur in about 30 cases and show different averages.

These additional boundaries help narrow down the legacy formula and guide future modeling efforts.

## Forecastability measures

Following `FORECAST_DOC_VALIDATION.md`, we summarized the definitions of Coefficient of Variation and SVD Entropy from the forecasting docs and computed them on the main input columns using `public_cases.csv`.

| Column | CV | SVD Entropy |
| --- | --- | --- |
| `trip_duration_days` | 0.557 | 1.983 |
| `miles_traveled` | 0.588 | 2.003 |
| `total_receipts_amount` | 0.613 | 2.019 |

These moderate CV and entropy values indicate the series contain structure without being perfectly predictable. They provide quantitative support for the five‑day bonus and mileage tapering patterns found in the EDA.