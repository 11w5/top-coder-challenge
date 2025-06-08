# Baseline Heuristics

This note outlines the starter logic used in `run.sh` for replicating the legacy reimbursement system. These rules come from the employee interviews in `INTERVIEWS.md` and our early experiments.

1. **Base per diem and five‑day bonus**
   - Lisa confirmed a daily allowance of roughly $100 with an extra boost on five‑day trips【F:interviews-details.md†L13-L14】【F:interviews-details.md†L40-L42】.
2. **Mileage tapering after the first 100 miles**
   - The mileage rate begins to drop once a trip exceeds about 100 miles, following a non‑linear curve【F:INTERVIEWS.md†L123-L126】.
3. **Receipt rounding bonus and scaling**
   - Receipts ending in `.49` or `.99` earn a small rounding bonus【F:INTERVIEWS.md†L181-L185】.
   - Reimbursements scale best when receipts fall in the mid range ($600–$800) and diminish for high totals, while very low amounts may be penalized【F:INTERVIEWS.md†L136-L151】.
4. **Efficiency bonus for 180–220 miles per day**
   - High mileage per day is rewarded, with a sweet spot around 180–220 miles per day according to Kevin【F:INTERVIEWS.md†L410-L421】.
5. **Simulated day‑of‑week adjustment**
   - Because the dataset lacks timestamps, we simulate a Tuesday boost and a Friday penalty as suggested by Kevin’s weekday observations【F:INTERVIEWS.md†L438-L447】. This preserves the effect even without actual dates.

For instructions on copying the template, making the script executable, and running evaluations, see [docs/run_sh_usage.md](run_sh_usage.md).
