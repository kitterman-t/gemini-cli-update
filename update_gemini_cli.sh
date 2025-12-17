#!/bin/bash

###############################################################################
# ============================================================================
#                    CROSS-PLATFORM GEMINI CLI UPDATE SCRIPT LAUNCHER
# ============================================================================
# Script Name:        update_gemini_cli.sh
# Description:        Enterprise-grade cross-platform launcher for Gemini CLI 
#                     update script. Automatically detects operating system 
#                     (Windows, macOS, Linux) and executes the appropriate 
#                     platform-specific script with full feature parity.
# Author:             AI Assistant (Enhanced for Tim)
# Organization:       Gemini CLI Update Project
# Date Created:       October 21, 2025
# Last Modified:      December 17, 2025
# Version:            3.1.0
# License:            MIT License
# Repository:        https://github.com/kitterman-t/gemini-cli-update
# Documentation:     https://github.com/kitterman-t/gemini-cli-update/blob/main/README.md
# Support:           https://github.com/kitterman-t/gemini-cli-update/issues
# ============================================================================

# Set error handling (but allow for graceful error handling in functions)
set -eo pipefail

# Get script directory for reliable path resolution
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect operating system (handle unbound variables gracefully)
if [[ "${OSTYPE:-}" == "msys" ]] || [[ "${OSTYPE:-}" == "cygwin" ]] || [[ "${OSTYPE:-}" == "win32" ]] || [[ -n "${WINDIR:-}" ]]; then
    OS="Windows"
elif [[ "${OSTYPE:-}" == "darwin"* ]]; then
    OS="macOS"
elif [[ "${OSTYPE:-}" == "linux-gnu"* ]]; then
    OS="Linux"
else
    OS="Unknown"
fi

echo "============================================================================="
echo "                    CROSS-PLATFORM GEMINI CLI UPDATE SCRIPT"
echo "============================================================================="
echo "Detected OS: $OS"
echo "Script Version: 3.1.0"
echo "Script Directory: $SCRIPT_DIR"
echo "============================================================================="
echo ""

# Function to run PowerShell script on Windows
run_windows_script() {
    echo "Running Windows PowerShell version..."
    echo ""
    
    local ps_script="$SCRIPT_DIR/update_gemini_cli.ps1"
    
    # Check if PowerShell script exists
    if [[ ! -f "$ps_script" ]]; then
        echo "ERROR: PowerShell script not found: $ps_script"
        exit 1
    fi
    
    # Check if PowerShell is available
    if command -v pwsh >/dev/null 2>&1; then
        pwsh -ExecutionPolicy Bypass -File "$ps_script" "$@"
    elif command -v powershell >/dev/null 2>&1; then
        powershell -ExecutionPolicy Bypass -File "$ps_script" "$@"
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
    
    local bash_script="$SCRIPT_DIR/update_gemini_cli_macos.sh"
    
    # Check if the macOS/Linux script exists
    if [[ ! -f "$bash_script" ]]; then
        echo "ERROR: Unix script not found: $bash_script"
        echo "Please ensure update_gemini_cli_macos.sh exists in the script directory."
        exit 1
    fi
    
    # Check if script is executable
    if [[ ! -x "$bash_script" ]]; then
        echo "Making script executable: $bash_script"
        chmod +x "$bash_script"
    fi
    
    # Execute the script
    "$bash_script" "$@"
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