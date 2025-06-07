# `run.sh` Quick Start

1. Copy the template:
   ```bash
   cp run.sh.template run.sh
   chmod +x run.sh
   ```

2. Edit `run.sh` or delegate to another script. It must accept three parameters:
   ```bash
   ./run.sh <trip_duration_days> <miles_traveled> <total_receipts_amount>
   ```
   The script should print only the reimbursement amount (no extra text).

3. Test your implementation:
   ```bash
   ./eval.sh
   ```
   This compares your output against `public_cases.json`.

4. Generate results for submission:
   ```bash
   ./generate_results.sh
   ```
   This creates `private_results.txt` for the submission form.
