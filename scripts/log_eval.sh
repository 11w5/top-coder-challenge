#!/bin/bash
set -e

# Determine repository root based on script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
cd "$ROOT_DIR"

# Run evaluation and capture output
output=$(./eval.sh)

# Display output to user
echo "$output"

# Extract metrics using grep and parameter expansion
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

total_cases=$(echo "$output" | grep -oP 'Total test cases: \K[0-9]+' || true)
successful_runs=$(echo "$output" | grep -oP 'Successful runs: \K[0-9]+' || true)
exact_matches=$(echo "$output" | grep -oP 'Exact matches.*: \K[0-9]+' || true)
close_matches=$(echo "$output" | grep -oP 'Close matches.*: \K[0-9]+' || true)
avg_error=$(echo "$output" | grep -oP 'Average error: \$\K[0-9.]+' || true)
score=$(echo "$output" | grep -oP 'Your Score: \K[0-9.]+' || true)

# Initialize CSV with header if it doesn't exist
if [ ! -f eval_history.csv ]; then
    echo "timestamp,total_cases,successful_runs,exact_matches,close_matches,avg_error,score" > eval_history.csv
fi

# Append metrics
echo "$timestamp,$total_cases,$successful_runs,$exact_matches,$close_matches,$avg_error,$score" >> eval_history.csv
