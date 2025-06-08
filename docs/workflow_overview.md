# Workflow Overview

This document summarizes the iterative approach for reproducing the legacy reimbursement logic.

1. **Validate that it is not a forecasting problem**
   - Follow the steps in [docs/temporal_validation_summary.md](temporal_validation_summary.md) to confirm there are no time based fields and that the order of records does not matter.
2. **Translate interview clues into rules**
   - Convert hints from `INTERVIEWS.md` into concrete logic inside `run.sh` (e.g. five‑day bonuses, mileage tapering, receipt rounding quirks).
3. **Run the evaluation script repeatedly**
   - Execute `./eval.sh` (or `scripts/log_eval.sh` if you prefer to capture logs) after each change and review the summary of exact and close matches.
4. **Apply statistical validation and tuning**
   - If desired, split the public data into train and test sets and use the techniques in `docs/statistical_validation_modeling.md` to tune parameters.
5. **Generate final results**
   - Once your logic is stable, run `./generate_results.sh` to create `private_results.txt` for submission.
