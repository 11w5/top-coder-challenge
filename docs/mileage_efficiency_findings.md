# Mileage Efficiency Findings

This note summarizes recent experimentation with the reimbursement logic.

## Five-Day Bonus
- Interviews indicate trips lasting exactly five days receive an extra reward.
- Implemented as a fixed $75 addition when `trip_duration_days == 5`.

## Mileage Efficiency Bonus
- Efficiency peaks when average daily mileage is between 180 and 220 miles.
- A $60 bonus is granted when `miles_traveled / trip_duration_days` falls in this range.

## Evaluation Results
After incorporating the above logic, `./eval.sh` produced the following summary:

- **Exact matches:** 0 of 1000 cases
- **Close matches:** 0 of 1000 cases
- **Average error:** about $262.75 per case
- **Maximum error:** about $1360.12

The high error indicates the legacy system uses additional rules that have not yet been captured.

Further analysis is needed around receipt amounts and longer trip durations.
