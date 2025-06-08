#!/bin/bash
# Simple linear regression-based reimbursement estimator
# Usage: ./run.sh <trip_duration_days> <miles_traveled> <total_receipts_amount>

DAYS="$1"
MILES="$2"
RECEIPTS="$3"

if [ -z "$DAYS" ] || [ -z "$MILES" ] || [ -z "$RECEIPTS" ]; then
    echo "0"
    exit 0
fi

# Coefficients derived from linear regression on public_cases.json
INTERCEPT=266.7076805048639
COEF_DAYS=50.05048622
COEF_MILES=0.44564529
COEF_RECEIPTS=0.38286076

# bc computation with 2 decimal precision
RESULT=$(echo "scale=4; $INTERCEPT + $COEF_DAYS*$DAYS + $COEF_MILES*$MILES + $COEF_RECEIPTS*$RECEIPTS" | bc)
printf '%.2f\n' "$RESULT"
