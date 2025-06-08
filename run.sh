#!/bin/bash
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
