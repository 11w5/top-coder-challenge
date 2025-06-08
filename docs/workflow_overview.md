# Workflow Overview

This guide summarizes the recommended steps for replicating the legacy reimbursement logic.

1. **Validate that the dataset is not a forecasting problem**  
   See [temporal_validation_summary.md](temporal_validation_summary.md) for how to confirm there is no meaningful time component.
2. **Translate interview clues into rules**  
   Use the hints in [../INTERVIEWS.md](../INTERVIEWS.md) to craft heuristics such as daily rates, mileage tiers and receipt rounding effects.
3. **Run the evaluation script repeatedly**  
   After each change to `run.sh`, run `./eval.sh` (or `scripts/log_eval.sh`) to measure accuracy on the public cases.
4. **Apply statistical validation and tuning (optional)**  
   Follow [statistical_validation_modeling.md](statistical_validation_modeling.md) to test rules and optimize parameters if desired.
5. **Generate `private_results.txt`**  
   When satisfied, run `./generate_results.sh` to produce the file used for your submission.

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