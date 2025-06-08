# Baseline Reimbursement Approach

This note documents the initial implementation of `run.sh` and the
observations gathered from running the provided evaluation script.

## Implementation highlights
- Base per diem: `$100` per travel day.
- Mileage reimbursement: `$0.50` per mile for the first `100` miles,
  then `$0.25` per additional mile.
- Receipt totals are currently ignored.
- The script accepts three parameters and prints only the numeric
  reimbursement value, meeting the requirements in `README.md`
  lines 60–65.

## Evaluation results
Running `./eval.sh` on the 1,000 public cases produced the following
summary:

```
Total test cases: 1000
Successful runs: 1000
Exact matches (±$0.01): 0 (0%)
Close matches (±$1.00): 2 (0.2%)
Average error: $521.54
Maximum error: $1303.32
```

The high average error indicates that the baseline captures only a
small portion of the legacy logic. The tips section of the evaluation
output points to high-error scenarios such as long trips with many miles
and high receipt totals. These cases will guide future iterations.

Further improvements should incorporate additional rules from the
interviews—such as bonuses for five-day trips, mileage tapering shapes,
and receipt rounding quirks—to better replicate the legacy system.
