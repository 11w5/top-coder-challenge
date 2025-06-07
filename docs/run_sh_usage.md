codex/create-run.sh-usage-guide-markdown
# Using `run.sh`

Follow these steps to implement and test your reimbursement script:

1. **Create the script**
   - Copy the provided template:
     ```bash
     cp run.sh.template run.sh
     ```
   - Open `run.sh` and implement the calculation logic.
   - After saving the file, make it executable:
     ```bash
     chmod +x run.sh
     ```

2. **Verify the output**
   - Your script must print **only** the reimbursement amount as a number. Do not include extra text or formatting.

3. **Evaluate your solution**
   - Run the evaluation script to measure accuracy on the public dataset:
     ```bash
     ./eval.sh
     ```
   - Review the feedback to refine your logic.

4. **Generate final results**
   - When ready to submit, produce `private_results.txt` by running:
     ```bash
     ./generate_results.sh
     ```

These results will be used for the final scoring of your solution.
=======
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
