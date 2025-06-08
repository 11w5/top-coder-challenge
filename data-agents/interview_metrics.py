import pandas as pd

# Load dataset

def load_data(path="data-agents/public_cases.csv"):
    """Load the reimbursement dataset from CSV."""
    return pd.read_csv(path)


def five_day_bonus_metric(df: pd.DataFrame) -> float:
    """Return the average extra reimbursement per day for 5-day trips
    relative to 4- and 6-day trips."""
    five_day = df[df["trip_duration_days"] == 5]
    near_days = df[df["trip_duration_days"].isin([4, 6])]
    if five_day.empty or near_days.empty:
        return float('nan')
    five_avg = five_day["expected_output"].mean() / 5
    near_avg = near_days["expected_output"].mean() / near_days["trip_duration_days"].mean()
    return five_avg - near_avg


def mileage_taper_metric(df: pd.DataFrame) -> pd.Series:
    """Compute average reimbursement per mile for different mileage buckets."""
    bins = [0, 100, 300, 600, 1000, df["miles_traveled"].max()+1]
    labels = ["<=100", "100-300", "300-600", "600-1000", ">1000"]
    df["miles_bucket"] = pd.cut(df["miles_traveled"], bins=bins, labels=labels, right=False)
    return df.groupby("miles_bucket")["expected_output"].sum() / df.groupby("miles_bucket")["miles_traveled"].sum()


def receipt_range_metric(df: pd.DataFrame) -> pd.DataFrame:
    """Return reimbursement-to-receipt ratios for key ranges."""
    bins = [0, 50, 600, 800, 2000, df["total_receipts_amount"].max()+1]
    labels = ["<50", "50-600", "600-800", "800-2000", ">2000"]
    df["receipt_bucket"] = pd.cut(df["total_receipts_amount"], bins=bins, labels=labels, right=False)
    ratio = df.groupby("receipt_bucket")["expected_output"].sum() / df.groupby("receipt_bucket")["total_receipts_amount"].sum()
    return ratio.reset_index(name="reimb_per_dollar")


def rounding_bonus_metric(df: pd.DataFrame) -> float:
    """Measure average reimbursement difference for receipts ending in .49 or .99."""
    mask = df["total_receipts_amount"].round(2).astype(str).str.endswith((".49", ".99"))
    bonus_avg = df[mask]["expected_output"].mean()
    others_avg = df[~mask]["expected_output"].mean()
    return bonus_avg - others_avg


def efficiency_bonus_metric(df: pd.DataFrame) -> float:
    """Check average bonus for trips with 180-220 miles per day."""
    miles_per_day = df["miles_traveled"] / df["trip_duration_days"]
    mask = miles_per_day.between(180, 220)
    in_range = df[mask]["expected_output"].mean()
    out_range = df[~mask]["expected_output"].mean()
    return in_range - out_range


def main():
    df = load_data()
    print("Five-day bonus per-day difference:", round(five_day_bonus_metric(df), 2))
    print("\nMileage tapering (reimbursement per mile by bucket):")
    print(mileage_taper_metric(df).round(4))
    print("\nReceipt range reimbursement per dollar:")
    print(receipt_range_metric(df))
    print("\nRounding bonus difference:", round(rounding_bonus_metric(df), 2))
    print("Efficiency bonus difference:", round(efficiency_bonus_metric(df), 2))


if __name__ == "__main__":
    main()
