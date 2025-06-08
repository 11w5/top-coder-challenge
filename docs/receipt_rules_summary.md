# Receipt Handling Insights

The interviews reveal several quirks about how the legacy reimbursement system treats receipt totals:

- **Small receipts are penalized** – Employees noticed that submitting tiny amounts, especially under $50, can reduce the reimbursement below the base per diem.
- **Mid-range receipts get the best return** – Totals between roughly $600 and $800 yield the highest payout. Higher amounts provide diminishing additional reimbursement.
- **Rounding bonus** – Receipt totals ending in `.49` or `.99` cents often trigger a small bonus due to a rounding bug.

These behaviors informed the heuristics in `run.sh` where we apply a penalty multiplier below $50, taper the reimbursement above $600, and add a $10 bonus when the total ends in `.49` or `.99`.
