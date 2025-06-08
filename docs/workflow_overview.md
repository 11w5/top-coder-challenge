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
