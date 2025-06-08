# Self-Improvement Workflow Guide

This guide expands on the main repository instructions with a focus on how agents can systematically document and improve their reimbursement logic. Follow these practices to steadily lower the evaluation score without overfitting the public dataset.

## 1. Record Every Evaluation
- Run `scripts/log_eval.sh` after each change to append results to `eval_history.csv`. This captures the exact/close matches, average error and score along with a timestamp【F:process_optimizations.md†L11-L12】【F:process_improvement_notes.md†L5-L6】.
- Review the `score` formula from the docs to understand how improvements affect the metric:

```
score = avg_error * 100 + (num_cases - exact_matches) * 0.1
```
【F:process_optimizations.md†L16-L24】

## 2. Maintain Qualitative Notes
- For each evaluation run, jot down what changed and why you expected it to help. A short summary in a notebook or markdown file keeps context for the numbers.
- Reference interview hints and high-error cases so that qualitative reasoning accompanies the quantitative logs.

## 3. Split Public Data for Tuning
- To avoid overfitting, randomly hold out 20% of `public_cases.json` as a test set and keep it untouched until the end【F:statistical_validation_modeling.md†L9-L10】.
- Track MAE, MAPE, WAPE and RMSE on this holdout set to validate new rules or model parameters【F:statistical_validation_modeling.md†L11-L12】.

## 4. Analyze Residual Patterns
- After each evaluation, inspect the worst residuals for common themes such as long trips, high receipts or unusual mileage. Document new hypotheses before implementing additional rules.
- Use notebooks to visualize these patterns and call `eval.sh` via `subprocess` for quick feedback【F:process_optimizations.md†L12-L12】.

## 5. Integrate Only Proven Improvements
- When a change consistently lowers the score on both the train and held-out test sets, incorporate it into `run.sh` and commit the update.
- Summarize successful adjustments in `docs/process_improvement_notes.md` or a new note so future agents understand what has already been tried.

## 6. Continue the Loop
- Hypothesize → Implement → Evaluate → Log → Document. Repeat until the score stops improving significantly.
- Once metrics stabilize, generate `private_results.txt` with `./generate_results.sh` but avoid rerunning it too often to minimize exposure to the private data scheme【F:process_optimizations.md†L28-L31】.

Consistent logging and thoughtful notes will reveal which strategies drive the score lower while keeping the solution generalized.
