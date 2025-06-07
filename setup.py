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
            "altair>=5.0.0",
            "sympy>=1.12.0",
            "mpmath>=1.3.0"
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
    
    # Install system dependencies (including bc calculator)
    print("\n6. Installing system dependencies...")
    import platform
    system = platform.system().lower()
    
    if system == "linux":
        # Try different package managers
        managers = [
            ("apt-get", "sudo apt-get update && sudo apt-get install -y bc"),
            ("yum", "sudo yum install -y bc"),
            ("dnf", "sudo dnf install -y bc"),
            ("pacman", "sudo pacman -S --noconfirm bc"),
            ("zypper", "sudo zypper install -y bc")
        ]
        
        installed = False
        for manager, command in managers:
            if subprocess.run(f"which {manager}", shell=True, capture_output=True).returncode == 0:
                print(f"Using {manager} to install bc...")
                result = run_command(command)
                if result:
                    installed = True
                    break
        
        if not installed:
            print("! Could not install bc - please install manually: sudo apt-get install bc (or equivalent)")
    
    elif system == "darwin":  # macOS
        # Check if Homebrew is available
        if subprocess.run("which brew", shell=True, capture_output=True).returncode == 0:
            print("Using Homebrew to install bc...")
            run_command("brew install bc")
        else:
            print("! Homebrew not found. Please install bc manually:")
            print("  - Install Homebrew: /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
            print("  - Then run: brew install bc")
    
    elif system == "windows":
        print("! bc calculator is not natively available on Windows.")
        print("Options:")
        print("  - Use Windows Subsystem for Linux (WSL) and install bc there")
        print("  - Use Git Bash (if installed): may include bc")
        print("  - Use the Python sympy library as an alternative")
    
    # Verify bc installation
    if subprocess.run("which bc", shell=True, capture_output=True).returncode == 0:
        print("✓ bc calculator is available")
        # Test bc
        test_result = subprocess.run("echo '2+2' | bc", shell=True, capture_output=True, text=True)
        if test_result.returncode == 0:
            print(f"✓ bc test: 2+2 = {test_result.stdout.strip()}")
    else:
        print("! bc calculator not found in PATH")
    
    print("\n" + "=" * 50)
    print("Setup complete! 🎉")
    print("\nTo start Jupyter Lab, run:")
    print("jupyter lab")
    print("\nTo start Jupyter Notebook, run:")
    print("jupyter notebook")

if __name__ == "__main__":
    main()
