#!/usr/bin/env python3
"""
Condensed Data Science Setup Script

Usage: python setup.py
"""

import subprocess
import sys

def run_cmd(cmd):
    try:
        subprocess.run(cmd, shell=True, check=True, capture_output=True)
        print(f"✓ {cmd}")
    except:
        print(f"✗ {cmd}")

def main():
    print("Setting up Data Science Environment...")
    
    # Core install
    packages = [
        "numpy pandas scipy scikit-learn matplotlib seaborn plotly",
        "jupyter jupyterlab ipywidgets xgboost",
        "statsmodels requests openpyxl"
    ]
    
    for pkg_group in packages:
        run_cmd(f"{sys.executable} -m pip install {pkg_group}")
    
    # System bc calculator
    try:
        subprocess.run("which bc", shell=True, check=True, capture_output=True)
        print("✓ bc available")
    except:
        print("Installing bc...")
        import platform
        if platform.system() == "Linux":
            run_cmd("sudo apt-get update && sudo apt-get install -y bc")
        elif platform.system() == "Darwin":
            run_cmd("brew install bc")
    
    # Enable widgets
    run_cmd("jupyter nbextension enable --py widgetsnbextension")
    
    print("Setup complete! 🎉")

if __name__ == "__main__":
    main()
