# EDA Findings

This document summarizes the key observations from `notebooks/01_EDA.ipynb`, which explores `public_cases.json`.

## Summary statistics

Using the loader script, the dataset of 1000 public cases was normalized into `public_cases.csv`. Basic statistics show mean and median values for trip duration, miles traveled and total receipts, along with the expected reimbursement.

## Key patterns

- **Five-day bonus:** Trips lasting exactly five days tend to reimburse slightly more than nearby durations.
- **Mileage tapering:** Reimbursement growth slows once mileage exceeds ~100 miles.
- **Receipts range:** Higher reimbursements cluster around total receipts of $600–$800, or about $100–$120 per day.

These patterns are consistent with the hints in `interviews-details.md` and can guide future modeling efforts.
