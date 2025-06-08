# Top Coder Challenge: Black Box Legacy Reimbursement System

**Reverse-engineer a 60-year-old travel reimbursement system using only historical data and employee interviews.**

ACME Corp's legacy reimbursement system has been running for 60 years. No one knows how it works, but it's still used daily.

8090 has built them a new system, but ACME Corp is confused by the differences in results. Your mission is to figure out the original business logic so we can explain why ours is different and better.

Your job: create a perfect replica of the legacy system by reverse-engineering its behavior from 1,000 historical input/output examples and employee interviews.

## What You Have

### Input Parameters

The system takes three inputs:

- `trip_duration_days` - Number of days spent traveling (integer)
- `miles_traveled` - Total miles traveled (integer)
- `total_receipts_amount` - Total dollar amount of receipts (float)

## Documentation

- A PRD (Product Requirements Document)
- Employee interviews with system hints

### Output

- Single numeric reimbursement amount (float, rounded to 2 decimal places)

### Historical Data

- `public_cases.json` - 1,000 historical input/output examples

### Quick Reference

> **From [Getting Started](#getting-started)**
> 1. **Analyze the data** – inspect `public_cases.json`, `PRD.md`, `INTERVIEWS.md` and the `data-agents` folder.
> 2. **Create your implementation** – copy `run.sh.template` to `run.sh`, implement your logic and output only the reimbursement.
> 3. **Test your solution** – run `./eval.sh` for feedback.
> 4. **Submit** – run `./generate_results.sh`, add `arjun-krishna1` and complete the submission form.

See **[TASKS.md §Analyze the documentation](TASKS.md#1-analyze-the-documentation)** for a checklist of files to review.

Key hints from **[INTERVIEWS.md §Lisa from Accounting](INTERVIEWS.md#lisa-from-accounting)**:

> "Take the per diem calculation. Everyone assumes there's a standard daily rate, and mostly there is. $100 a day seems to be the base."
> "5-day trips almost always get a bonus."
> "Mileage is definitely tiered. First 100 miles or so, you get the full rate—like 58 cents per mile. After that, it drops."
> "If your receipts end in 49 or 99 cents, you often get a little extra money."

## Getting Started

For a walkthrough of how to use `run.sh` along with the evaluation scripts, see
[docs/run_sh_usage.md](docs/run_sh_usage.md).
You can also open `notebooks/00_starter.ipynb` for a quick demonstration. That
notebook relies on helper functions in `scripts/eval_utils.py` to call
`eval.sh` and visualize the mileage and receipt distributions.
For a short overview of the entire workflow, see
[docs/workflow_overview.md](docs/workflow_overview.md).

For a high-level overview of the recommended workflow see
[docs/workflow_overview.md](docs/workflow_overview.md).

1. **Set up your environment**:
   - Run `scripts/setup.sh` to install the optional data science tools
2. **Analyze the data**: 
   - Look at `public_cases.json` to understand patterns
   - Look at `PRD.md` to understand the business problem
   - Look at `INTERVIEWS.md` to understand the business logic
   - Explore the `data-agents` folder for a basic data pipeline
3. **Create your implementation**:
   - Copy `run.sh.template` to `run.sh`
   - Implement your calculation logic
   - Make sure it outputs just the reimbursement amount
   - See [docs/run_sh_usage.md](docs/run_sh_usage.md) for a quick guide
4. **Test your solution**: 
   - Run `./eval.sh` to see how you're doing
   - Use the feedback to improve your algorithm
5. **Submit**:
   - Run `./generate_results.sh` to get your final results.
   - Add `arjun-krishna1` to your repo.
   - Complete [the submission form](https://forms.gle/sKFBV2sFo2ADMcRt8).

## Implementation Requirements

Your `run.sh` script must:

- Take exactly 3 parameters: `trip_duration_days`, `miles_traveled`, `total_receipts_amount`
- Output a single number (the reimbursement amount)
- Run in under 5 seconds per test case
- Work without external dependencies (no network calls, databases, etc.)

Example:

```bash
./run.sh 5 250 150.75
# Should output something like: 487.25
```

## Evaluation

Run `./eval.sh` to test your solution against all 1,000 cases. The script will show:

- **Exact matches**: Cases within ±$0.01 of the expected output
- **Close matches**: Cases within ±$1.00 of the expected output
- **Average error**: Mean absolute difference from expected outputs
- **Score**: Lower is better (combines accuracy and precision)

Your submission will be tested against `private_cases.json` which does not include the outputs.

## Submission

When you're ready to submit:

1. Push your solution to a GitHub repository
2. Add `arjun-krishna1` to your repository
3. Submit via the [submission form](https://forms.gle/sKFBV2sFo2ADMcRt8).
4. When you submit the form you will submit your `private_results.txt` which will be used for your final score.

---

**Good luck and Bon Voyage!**
