# Agent Workflow Guide

This repository contains everything you need to reverse engineer the legacy reimbursement system. Follow the steps below to iterate quickly and avoid common pitfalls.

## 1. Study the Context
- **Read the documentation** referenced in `TASKS.md` lines 5–8. In particular review:
  - `PRD.md` for project requirements.
  - `README.md` lines 34–56 for how to analyze the data and create your implementation.
  - `INTERVIEWS.md` for business logic hints (e.g. base per diem around $100, 5‑day trip bonuses, mileage tapering after ~100 miles, receipt rounding quirks at .49/.99).
- Examine the schema of `public_cases.json` to see the `input` fields and `expected_output` values.

## 2. Environment Setup
- If you need Python data science tools, run `python setup.py` (see `data-agents/README.md` lines 5–11) to install packages and Jupyter support.
- Start Jupyter with `jupyter lab` or `jupyter notebook` after setup.

## 3. Implement `run.sh`
- Copy `run.sh.template` to `run.sh` and fill in your calculation logic. Ensure the script:
  - Accepts `trip_duration_days`, `miles_traveled` and `total_receipts_amount` as parameters.
  - Prints **only** the reimbursement amount.
  - Finishes each call in under five seconds and avoids network or database access.
  - See `README.md` lines 60–65 for the full requirements.
- Make it executable: `chmod +x run.sh`.

## 4. Evaluate Frequently
- Run `./eval.sh` to test against the 1,000 public cases (per `README.md` lines 50–52 and 74–80).
- Inspect the summary and error messages to refine your algorithm.
- Do **not** modify `eval.sh` or the data files.

## 5. Iterate with Notebooks
- Create notebooks (e.g. `01_EDA.ipynb`, `02_Heuristics.ipynb`, `03_MachineLearning.ipynb`, `04_Hybrid.ipynb`) to explore data and experiment with algorithms. Each notebook can call `eval.sh` via `subprocess` for feedback.

## 6. Generate Final Results
- When satisfied, run `./generate_results.sh` to produce `private_results.txt` for submission (see `README.md` lines 53–56 and `TASKS.md` lines 19–22).

Stick to this workflow and you will be able to test multiple ideas quickly without getting stuck on the evaluation scripts.

## 7. Statistical Validation & Modeling
Between generating your initial results and embarking on iterative refinement, incorporate a data‑driven validation phase:

### A. Data Partitioning & Metric Definitions
1. **Train/Test Split** – Randomly divide the 1,000 public cases into an 80% train / 20% test set and keep the test portion untouched until final evaluation.
2. **Forecast‑style Metrics** – Track MAE, MAPE, WAPE and RMSE so rule‑based and model‑based approaches can be compared on equal footing.

### B. Hypothesis Testing of Interview Heuristics
For each rule inspired by the interviews, perform a statistical test on the train set:
1. **Five‑Day Bonus** – Two‑sample t‑test comparing five‑day trips to four‑ and six‑day trips.
2. **Efficiency Bonus** – Test trips averaging 180–220 miles per day against others.
3. **Receipt‑Range Effects** – ANOVA or Kruskal‑Wallis across receipt buckets (<50, 50–600, 600–800, >800).
4. **Rounding Bonus** – t‑test for receipts ending in .49/.99 versus the rest.
5. **Simulated Weekday Effects** – Validate the 3% shift between "Tuesday" and "Friday" submissions.

### C. Parameter Optimization via Grid Search
Search over plausible bonus and penalty values on the train set to minimize MAE.

### D. Black‑Box Benchmark & Interpretability
Train a Random Forest regressor as an accuracy upper bound and inspect feature importances or partial dependence plots for natural breakpoints.

### E. Residual Clustering for Missing Signals
Cluster the worst‑offending residuals on the test set to uncover any additional patterns, such as long trips over eight days or very high receipts.

### F. Final Integration & Rigorous Evaluation
Incorporate tuned parameters back into `run.sh`, rerun `./generate_results.sh`, and compare MAE, MAPE, WAPE and RMSE against the Random Forest benchmark as well as prior iterations.

## 8. Iterative Refinement Strategy
The prior discussion recommended repeatedly testing hypotheses drawn from the business context. Use the guidance in `FORECAST_DOC_VALIDATION.md` to structure this process:
1. Confirm that the data is not a forecasting problem (lines 1‑9).
2. Form rules from interviews—e.g., receipt thresholds, mileage bonuses, five‑day trip boosts.
3. After each change, run `./eval.sh` and note the exact and close match counts as well as the average error.
4. Keep adjusting your algorithm based on these metrics until improvements plateau.

This cycle of hypothesis and measurement should reveal the deterministic logic behind the legacy system.
