# Statistical Validation & Modeling Phase

This document outlines an optional phase to add rigor when refining `run.sh`. It fits between generating initial results and the iterative refinement process described in `AGENTS.md`.

## A. Data Partitioning & Metric Definitions
1. **Train/Test Split** – Randomly split the 1,000 public cases into 80% train and 20% test. Keep the test set untouched until final evaluation.
2. **Error Metrics** – Use MAE, MAPE, WAPE and RMSE to compare rule-based and model-based approaches on equal footing.

## B. Hypothesis Testing of Interview Heuristics
For each rule in your script, run statistical tests on the training set to confirm its effect:
- Five-Day Bonus – two-sample t-test comparing 5-day trips to 4‑ and 6‑day trips.
- Efficiency Bonus – t-test for trips averaging 180–220 miles per day versus others.
- Receipt-Range Effects – ANOVA across receipt buckets to verify mid-range uplift and low-end penalty.
- Rounding Bonus – t-test on totals ending in `.49` or `.99`.
- Simulated Weekday Effects – test for ~3% shifts between "Tuesday" and "Friday" groups.

## C. Parameter Optimization via Grid Search
Search over reasonable bonus and penalty values on the training set and pick those minimizing MAE.

## D. Black-Box Benchmark & Interpretability
1. Fit a Random Forest Regressor using `days`, `miles` and `receipts`.
2. Evaluate its MAE/MAPE on the held-out test set as an upper bound for accuracy.
3. Check feature importances or partial dependence plots to confirm or refine heuristic thresholds.

## E. Residual Clustering for Missing Signals
Cluster the worst residuals from the test set to find new patterns (e.g. very long trips, extremely high receipts) and encode new rules if necessary.

## F. Final Integration
Incorporate any tuned parameters back into `run.sh` and rerun `./eval.sh` before generating the final results.
