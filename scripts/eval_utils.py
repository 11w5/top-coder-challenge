import subprocess
from typing import Any
import pandas as pd
import matplotlib.pyplot as plt


def run_eval() -> str:
    """Run ./eval.sh and return its stdout."""
    result = subprocess.run(["./eval.sh"], capture_output=True, text=True)
    return result.stdout


def plot_histograms(df: pd.DataFrame) -> Any:
    """Plot basic histograms for mileage and receipts."""
    fig, axes = plt.subplots(1, 2, figsize=(10, 4))
    df["miles_traveled"].hist(ax=axes[0], bins=30, color="skyblue", edgecolor="black")
    axes[0].set_title("Miles Traveled")
    axes[0].set_xlabel("Miles")
    axes[0].set_ylabel("Count")

    df["total_receipts_amount"].hist(ax=axes[1], bins=30, color="salmon", edgecolor="black")
    axes[1].set_title("Total Receipts")
    axes[1].set_xlabel("Amount ($)")
    axes[1].set_ylabel("Count")

    plt.tight_layout()
    return axes

