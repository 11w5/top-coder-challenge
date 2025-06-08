# Process Optimization Tips

This document compiles workflow suggestions and caveats to streamline the challenge.

## Recommended Steps

1. **Study the context** – Read the docs listed in `TASKS.md` lines 5‑8, especially `PRD.md`, `README.md` lines 34‑56 and `INTERVIEWS.md`【F:AGENTS.md†L5-L10】.
2. **Set up the environment** – Run `python setup.py` if Python tools are required and document any analysis in Jupyter notebooks【F:AGENTS.md†L30-L32】.
3. **Implement `run.sh`** – Copy `run.sh.template`, ensure it accepts the three parameters and prints only the reimbursement amount. Make it executable with `chmod +x run.sh`【F:AGENTS.md†L34-L40】.
4. **Evaluate frequently** – Use `./eval.sh` on the 1,000 public cases, avoiding modifications to the script or dataset. Review the summary and error messages for refinement【F:AGENTS.md†L42-L46】.
5. **Log your results** – `scripts/log_eval.sh` appends each evaluation to `eval_history.csv` so progress can be tracked over time【F:AGENTS.md†L47-L47】.
6. **Use notebooks to iterate** – Create notebooks like `01_EDA.ipynb` or `02_Heuristics.ipynb` to experiment. Call `eval.sh` via `subprocess` inside them for quick feedback【F:AGENTS.md†L49-L50】.
7. **Generate final results** – Once satisfied, run `./generate_results.sh` to produce `private_results.txt` for submission【F:AGENTS.md†L52-L53】.
8. **Optional statistical validation** – Split the data into train/test sets, measure MAE, MAPE, WAPE and RMSE, and tune rule parameters before final evaluation【F:AGENTS.md†L59-L69】.

## Scoring Formula

The evaluation script computes a score using:

```
score = avg_error * 100 + (num_cases - exact_matches) * 0.1
```

Tracking this metric along with MAE and MAPE helps gauge progress.

## Additional Caveats and Optimizations

- Ensure `jq` and `bc` are installed before running the scripts; `eval.sh` will exit with an error if either tool is missing.
- The `log_eval.sh` script simplifies monitoring improvements by recording results with timestamps.
- Consider automating setup (e.g., with a shell script) so collaborators can reproduce the environment quickly.
- After the score stabilizes, proceed with `generate_results.sh` to avoid overfitting the public cases.
