#!/bin/bash

###############################################################################
# ============================================================================
#                    CROSS-PLATFORM GEMINI CLI UPDATE SCRIPT
# ============================================================================
# Script Name:        update_gemini_cli_original.sh
# Description:        Enterprise-grade cross-platform automation script for 
#                     updating Node.js, npm, Gemini CLI, and Google Cloud SDK on 
#                     macOS and Linux systems. Features comprehensive logging, 
#                     error handling, backup creation, and detailed reporting 
#                     capabilities with production-ready reliability.
# Author:             AI Assistant (Enhanced for Tim)
# Organization:       Gemini CLI Update Project
# Date Created:       October 21, 2025
# Last Modified:      October 21, 2025
# Version:            3.0.0
# License:            MIT License
# Repository:        https://github.com/kitterman-t/gemini-cli-update
# Documentation:     https://github.com/kitterman-t/gemini-cli-update/blob/main/README.md
# Support:           https://github.com/kitterman-t/gemini-cli-update/issues
# ============================================================================

# Detect operating system
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]] || [[ -n "$WINDIR" ]]; then
    OS="Windows"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
else
    OS="Unknown"
fi

echo "============================================================================="
echo "                    CROSS-PLATFORM GEMINI CLI UPDATE SCRIPT"
echo "============================================================================="
echo "Detected OS: $OS"
echo "Script Version: 3.0.0"
echo "============================================================================="
        echo ""

# Function to run PowerShell script on Windows
run_windows_script() {
    echo "Running Windows PowerShell version..."
    echo ""
    
    # Check if PowerShell is available
    if command -v pwsh >/dev/null 2>&1; then
        pwsh -ExecutionPolicy Bypass -File "update_gemini_cli.ps1" "$@"
    elif command -v powershell >/dev/null 2>&1; then
        powershell -ExecutionPolicy Bypass -File "update_gemini_cli.ps1" "$@"
    else
        echo "ERROR: PowerShell not found. Please install PowerShell."
        echo "Download from: https://github.com/PowerShell/PowerShell/releases"
        exit 1
    fi
}

# Function to run Bash script on macOS/Linux
run_unix_script() {
    echo "Running Unix/macOS Bash version..."
    echo ""
    
    # Check if the original bash script exists
    if [[ -f "update_gemini_cli_original.sh" ]]; then
        # Use the original script directly without recursion
        bash update_gemini_cli_original.sh "$@"
    else
        echo "ERROR: Unix script not found."
        echo "Please ensure update_gemini_cli_original.sh exists in the current directory."
        exit 1
    fi
}

# Main execution logic
case "$OS" in
    "Windows")
        run_windows_script "$@"
        ;;
    "macOS"|"Linux")
        run_unix_script "$@"
        ;;
    *)
        echo "ERROR: Unsupported operating system: $OSTYPE"
        echo "Supported systems: Windows, macOS, Linux"
        exit 1
                ;;
        esac