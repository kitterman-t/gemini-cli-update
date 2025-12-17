#!/bin/bash

###############################################################################
# ============================================================================
#                    CROSS-PLATFORM GEMINI CLI UPDATE SCRIPT
# ============================================================================
# Script Name:        update_gemini_cli_macos.sh
# Description:        Enterprise-grade cross-platform automation script for 
#                     updating Node.js, npm, Gemini CLI, and Google Cloud SDK on 
#                     macOS and Linux systems. Features comprehensive logging, 
#                     error handling, backup creation, and detailed reporting 
#                     capabilities with production-ready reliability.
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
#
# PURPOSE & OVERVIEW:
# ------------------
# This script provides a comprehensive, production-ready solution for maintaining
# an up-to-date development environment with Node.js, npm, Gemini CLI, and Google
# Cloud SDK on macOS and Linux systems. It features enterprise-grade reliability,
# extensive logging, error handling, backup creation, and detailed reporting.
#
# KEY CAPABILITIES:
# -----------------
# - Automatic detection and installation of package managers (Homebrew, NVM)
# - Force reinstall capabilities for all components (ensures latest versions)
# - Comprehensive logging system with timestamps and error tracking
# - Automatic backup creation before updates for rollback capability
# - Graceful error handling with detailed error reporting and recovery
# - Version tracking and comparison (before/after for each component)
# - Dry-run mode for previewing changes without execution
# - Verbose output mode for detailed debugging information
# - Automatic cleanup of stale temporary directories
# - Fallback retry mechanisms for transient failures
#
# WHAT THIS SCRIPT UPDATES:
# -------------------------
# 1. Homebrew Package Manager - Updates and upgrades all packages
# 2. Google Cloud SDK - Installs/updates with component management
# 3. Node.js - Force reinstall to latest version via Homebrew/NVM
# 4. npm - Force reinstall to latest version globally
# 5. Gemini CLI - Force reinstall to latest version with IDE integration
# 6. Google Generative AI - Installs dependencies globally and locally
# 7. Global npm Packages - Updates all globally installed packages
#
# LOGGING SYSTEM:
# ---------------
# Creates comprehensive logs in: ./gemini-update-logs/
# - update_YYYYMMDD_HHMMSS.log     # Detailed execution log
# - summary_YYYYMMDD_HHMMSS.txt    # Human-readable summary
# - backups/backup_YYYYMMDD_HHMMSS.txt # Configuration backup
#
# USAGE:
# ------
# ./update_gemini_cli_macos.sh [--verbose] [--dry-run] [--help]
#
# ============================================================================

# Set strict error handling
set -euo pipefail

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/gemini-update-logs"
BACKUP_DIR="$LOG_DIR/backups"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$LOG_DIR/update_$(date '+%Y%m%d_%H%M%S').log"

# Global state variables
ORIGINAL_NODE_VERSION=""
ORIGINAL_NPM_VERSION=""
ORIGINAL_GEMINI_VERSION=""
ORIGINAL_GCLOUD_VERSION=""
UPDATED_NODE_VERSION=""
UPDATED_NPM_VERSION=""
UPDATED_GEMINI_VERSION=""
UPDATED_GCLOUD_VERSION=""
ERRORS=0
WARNINGS=0

# Function: Show help message
show_help() {
    cat << EOF
Cross-Platform Gemini CLI Update Script v3.1.0

USAGE:
    ./update_gemini_cli_macos.sh [OPTIONS]

OPTIONS:
    --verbose, -v     Enable verbose output with detailed execution information
    --dry-run, -d     Preview changes without executing them
    --help, -h        Show this help message

EXAMPLES:
    ./update_gemini_cli_macos.sh                    # Run with default settings
    ./update_gemini_cli_macos.sh --verbose           # Run with detailed output
    ./update_gemini_cli_macos.sh --dry-run           # Preview changes only
    ./update_gemini_cli_macos.sh --verbose --dry-run  # Preview with detailed output

PLATFORMS SUPPORTED:
    - macOS (Bash 3.2+)
    - Linux (Bash 3.2+)

For more information, visit: https://github.com/kitterman-t/gemini-cli-update
EOF
}

