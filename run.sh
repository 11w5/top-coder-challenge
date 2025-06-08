#!/bin/bash
# Reimbursement calculation with simple heuristics
DAYS=$1
MILES=$2
RECEIPTS=$3

# Base per diem
REIM=$(echo "$DAYS * 80" | bc)
if [ "$DAYS" -eq 5 ]; then
  REIM=$(echo "$REIM + 40" | bc)
fi

# Mileage taper
if (( $(echo "$MILES <= 100" | bc) )); then
  MILE_PAY=$(echo "$MILES * 0.6" | bc)
else
  MILE_PAY=$(echo "100 * 0.6 + ($MILES - 100) * 0.4" | bc)
fi
REIM=$(echo "$REIM + $MILE_PAY" | bc)

# Receipt component
if (( $(echo "$RECEIPTS < 50" | bc) )); then
  REC_PART=$(echo "$RECEIPTS * 0.7" | bc)
elif (( $(echo "$RECEIPTS <= 600" | bc) )); then
  REC_PART=$(echo "$RECEIPTS * 0.8" | bc)
elif (( $(echo "$RECEIPTS <= 800" | bc) )); then
  REC_PART=$(echo "600 * 0.8 + ($RECEIPTS - 600) * 0.5" | bc)
else
  REC_PART=$(echo "600 * 0.8 + 200 * 0.5 + ($RECEIPTS - 800) * 0.3" | bc)
fi
REIM=$(echo "$REIM + $REC_PART" | bc)

# Bonus for receipts ending .49 or .99
FRAC=$(printf "%.2f" "$RECEIPTS")
if [[ "$FRAC" =~ \.49$ || "$FRAC" =~ \.99$ ]]; then
  REIM=$(echo "$REIM + 10" | bc)
fi

printf "%.2f" "$REIM"
=======
# Simple reimbursement baseline
# Usage: ./run.sh <trip_duration_days> <miles_traveled> <total_receipts_amount>

trip_days="$1"
miles="$2"
receipts="$3"  # unused for baseline

# Base per diem: $100 per day
per_diem=$(echo "scale=2; $trip_days * 100" | bc)

# Mileage reimbursement: 0.5 per mile for first 100 miles, then 0.25 per mile
if (( $(echo "$miles <= 100" | bc) )); then
    mileage=$(echo "scale=2; $miles * 0.5" | bc)
else
    mileage_first=$(echo "scale=2; 100 * 0.5" | bc)
    remaining=$(echo "$miles - 100" | bc)
    mileage_rest=$(echo "scale=2; $remaining * 0.25" | bc)
    mileage=$(echo "scale=2; $mileage_first + $mileage_rest" | bc)
fi

# Total reimbursement
result=$(echo "scale=2; $per_diem + $mileage" | bc)

# Output only the numeric result
printf "%.2f\n" "$result"