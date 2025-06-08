# Forecast Doc Validation

This document outlines why the public cases data set is *not* a time series forecasting problem and how that informs the exploratory analysis.

* **No chronological ordering.** Each record is a standalone trip summary with days traveled, miles, receipts, and the final reimbursement. There is no timestamp or sequence linking one trip to the next.
* **Independent records.** The interviews describe arbitrary trips across different employees. Shuffling the rows does not change the meaning.
* **Target is a deterministic output.** We are trying to reproduce a rule-based reimbursement amount, not predict an unknown future value. The goal is to model a hidden formula, not to forecast a stochastic process.

Given this, methods aimed at evaluating forecast accuracy (e.g., MAE or MAPE over time) are not applicable. Instead the data should be analyzed for patterns or thresholds in mileage, receipts, and trip duration that reveal the underlying business rules.