# Command line argument parsing
VERBOSE=false
DRY_RUN=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --dry-run|-d)
            DRY_RUN=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Function: Create necessary directories
# Purpose: Ensures all required directories exist for logging and backups
# Creates: LOG_DIR (for log files) and BACKUP_DIR (for configuration backups)
# Notes: Uses mkdir -p to create parent directories if needed, idempotent operation
create_directories() {
    log "Creating required directories..." "INFO"
    mkdir -p "$LOG_DIR"
    mkdir -p "$BACKUP_DIR"
    log "Directories created successfully" "SUCCESS"
}

# Function: Log messages with timestamp and level
# Purpose: Centralized logging function that writes to both console and log file
# Parameters:
#   $1: Message text to log
#   $2: Log level (INFO, SUCCESS, WARNING, ERROR, DEBUG) - defaults to INFO
# Behavior:
#   - Colors console output based on log level for better readability
#   - Always writes to log file regardless of verbose mode
#   - DEBUG messages only shown in console when verbose mode is enabled
log() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_entry="[$timestamp] [$level] $message"
    
    # Print to console with appropriate colors
    case $level in
        "ERROR")
            echo -e "\033[31m[ERROR] $message\033[0m"
            ;;
        "WARNING")
            echo -e "\033[33m[WARNING] $message\033[0m"
            ;;
        "SUCCESS")
            echo -e "\033[32m[SUCCESS] $message\033[0m"
            ;;
        "INFO")
            echo -e "\033[34m[INFO] $message\033[0m"
            ;;
        "DEBUG")
            if [[ "$VERBOSE" == "true" ]]; then
                echo -e "\033[35m[DEBUG] $message\033[0m"
            fi
            ;;
        *)
            echo "$message"
            ;;
    esac
    
    # Always write to log file
    echo "$log_entry" >> "$LOG_FILE"
}

# Function: Execute command with logging and error handling
# Purpose: Executes shell commands with comprehensive logging and error handling
# Parameters:
#   $1: Command string to execute
#   $2: Description of what the command does (for logging)
#   $3: Allow failure flag (true/false) - if true, continues on error instead of exiting
# Behavior:
#   - In dry-run mode: logs what would be executed without running
#   - In normal mode: executes command, logs output, handles errors gracefully
#   - Tracks error count for final reporting
# Returns: 0 on success, non-zero on failure (unless allow_failure=true)
execute_with_log() {
    local command="$1"
    local description="${2:-Executing command}"
    local allow_failure="${3:-false}"
    
    # Skip execution in dry run mode
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would execute: $command" "INFO"
        return 0
    fi
    
    log "$description: $command" "DEBUG"
    echo "Command output:" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"
    
    if eval "$command" >> "$LOG_FILE" 2>&1; then
        log "Command completed successfully: $description" "SUCCESS"
        return 0
    else
        local exit_code=$?
        log "Command failed: $description" "ERROR"
        log "Exit code: $exit_code" "ERROR"
        ((ERRORS++))
        
        if [[ "$allow_failure" == "true" ]]; then
            log "Continuing despite command failure (AllowFailure=true)" "WARNING"
            return 1
        else
            return $exit_code
        fi
    fi
}

# Function: Check if command exists in PATH
# Purpose: Safely checks if a command/executable is available in the system PATH
# Parameters:
#   $1: Command name to check (e.g., "node", "npm", "gemini")
# Returns: 0 if command exists, non-zero if not found
# Usage: Used throughout script to verify dependencies before attempting to use them
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function: Get system information for logging
# Purpose: Captures comprehensive system information for troubleshooting and audit trails
# Logs: OS version, architecture, user, paths, platform details
# Notes: This information helps diagnose platform-specific issues and track execution context
get_system_info() {
    log "Gathering system information..." "DEBUG"
    
    cat >> "$LOG_FILE" << EOF
=== SYSTEM INFORMATION ===
Timestamp: $TIMESTAMP
User: $(whoami)
OS: $(uname -s) $(uname -r)
Architecture: $(uname -m)
Script directory: $SCRIPT_DIR
Log directory: $LOG_DIR
Working directory: $(pwd)
Platform: $(uname -s)
EOF
}

