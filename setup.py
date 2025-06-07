#!/usr/bin/env python3
"""
Data Science Environment Setup Script

This script installs all necessary dependencies for data science work,
including visualization libraries and Jupyter widgets.

Usage:
    python setup.py
"""

import subprocess
import sys
import os

def run_command(command):
    """Run a shell command and handle errors."""
    try:
        result = subprocess.run(command, shell=True, check=True, 
                              capture_output=True, text=True)
        print(f"✓ {command}")
        return result
    except subprocess.CalledProcessError as e:
        print(f"✗ Failed: {command}")
        print(f"Error: {e.stderr}")
        return None

def main():
    """Main setup function."""
    print("Setting up Data Science Environment...")
    print("=" * 50)
    
    # Upgrade pip first
    print("\n1. Upgrading pip...")
    run_command(f"{sys.executable} -m pip install --upgrade pip")
    
    # Install from requirements.txt if it exists
    if os.path.exists("requirements.txt"):
        print("\n2. Installing packages from requirements.txt...")
        run_command(f"{sys.executable} -m pip install -r requirements.txt")
    else:
        print("\n2. Installing core packages directly...")
        
        # Core packages
        core_packages = [
            "numpy>=1.24.0",
            "pandas>=2.0.0",
            "scipy>=1.10.0",
            "scikit-learn>=1.3.0",
            "matplotlib>=3.7.0",
            "seaborn>=0.12.0",
            "plotly>=5.15.0",
            "jupyter>=1.0.0",
            "jupyterlab>=4.0.0",
            "ipywidgets>=8.0.0",
            "bokeh>=3.2.0",
            "altair>=5.0.0"
        ]
        
        for package in core_packages:
            run_command(f"{sys.executable} -m pip install {package}")
    
    # Enable Jupyter extensions
    print("\n3. Enabling Jupyter extensions...")
    run_command("jupyter nbextension enable --py widgetsnbextension")
    run_command("jupyter labextension install @jupyter-widgets/jupyterlab-manager")
    
    # Download NLTK data (common requirement)
    print("\n4. Downloading NLTK data...")
    try:
        import nltk
        nltk.download('punkt')
        nltk.download('stopwords')
        nltk.download('vader_lexicon')
        print("✓ NLTK data downloaded")
    except ImportError:
        print("! NLTK not installed, skipping data download")
    
    # Download spaCy model
    print("\n5. Downloading spaCy model...")
    run_command(f"{sys.executable} -m spacy download en_core_web_sm")
    
    print("\n" + "=" * 50)
    print("Setup complete! 🎉")
    print("\nTo start Jupyter Lab, run:")
    print("jupyter lab")
    print("\nTo start Jupyter Notebook, run:")
    print("jupyter notebook")

if __name__ == "__main__":
    main()
