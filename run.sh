#!/bin/bash

# Baseline reimbursement algorithm
# Usage: ./run.sh <trip_duration_days> <miles_traveled> <total_receipts_amount>

DAYS="$1"
MILES="$2"
RECEIPTS="$3"

# exit if parameters missing
if [ -z "$DAYS" ] || [ -z "$MILES" ] || [ -z "$RECEIPTS" ]; then
    echo "0"
    exit 0
fi

# Base per diem
PER_DIEM=$(echo "scale=2; $DAYS * 100" | bc)

# Five-day bonus
if [ "$DAYS" -eq 5 ]; then
    PER_DIEM=$(echo "scale=2; $PER_DIEM + 75" | bc)
fi

# Mileage reimbursement: 0.50 per mile for first 100 miles, 0.25 thereafter
if (( $(echo "$MILES <= 100" | bc) )); then
    MILE_PAY=$(echo "scale=2; $MILES * 0.5" | bc)
else
    FIRST=$(echo "scale=2; 100 * 0.5" | bc)
    REST_MILES=$(echo "$MILES - 100" | bc)
    REST=$(echo "scale=2; $REST_MILES * 0.25" | bc)
    MILE_PAY=$(echo "scale=2; $FIRST + $REST" | bc)
fi

# Receipt component with diminishing returns
if (( $(echo "$RECEIPTS < 50" | bc) )); then
    RECEIPT_PAY=$(echo "scale=2; $RECEIPTS * 0.7" | bc)
elif (( $(echo "$RECEIPTS <= 600" | bc) )); then
    RECEIPT_PAY=$(echo "scale=2; $RECEIPTS * 0.8" | bc)
elif (( $(echo "$RECEIPTS <= 800" | bc) )); then
    MID=$(echo "scale=2; 600 * 0.8" | bc)
    REM=$(echo "$RECEIPTS - 600" | bc)
    RECEIPT_PAY=$(echo "scale=2; $MID + $REM * 0.5" | bc)
else
    MID=$(echo "scale=2; 600 * 0.8 + 200 * 0.5" | bc)
    REM=$(echo "$RECEIPTS - 800" | bc)
    RECEIPT_PAY=$(echo "scale=2; $MID + $REM * 0.3" | bc)
fi

TOTAL=$(echo "scale=2; $PER_DIEM + $MILE_PAY + $RECEIPT_PAY" | bc)

# Efficiency bonus for 180-220 miles per day
AVG_MPD=$(echo "scale=2; $MILES / $DAYS" | bc)
if (( $(echo "$AVG_MPD >= 180 && $AVG_MPD <= 220" | bc) )); then
    TOTAL=$(echo "scale=2; $TOTAL + 60" | bc)
fi

# Receipt rounding quirk bonus
CENTS=$(printf "%.2f" "$RECEIPTS" | awk -F'.' '{print $2}')
if [ "$CENTS" = "49" ] || [ "$CENTS" = "99" ]; then
    TOTAL=$(echo "scale=2; $TOTAL + 10" | bc)
fi

# Simulated day-of-week adjustment using a simple hash of the inputs
HASH=$(( (DAYS + ${MILES%.*}) % 7 ))
if [ "$HASH" -eq 2 ]; then
    # Tuesday boost
    TOTAL=$(echo "scale=2; $TOTAL * 1.03" | bc)
elif [ "$HASH" -eq 5 ]; then
    # Friday penalty
    TOTAL=$(echo "scale=2; $TOTAL * 0.97" | bc)
fi

printf "%.2f\n" "$TOTAL"