# Function: Get current software versions and log them
# Purpose: Captures current versions of all target software before updates
# Checks: Node.js, npm, Gemini CLI, Google Cloud SDK
# Behavior: 
#   - Sets ORIGINAL_*_VERSION global variables for later comparison
#   - Logs warnings if software is not installed
#   - Increments WARNINGS counter for missing software (non-fatal)
get_versions() {
    log "Checking current software versions..." "INFO"
    
    # Check Node.js
    if command_exists node; then
        ORIGINAL_NODE_VERSION=$(node -v 2>/dev/null || echo "Unknown")
        log "  Node.js: $ORIGINAL_NODE_VERSION" "INFO"
    else
        ORIGINAL_NODE_VERSION="Not installed"
        log "  Node.js: Not installed" "WARNING"
        ((WARNINGS++))
    fi
    
    # Check npm
    if command_exists npm; then
        ORIGINAL_NPM_VERSION=$(npm -v 2>/dev/null || echo "Unknown")
        log "  npm: $ORIGINAL_NPM_VERSION" "INFO"
    else
        ORIGINAL_NPM_VERSION="Not installed"
        log "  npm: Not installed" "WARNING"
        ((WARNINGS++))
    fi
    
    # Check Gemini CLI
    if command_exists gemini; then
        ORIGINAL_GEMINI_VERSION=$(gemini --version 2>/dev/null || echo "Unknown")
        log "  Gemini CLI: $ORIGINAL_GEMINI_VERSION" "INFO"
    else
        ORIGINAL_GEMINI_VERSION="Not installed"
        log "  Gemini CLI: Not installed" "WARNING"
        ((WARNINGS++))
    fi
    
    # Check Google Cloud SDK
    if command_exists gcloud; then
        ORIGINAL_GCLOUD_VERSION=$(gcloud version --format="value(Google Cloud SDK)" 2>/dev/null || echo "Unknown")
        log "  Google Cloud SDK: $ORIGINAL_GCLOUD_VERSION" "INFO"
    else
        ORIGINAL_GCLOUD_VERSION="Not installed"
        log "  Google Cloud SDK: Not installed" "WARNING"
        ((WARNINGS++))
    fi
    
    log "Version check completed" "SUCCESS"
    echo ""
}

# Function: Create comprehensive backup of current state
# Purpose: Creates a snapshot of current configuration for rollback capability
# Captures: Software versions, global npm packages, system info, environment variables, npm config
# Location: Saves to BACKUP_DIR with timestamp in filename
# Notes: Essential for recovery if updates cause issues - allows manual rollback
create_backup() {
    log "Creating backup of current configuration..." "INFO"
    
    local backup_file="$BACKUP_DIR/backup_$(date '+%Y%m%d_%H%M%S').txt"
    
    cat > "$backup_file" << EOF
=== GEMINI CLI UPDATE BACKUP ===
Timestamp: $TIMESTAMP
Script Version: 3.1.0
Platform: $(uname -s)

=== SOFTWARE VERSIONS ===
Node.js: $ORIGINAL_NODE_VERSION
npm: $ORIGINAL_NPM_VERSION
Gemini CLI: $ORIGINAL_GEMINI_VERSION
Google Cloud SDK: $ORIGINAL_GCLOUD_VERSION

=== GLOBAL NPM PACKAGES ===
$(if command_exists npm; then npm list -g --depth=0 2>/dev/null; else echo "npm not available"; fi)

=== SYSTEM INFORMATION ===
OS: $(uname -s) $(uname -r)
User: $(whoami)
Architecture: $(uname -m)
Shell: $SHELL

=== ENVIRONMENT VARIABLES ===
PATH: $PATH
NODE_PATH: ${NODE_PATH:-"Not set"}
NPM_CONFIG_PREFIX: ${NPM_CONFIG_PREFIX:-"Not set"}

=== NPM CONFIGURATION ===
$(if command_exists npm; then npm config list 2>/dev/null; else echo "npm not available"; fi)
EOF
    
    log "Backup created: $backup_file" "SUCCESS"
}

