# Data Agents Workflow

This directory provides a minimal starting point for exploring the reimbursement data.

## Setup

1. (Optional) create a Python environment.
2. Install the required packages:
   ```bash
   pip install -r requirements.txt
   ```
   Alternatively run `python ../setup.py` from the repository root for a full data science environment.

## Usage

Run the data loader to convert `public_cases.json` into a CSV file and display a few statistics:

```bash
python load_public_cases.py
```

The script writes `public_cases.csv` in this folder for easy inspection. Modify the script or add new ones to experiment with forecasting ideas and other hypotheses.
