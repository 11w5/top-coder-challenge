#!/bin/bash
# Reimbursement calculation script
DAYS=$1
MILES=$2
RECEIPTS=$3

# Base per diem
PER_DIEM=$(echo "$DAYS * 100" | bc)

# Mileage reimbursement with taper
MILEAGE_BASE=$(echo "if ($MILES<100) $MILES else 100" | bc)
MILEAGE_EXTRA=$(echo "if ($MILES>100) $MILES-100 else 0" | bc)
MILEAGE_PAY=$(echo "$MILEAGE_BASE * 0.5 + $MILEAGE_EXTRA * 0.3" | bc)

# Receipt reimbursement with diminishing returns
if (( $(echo "$RECEIPTS < 50" | bc) )); then
    RECEIPT_PAY=$(echo "$RECEIPTS * 0.2" | bc)
else
    LOW=$(echo "if ($RECEIPTS<800) $RECEIPTS else 800" | bc)
    HIGH=$(echo "if ($RECEIPTS>800) $RECEIPTS-800 else 0" | bc)
    RECEIPT_PAY=$(echo "$LOW * 0.8 + $HIGH * 0.2" | bc)
fi

TOTAL=$(echo "$PER_DIEM + $MILEAGE_PAY + $RECEIPT_PAY" | bc)

# Five-day bonus
if [ "$DAYS" -eq 5 ]; then
    TOTAL=$(echo "$TOTAL + 75" | bc)
fi

# Mileage efficiency bonus
if (( $(echo "$DAYS > 0" | bc) )); then
    AVG=$(echo "scale=2; $MILES / $DAYS" | bc)
    if (( $(echo "$AVG >= 180 && $AVG <= 220" | bc) )); then
        TOTAL=$(echo "$TOTAL + 60" | bc)
    fi
fi

# Receipt rounding quirk bonus
cents=$(printf "%.2f" "$RECEIPTS" | awk -F'.' '{print $2}')
if [ "$cents" = "49" ] || [ "$cents" = "99" ]; then
    TOTAL=$(echo "$TOTAL + 5" | bc)
fi

printf "%.2f\n" "$TOTAL"