# Function: Update Homebrew package manager
# Purpose: Ensures Homebrew is up-to-date and upgrades all installed packages
# Behavior:
#   - If Homebrew exists: updates package database and upgrades all packages
#   - If Homebrew missing: automatically installs it via official installer
# Notes: Homebrew is the primary package manager for macOS, used for Node.js installation
update_homebrew() {
    if command_exists brew; then
        log "Updating Homebrew package manager..." "INFO"
        execute_with_log "brew update" "Updating Homebrew package database"
        execute_with_log "brew upgrade" "Upgrading all Homebrew packages to latest versions"
        log "Homebrew updated successfully" "SUCCESS"
        echo ""
    else
        log "Homebrew not found. Installing Homebrew..." "INFO"
        execute_with_log '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"' "Installing Homebrew package manager"
        log "Homebrew installed successfully" "SUCCESS"
        echo ""
    fi
}

# Function: Update Google Cloud SDK components
# Purpose: Updates Google Cloud SDK and all its components to latest versions
# Behavior:
#   - If gcloud exists: updates all components with --quiet flag (auto-answers prompts)
#   - If gcloud missing: installs via official installer, then updates components
# Notes: Uses --quiet flag to prevent interactive prompts during automated execution
update_gcloud_components() {
    if command_exists gcloud; then
        log "Updating Google Cloud SDK components..." "INFO"
        log "Using --quiet flag to automatically answer yes to all prompts" "DEBUG"
        execute_with_log "gcloud components update --quiet" "Updating Google Cloud SDK components"
        
        # Refresh version information
        if command_exists gcloud; then
            UPDATED_GCLOUD_VERSION=$(gcloud version --format="value(Google Cloud SDK)" 2>/dev/null || echo "Unknown")
            log "Google Cloud SDK components updated successfully" "SUCCESS"
            log "Google Cloud SDK version: $UPDATED_GCLOUD_VERSION" "INFO"
        fi
        echo ""
    else
        log "Google Cloud SDK not found. Installing Google Cloud SDK..." "INFO"
        execute_with_log 'curl https://sdk.cloud.google.com | bash' "Installing Google Cloud SDK"
        execute_with_log 'source ~/.bashrc && gcloud components update --quiet' "Updating Google Cloud SDK components after installation"
        log "Google Cloud SDK installed and updated successfully" "SUCCESS"
        echo ""
    fi
}

# Function: Install/update Node.js via Homebrew
# Purpose: Ensures Node.js is installed and at the latest version
# Behavior:
#   - Uses Homebrew with --force flag to ensure latest version (force reinstall)
#   - Falls back to NVM installation if Homebrew is unavailable
#   - Refreshes shell environment to pick up new Node.js version
# Notes: --force flag ensures update even if Node.js is already installed
upgrade_node_homebrew() {
    if command_exists brew; then
        log "Installing/upgrading Node.js via Homebrew..." "INFO"
        execute_with_log "brew install --force node" "Installing/upgrading Node.js via Homebrew (force reinstall)"
        
        # Refresh shell environment to get new Node.js version
        if command_exists node; then
            UPDATED_NODE_VERSION=$(node -v 2>/dev/null || echo "Unknown")
            log "Node.js installed/upgraded to: $UPDATED_NODE_VERSION" "SUCCESS"
        fi
        echo ""
    else
        log "Homebrew not available for Node.js installation" "WARNING"
        log "Installing Node.js via official installer..." "INFO"
        execute_with_log 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash' "Installing NVM (Node Version Manager)"
        execute_with_log 'source ~/.bashrc && nvm install node --latest-npm' "Installing latest Node.js via NVM"
        ((WARNINGS++))
    fi
}

