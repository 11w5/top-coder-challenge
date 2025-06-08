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
