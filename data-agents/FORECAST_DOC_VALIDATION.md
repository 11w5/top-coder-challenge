# Linear Logic Validation Tasks

This guide presents a set of linear logic tasks to help validate the ideas presented in the following documentation files located in the project root:

- `Assessing the Forecastability of Time Series.md`
- `Distinguishing Forecasting from Other Predictive Tasks.md`
- `Evaluating Forecast Performance.md`

Each section below lists sequential tasks that consume the output of the previous step to build a rigorous understanding of the core problem.

## 1. Assessing the Forecastability of Time Series

1. **Summarize the definitions** – Extract key definitions of forecastability and related measures from the document. Confirm how terms such as *Coefficient of Variation* or *SVD Entropy* are described.
2. **Identify available metrics in the dataset** – Use `load_public_cases.py` to generate `public_cases.csv` and inspect which columns (e.g., `trip_duration_days`, `miles_traveled`, `total_receipts_amount`) might be used to compute basic measures of volatility or intermittency.
3. **Compute sample measures** – In a notebook or script, compute simple statistics (e.g., coefficient of variation) for selected series. Compare results with the explanations in the markdown file.
4. **Determine forecastability** – Based on the computed measures, decide which series appear predictable and which do not. Document how this aligns with the criteria outlined in the markdown file.

## 2. Distinguishing Forecasting from Other Predictive Tasks

1. **Check temporal structure** – Verify that the data from `public_cases.csv` has a meaningful chronological order. If shuffling the rows breaks the interpretation, forecasting methods are justified.
2. **Classify the target** – Confirm that the outcome you wish to predict is a future numeric value (e.g., reimbursement amount). If the goal were to assign a label or detect anomalies, it would fall outside pure forecasting.
3. **Validate assumptions** – Review the markdown file’s criteria (stationarity, sufficient history, etc.) and test them on a small sample of the data. Use plots or simple statistics to show whether these assumptions hold.
4. **Decide on method suitability** – If the data and goal meet the outlined criteria, proceed with a forecasting approach; otherwise consider alternate predictive methods.

## 3. Evaluating Forecast Performance

1. **Select appropriate metrics** – From the list of metrics in the markdown file, pick those that match the type of forecasts you generate (point or probabilistic). Examples include MAE, RMSE, WAPE, or CRPS.
2. **Create a baseline forecast** – Implement a naïve model (e.g., last value or average) in `run.sh` to produce simple predictions. This serves as a benchmark for evaluation.
3. **Compute errors** – Run `./eval.sh` after implementing `run.sh` and collect the output. Capture metrics such as average error or percentage of exact matches.
4. **Iterate and compare** – Adjust your forecasting logic, rerun the evaluation, and compare results against the baseline to quantify improvement.

---

These tasks follow a linear progression: start by understanding forecastability, confirm that the problem truly requires forecasting, then evaluate performance using metrics that reflect your objectives. By walking through these steps sequentially, you can validate the ideas in the documentation and build a deeper understanding of the overall forecasting challenge.
