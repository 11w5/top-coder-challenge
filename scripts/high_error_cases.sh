#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
cd "$ROOT_DIR"

output=$(./eval.sh)

echo "$output"

echo "$output" | grep -A1 '^    Case' | sed 's/^ *//' > high_error_cases.txt

echo "Saved high-error cases to high_error_cases.txt"
