# Workflow Overview

This guide summarizes the recommended cycle for reverse engineering the legacy reimbursement logic.

1. **Verify it is not a forecasting problem**
   - Follow the steps in [temporal_validation_summary.md](temporal_validation_summary.md) to confirm the dataset has no meaningful time component.
2. **Translate interview clues into rules**
   - Use the hints in `INTERVIEWS.md` and any notebook analysis to craft heuristic rules.
3. **Run the evaluation scripts repeatedly**
   - Execute `./eval.sh` (or `scripts/log_eval.sh` if you want to save logs) after each change and inspect the output.
4. **Apply statistical validation and tuning** *(optional)*
   - If you want additional rigor, split the public data into train and test sets and follow techniques from `docs/statistical_validation_modeling.md`.
5. **Generate final results**
   - Once the score stabilizes, run `./generate_results.sh` to produce `private_results.txt` for submission.

This high-level workflow keeps the focus on deterministic rules and quick feedback.
