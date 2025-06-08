# Process Improvement Notes

This document collects tips for iteratively refining your reimbursement heuristics and evaluation workflow.

- Evaluate early and often to quickly see how parameter tweaks affect accuracy.
- Use `scripts/log_eval.sh` to automatically log scores and metrics, making it easier to track improvements over time.
- Since receipt totals ending in `.49` or `.99` often get a bonus, consider a rule that adds a small amount when receipts end with those values.
- Mileage after ~100 miles may follow a tiered or curved approach; look for patterns in `public_cases.csv` after generating it with `data-agents/load_public_cases.py`.