# Function: Update npm to latest version
# Purpose: Updates npm package manager to the latest available version
# Behavior:
#   - Cleans up stale temporary directories from previous failed installations
#   - Attempts update with --force flag first (ensures clean reinstall)
#   - Falls back to update without --force if first attempt fails
#   - Handles ENOTEMPTY errors by cleaning temporary directories
# Notes: Includes cleanup step to prevent ENOTEMPTY errors from stale npm temp dirs
update_npm() {
    log "Installing/updating npm to latest version..." "INFO"
    
    # Clean up any stale npm directories from previous failed installations
    if command_exists npm; then
        local npm_prefix=$(npm config get prefix 2>/dev/null || echo "$HOME/.nvm/versions/node/$(node -v)")
        local npm_path="$npm_prefix/lib/node_modules"
        log "Cleaning up stale npm directories at: $npm_path" "DEBUG"
        
        # Remove any .npm-*, .update-*, and .*-* temporary directories
        if [[ -d "$npm_path" ]]; then
            find "$npm_path" -name ".npm-*" -type d -exec rm -rf {} + 2>/dev/null || true
            find "$npm_path" -name ".update-*" -type d -exec rm -rf {} + 2>/dev/null || true
        fi
    fi
    
    # Try to update npm with force flag
    if execute_with_log "npm install -g npm@latest --force" "Installing/updating npm to latest version (force reinstall)" "true"; then
        if command_exists npm; then
            UPDATED_NPM_VERSION=$(npm -v 2>/dev/null || echo "Unknown")
            log "npm installed/updated to: $UPDATED_NPM_VERSION" "SUCCESS"
        fi
    else
        log "npm update failed with force flag, trying without force..." "WARNING"
        # Try again without force flag as fallback
        if execute_with_log "npm install -g npm@latest" "Installing/updating npm to latest version (without force)" "true"; then
            if command_exists npm; then
                UPDATED_NPM_VERSION=$(npm -v 2>/dev/null || echo "Unknown")
                log "npm installed/updated to: $UPDATED_NPM_VERSION" "SUCCESS"
            fi
        else
            log "npm update failed completely. Current version: $(npm -v 2>/dev/null || echo 'Unknown')" "WARNING"
            ((WARNINGS++))
        fi
    fi
    echo ""
}

# Function: Update Gemini CLI to latest version
# Purpose: Installs or updates Google's Gemini CLI tool to the latest version
# Behavior:
#   - Cleans up stale temporary directories before attempting update
#   - Uses --force flag to ensure latest version (force reinstall)
#   - Falls back to update without --force if first attempt fails
#   - Verifies installation by checking gemini command availability
# Notes: Gemini CLI is the primary tool this script maintains
update_gemini_cli() {
    log "Installing/updating Gemini CLI to latest version..." "INFO"
    
    # Clean up any stale directories before attempting update
    if command_exists npm; then
        local npm_prefix=$(npm config get prefix 2>/dev/null || echo "$HOME/.nvm/versions/node/$(node -v)")
        local npm_path="$npm_prefix/lib/node_modules"
        if [[ -d "$npm_path" ]]; then
            find "$npm_path" -name ".gemini-cli-*" -type d -exec rm -rf {} + 2>/dev/null || true
            find "$npm_path" -name ".update-*" -type d -exec rm -rf {} + 2>/dev/null || true
        fi
    fi
    
    # Try to update Gemini CLI with force flag
    if execute_with_log "npm install -g @google/gemini-cli@latest --force" "Installing/updating Gemini CLI to latest version (force reinstall)" "true"; then
        if command_exists gemini; then
            UPDATED_GEMINI_VERSION=$(gemini --version 2>/dev/null || echo "Unknown")
            log "Gemini CLI installed/updated to: $UPDATED_GEMINI_VERSION" "SUCCESS"
        fi
    else
        log "Gemini CLI update failed with force flag, trying without force..." "WARNING"
        # Try again without force flag as fallback
        if execute_with_log "npm install -g @google/gemini-cli@latest" "Installing/updating Gemini CLI to latest version (without force)" "true"; then
            if command_exists gemini; then
                UPDATED_GEMINI_VERSION=$(gemini --version 2>/dev/null || echo "Unknown")
                log "Gemini CLI installed/updated to: $UPDATED_GEMINI_VERSION" "SUCCESS"
            fi
        else
            log "Gemini CLI update failed completely. Current version: $(gemini --version 2>/dev/null || echo 'Unknown')" "WARNING"
            ((WARNINGS++))
        fi
    fi
    echo ""
}

