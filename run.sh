#!/bin/bash

# Lightweight reimbursement algorithm without external dependencies
# Usage: ./run.sh <trip_duration_days> <miles_traveled> <total_receipts_amount>

DAYS="$1"
MILES="$2"
RECEIPTS="$3"

# exit if parameters missing
if [ -z "$DAYS" ] || [ -z "$MILES" ] || [ -z "$RECEIPTS" ]; then
    echo "0"
    exit 0
fi

# convert receipts dollars to integer cents without external tools
if [[ "$RECEIPTS" == *.* ]]; then
    INT=${RECEIPTS%.*}
    DEC=${RECEIPTS#*.}
    # ensure exactly two decimal digits
    if [ ${#DEC} -eq 1 ]; then
        DEC="${DEC}0"
    else
        DEC="${DEC:0:2}"
    fi
    RECEIPTS_CENTS=$((INT * 100 + DEC))
else
    RECEIPTS_CENTS=$((RECEIPTS * 100))
fi
# base per diem in cents
PER_DIEM_CENTS=$((DAYS * 10000))
# five-day bonus
if [ "$DAYS" -eq 5 ]; then
    PER_DIEM_CENTS=$((PER_DIEM_CENTS + 7500))
fi

# mileage reimbursement: 50 cents first 100 miles, then 25 cents
if [ "$MILES" -le 100 ]; then
    MILE_PAY_CENTS=$((MILES * 50))
else
    FIRST=$((100 * 50))
    REST_MILES=$((MILES - 100))
    REST=$((REST_MILES * 25))
    MILE_PAY_CENTS=$((FIRST + REST))
fi

# receipt component
if [ "$RECEIPTS_CENTS" -lt 5000 ]; then
    RECEIPT_PAY_CENTS=$((RECEIPTS_CENTS * 70 / 100))
elif [ "$RECEIPTS_CENTS" -le 60000 ]; then
    RECEIPT_PAY_CENTS=$((RECEIPTS_CENTS * 80 / 100))
elif [ "$RECEIPTS_CENTS" -le 80000 ]; then
    MID=$((60000 * 80 / 100))
    REM=$((RECEIPTS_CENTS - 60000))
    RECEIPT_PAY_CENTS=$((MID + REM * 50 / 100))
else
    MID=$((60000 * 80 / 100 + 20000 * 50 / 100))
    REM=$((RECEIPTS_CENTS - 80000))
    RECEIPT_PAY_CENTS=$((MID + REM * 30 / 100))
fi

TOTAL_CENTS=$((PER_DIEM_CENTS + MILE_PAY_CENTS + RECEIPT_PAY_CENTS))

# efficiency bonus for 180-220 miles per day
if [ $((MILES * 100)) -ge $((180 * DAYS)) ] && [ $((MILES * 100)) -le $((220 * DAYS)) ]; then
    TOTAL_CENTS=$((TOTAL_CENTS + 6000))
fi

# receipt rounding quirk bonus
CENTS_MOD=$((RECEIPTS_CENTS % 100))
if [ "$CENTS_MOD" -eq 49 ] || [ "$CENTS_MOD" -eq 99 ]; then
    TOTAL_CENTS=$((TOTAL_CENTS + 1000))
fi

# simulated day-of-week adjustment
HASH=$(( (DAYS + MILES) % 7 ))
if [ "$HASH" -eq 2 ]; then
    TOTAL_CENTS=$((TOTAL_CENTS * 103 / 100))
elif [ "$HASH" -eq 5 ]; then
    TOTAL_CENTS=$((TOTAL_CENTS * 97 / 100))
fi

# output in dollars with two decimals
printf '%d.%02d\n' $((TOTAL_CENTS / 100)) $((TOTAL_CENTS % 100))
