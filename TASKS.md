# Implementation Plan

This document summarizes the key tasks required to complete the challenge. The sections referenced below contain the relevant instructions from the project documentation.

## 1. Analyze the documentation
* Review **PRD.md** lines 33–46 and 48–52 for the official requirements.
* Read **README.md** lines 30–68 for guidance on using the provided data and interviews.
* Note potential rules or quirks mentioned throughout **INTERVIEWS.md**.

## 2. Explore the historical data
* Run `python setup.py` if additional Python packages are needed (see **data-agents/README.md**).
* Execute `python data-agents/load_public_cases.py` to generate `public_cases.csv` for easier inspection.
* Use Jupyter notebooks in the `notebooks` directory to analyze `public_cases.csv` and look for patterns in trip length, mileage and receipt totals.

## 3. Develop a baseline algorithm
* Copy `run.sh.template` to `run.sh` and make it executable with `chmod +x run.sh`.
* Implement simple logic reflecting interview hints: a base per diem around $100/day, a five‑day trip bonus, mileage tapering after ~100 miles, and the receipt rounding quirk at `.49`/`.99`.
* Ensure the script accepts `trip_duration_days`, `miles_traveled` and `total_receipts_amount` and prints only the reimbursement amount. Keep runtime under five seconds per case.

## 4. Evaluate and refine
* Run `./eval.sh` against `public_cases.json` (see **README.md** lines 74–90) after each change to `run.sh`.
* Review the score and the high‑error cases reported by the script. Adjust the algorithm to lower the average error and increase the number of exact matches.
* Document parameter adjustments in notebooks or comments for future reference.

## 5. Iterate toward a low score
* Continue refining the logic or experiment with lightweight regression models in the notebooks.
* Combine heuristics and data-driven approaches as needed. The goal is to drive the score reported by `eval.sh` as low as possible.

## 6. Generate results and submit
* When satisfied with the score, run `./generate_results.sh` to produce `private_results.txt` as described in **README.md** lines 90–97.
* Add `arjun-krishna1` as a collaborator on the repository and submit the results file using the provided form.