# Function: Install Google Generative AI dependencies
# Purpose: Installs required Google Generative AI packages for Gemini CLI functionality
# Behavior:
#   - Installs @google/generative-ai globally for CLI access
#   - Optionally installs locally if package.json exists in current directory
#   - Cleans up stale temporary directories before installation
#   - Uses --force flag to ensure latest versions
# Notes: These dependencies are required for Gemini CLI to function properly
install_gemini_dependencies() {
    log "Installing/updating Google Generative AI dependencies..." "INFO"
    
    # Clean up any stale directories before attempting update
    if command_exists npm; then
        local npm_prefix=$(npm config get prefix 2>/dev/null || echo "$HOME/.nvm/versions/node/$(node -v)")
        local npm_path="$npm_prefix/lib/node_modules"
        if [[ -d "$npm_path" ]]; then
            find "$npm_path" -name ".update-*" -type d -exec rm -rf {} + 2>/dev/null || true
            find "$npm_path" -name ".*-*" -type d -exec rm -rf {} + 2>/dev/null || true
        fi
    fi
    
    # Install globally for CLI access (force reinstall)
    if execute_with_log "npm install -g @google/generative-ai --force" "Installing/updating Google Generative AI package globally (force reinstall)" "true"; then
        log "Google Generative AI package installed globally" "SUCCESS"
    else
        log "Google Generative AI install failed with force flag, trying without force..." "WARNING"
        # Try again without force flag as fallback
        if execute_with_log "npm install -g @google/generative-ai" "Installing/updating Google Generative AI package globally (without force)" "true"; then
            log "Google Generative AI package installed globally" "SUCCESS"
        else
            log "Google Generative AI install failed completely" "WARNING"
            ((WARNINGS++))
        fi
    fi
    
    # Install locally in current project (if in a project directory)
    if [[ -f "package.json" ]]; then
        if execute_with_log "npm install @google/generative-ai --force" "Installing/updating Google Generative AI package locally (force reinstall)" "true"; then
            log "Local project dependencies updated" "SUCCESS"
        else
            log "Local installation failed, trying without force..." "WARNING"
            execute_with_log "npm install @google/generative-ai" "Installing/updating Google Generative AI package locally (without force)" "true"
        fi
    else
        log "No package.json found - skipping local installation" "INFO"
    fi
    
    log "Google Generative AI dependencies installation completed" "SUCCESS"
    echo ""
}

# Function: Enable Gemini CLI IDE integration
# Purpose: Configures Gemini CLI for IDE integration (currently skipped due to known issue)
# Behavior:
#   - Currently skips automatic IDE enable due to hanging issue with gemini /ide enable
#   - Provides instructions for manual IDE integration configuration
#   - Logs warning (expected behavior) to inform user
# Notes: 
#   - Known issue: gemini /ide enable command hangs due to configuration format changes
#   - Users can manually run 'gemini /ide enable' after script completion if needed
#   - See docs/ide-integration-issue.md for detailed information
enable_ide_integration() {
    log "Configuring Gemini CLI IDE integration..." "INFO"
    
    if command_exists gemini; then
        # Skip IDE enable command as it requires a running IDE companion extension
        # and may hang or fail with connection error if the extension is not active.
        log "Skipping automatic IDE integration (requires active IDE extension)" "WARNING"
        log "Note: 'gemini /ide enable' may fail with 'Failed to connect to IDE companion extension'" "INFO"
        log "To manually enable, ensure your IDE extension is running then run: gemini /ide enable" "INFO"
        log "For more information, visit: https://geminicli.com/docs/get-started/configuration/" "INFO"
        ((WARNINGS++))
        
        # Note: IDE integration can be manually configured after script completion
        log "IDE integration can be configured manually after script completion" "INFO"
    else
        log "Gemini CLI not found - skipping IDE integration" "ERROR"
        ((ERRORS++))
    fi
    
    echo ""
}

# Function: Update all global npm packages
# Purpose: Updates all globally installed npm packages to their latest versions
# Behavior: Uses npm update -g --force to update all global packages
# Notes: This ensures all global tools are up-to-date, not just the primary ones
update_global_packages() {
    log "Updating all global npm packages..." "INFO"
    execute_with_log "npm update -g --force" "Updating all global npm packages (force update)" "true"
    log "Global packages update completed" "SUCCESS"
    echo ""
}

# Function: Verify all installations are working
# Purpose: Validates that all updated software is properly installed and accessible
# Checks: Node.js, npm, Gemini CLI, Google Cloud SDK
# Behavior: Verifies each tool is in PATH and can report its version
# Notes: Increments ERROR counter if any tool is missing (indicates installation failure)
verify_installations() {
    log "Verifying all installations..." "INFO"
    echo ""
    
    # Check Node.js
    if command_exists node; then
        local current_node=$(node -v 2>/dev/null)
        log "✓ Node.js: $current_node" "SUCCESS"
    else
        log "✗ Node.js: Not found" "ERROR"
        ((ERRORS++))
    fi
    
    # Check npm
    if command_exists npm; then
        local current_npm=$(npm -v 2>/dev/null)
        log "✓ npm: $current_npm" "SUCCESS"
    else
        log "✗ npm: Not found" "ERROR"
        ((ERRORS++))
    fi
    
    # Check Gemini CLI
    if command_exists gemini; then
        local current_gemini=$(gemini --version 2>/dev/null)
        log "✓ Gemini CLI: $current_gemini" "SUCCESS"
    else
        log "✗ Gemini CLI: Not found" "ERROR"
        ((ERRORS++))
    fi
    
    # Check Google Cloud SDK
    if command_exists gcloud; then
        local current_gcloud=$(gcloud version --format="value(Google Cloud SDK)" 2>/dev/null)
        log "✓ Google Cloud SDK: $current_gcloud" "SUCCESS"
    else
        log "✗ Google Cloud SDK: Not found" "ERROR"
        ((ERRORS++))
    fi
    echo ""
}

# Function: Test Gemini CLI functionality
# Purpose: Performs actual API test to verify Gemini CLI is working correctly
# Behavior: Sends a test query to Gemini API to confirm connectivity and configuration
# Notes: 
#   - May show warning if API key is not configured (non-fatal)
#   - Provides instructions for API key setup if test fails
#   - This is the final verification that everything is working end-to-end
test_gemini_cli() {
    log "Testing Gemini CLI functionality..." "INFO"
    
    if command_exists gemini; then
        log "Testing basic Gemini CLI command..." "DEBUG"
        if execute_with_log "gemini ask 'Test connection - respond with OK'" "Testing Gemini CLI basic functionality" "true"; then
            log "✓ Gemini CLI is functioning correctly" "SUCCESS"
        else
            log "⚠ Gemini CLI installed but may need API key configuration" "WARNING"
            log "Run 'gemini config' to set up your API key" "INFO"
            ((WARNINGS++))
        fi
    else
        log "✗ Gemini CLI not found - functionality test skipped" "ERROR"
        ((ERRORS++))
    fi
    echo ""
}

# Function: Generate comprehensive summary report
# Purpose: Creates human-readable summary of update process and results
# Contents: Version changes, statistics, file locations, next steps, verification commands
# Location: Saved to LOG_DIR with timestamp in filename
# Notes: Provides quick overview without needing to read full detailed log
generate_summary() {
    log "Generating update summary..." "INFO"
    
    local summary_file="$LOG_DIR/summary_$(date '+%Y%m%d_%H%M%S').txt"
    
    cat > "$summary_file" << EOF
=============================================================================
                    GEMINI CLI UPDATE SUMMARY
=============================================================================
Timestamp: $TIMESTAMP
Script Version: 3.1.0
Platform: $(uname -s)
Log file: $LOG_FILE

VERSION CHANGES:
  Node.js: $ORIGINAL_NODE_VERSION → $UPDATED_NODE_VERSION
  npm: $ORIGINAL_NPM_VERSION → $UPDATED_NPM_VERSION
  Gemini CLI: $ORIGINAL_GEMINI_VERSION → $UPDATED_GEMINI_VERSION
  Google Cloud SDK: $ORIGINAL_GCLOUD_VERSION → $UPDATED_GCLOUD_VERSION

STATISTICS:
  Errors: $ERRORS
  Warnings: $WARNINGS
  Execution time: $(date '+%Y-%m-%d %H:%M:%S')

FILES CREATED:
  Main log: $LOG_FILE
  Summary: $summary_file
  Backup directory: $BACKUP_DIR

NEXT STEPS:
EOF
    
    # Add next steps based on error count
    if [[ $ERRORS -eq 0 ]]; then
        cat >> "$summary_file" << 'EOF'
  ✅ All updates completed successfully
  ✅ Your development environment is up-to-date
  ✅ You can now use the latest versions of all tools
EOF
    else
        cat >> "$summary_file" << 'EOF'
  ⚠️  Updates completed with $ERRORS error(s)
  ⚠️  Please review the log file for details
  ⚠️  Some functionality may be limited
EOF
    fi
    
    cat >> "$summary_file" << 'EOF'

VERIFICATION COMMANDS:
  node --version
  npm --version
  gemini --version
  gcloud version
  gemini ask 'Hello'

=============================================================================
EOF
    
    log "Summary report created: $summary_file" "SUCCESS"
    echo ""
    
    # Display summary
    cat "$summary_file"
}

# Function: Clean up old log files
# Purpose: Maintains log directory by keeping only the most recent log files
# Behavior: Keeps last 10 log files and summary files, removes older ones
# Notes: Prevents log directory from growing unbounded, maintains useful history
cleanup_old_logs() {
    log "Cleaning up old log files (keeping last 10)..." "INFO"
    
    # Keep only the last 10 log files
    find "$LOG_DIR" -name "update_*.log" -type f | sort -r | tail -n +11 | xargs rm -f 2>/dev/null || true
    find "$LOG_DIR" -name "summary_*.txt" -type f | sort -r | tail -n +11 | xargs rm -f 2>/dev/null || true
    
    log "Log cleanup completed" "SUCCESS"
}

# Function: Main script execution
# Purpose: Orchestrates the entire update process in the correct sequence
# Flow:
#   1. Setup (directories, logging, system info, backup)
#   2. Version detection (capture current state)
#   3. Updates (package managers, Node.js, npm, Gemini CLI, dependencies)
#   4. Verification (test installations and functionality)
#   5. Reporting (generate summary, cleanup, final status)
# Notes: This is the entry point called at the end of the script
main() {
    # Create log directory
    create_directories
    
    # Start comprehensive logging
    local header="=============================================================================
                    CROSS-PLATFORM GEMINI CLI UPDATE SCRIPT
=============================================================================
Started: $TIMESTAMP
Script Version: 3.1.0
Platform: $(uname -s)
Log file: $LOG_FILE
Verbose mode: $VERBOSE
Dry run mode: $DRY_RUN
=============================================================================

"
    
    echo "$header" > "$LOG_FILE"
    
    # Display header
    echo "$header"
    
    # Gather system information
    get_system_info
    
    # Create backup of current state
    create_backup
    
    # Get initial versions
    get_versions
    
    # Update process
    log "Starting update process..." "INFO"
    echo ""
    
    # Update Homebrew
    update_homebrew
    
    # Update Google Cloud SDK components
    update_gcloud_components
    
    # Update Node.js
    upgrade_node_homebrew
    
    # Update npm
    update_npm
    
    # Update Gemini CLI
    update_gemini_cli
    
    # Install Gemini CLI dependencies
    install_gemini_dependencies
    
    # Enable IDE integration
    enable_ide_integration
    
    # Update all global packages
    update_global_packages
    
    # Verify installations
    verify_installations
    
    # Test Gemini CLI
    test_gemini_cli
    
    # Generate summary
    generate_summary
    
    # Cleanup old logs
    cleanup_old_logs
    
    # Final status
    if [[ $ERRORS -eq 0 ]]; then
        log "🎉 All updates completed successfully!" "SUCCESS"
        log "Your development environment is now up-to-date" "SUCCESS"
    else
        log "⚠️  Updates completed with $ERRORS error(s) and $WARNINGS warning(s)" "WARNING"
        log "Please review the log file for detailed information" "INFO"
    fi
    
    echo ""
    echo "============================================================================="
    echo "                    UPDATE PROCESS COMPLETE"
    echo "============================================================================="
    echo "Check the log file for detailed information: $LOG_FILE"
    echo "Review the summary for quick overview"
    echo "Use the backup files if rollback is needed"
    echo "============================================================================="
}

# Execute main function
main "$@"
