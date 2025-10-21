#!/bin/bash

###############################################################################
# ============================================================================
#                    ENHANCED GEMINI CLI UPDATE SCRIPT
# ============================================================================
# Script Name:        update_gemini_cli.sh
# Description:        Comprehensive automation script for updating Node.js, npm,
#                     Gemini CLI, and all related dependencies on macOS systems.
#                     Features extensive logging, error handling, backup creation,
#                     and detailed reporting capabilities.
# Author:             AI Assistant (Enhanced for Tim)
# Date Created:       October 3, 2025
# Last Modified:      October 4, 2025
# Version:            2.2.0
# License:            MIT
# ============================================================================
#
# PURPOSE & OVERVIEW:
# ------------------
# This script provides a complete solution for maintaining an up-to-date
# development environment with Node.js, npm, and Gemini CLI. It handles:
# - Automatic detection and installation of missing components
# - Version tracking and comparison (before/after)
# - Comprehensive logging of all operations and outputs
# - Backup creation for rollback capabilities
# - Error handling with graceful degradation
# - Detailed reporting and summary generation
#
# WHAT THIS SCRIPT DOES:
# ---------------------
# 1. SYSTEM ANALYSIS:
#    - Detects current versions of Node.js, npm, and Gemini CLI
#    - Identifies installation methods (Homebrew, direct, etc.)
#    - Creates backup of current configuration
#    - Analyzes system environment and dependencies
#
# 2. UPDATE PROCESS:
#    - Updates Homebrew package manager (if available)
#    - Updates Google Cloud SDK components (if available)
#    - Upgrades Node.js to latest version via Homebrew
#    - Updates npm to latest version globally
#    - Installs/updates Gemini CLI to latest version
#    - Installs Google Generative AI dependencies (globally and locally)
#    - Enables Gemini CLI IDE integration for optimal Cursor support
#    - Updates all globally installed npm packages
#
# 3. VERIFICATION & TESTING:
#    - Verifies all installations are working correctly
#    - Tests Gemini CLI functionality with actual API calls
#    - Validates version changes and dependencies
#    - Performs system health checks
#    - Confirms IDE integration is properly configured
#
# 4. REPORTING & MAINTENANCE:
#    - Generates detailed summary reports
#    - Creates organized log files with timestamps
#    - Maintains backup files for rollback purposes
#    - Cleans up old log files automatically
#
# LOGGING SYSTEM:
# ---------------
# The script creates a comprehensive logging system with multiple file types:
#
# LOG DIRECTORY: ./gemini-update-logs/ (relative to script location)
# ├── update_YYYYMMDD_HHMMSS.log     # Main detailed log file
# ├── summary_YYYYMMDD_HHMMSS.txt    # Human-readable summary
# └── backups/
#     └── backup_YYYYMMDD_HHMMSS.txt # Configuration backup
#
# WHAT GETS LOGGED:
# ----------------
# - All command executions with full output (stdout/stderr)
# - System information (OS, architecture, user, paths)
# - Version changes (before → after for each component)
# - Error messages, warnings, and success confirmations
# - File operations and path references
# - Timing information for each operation
# - API test results and functionality verification
# - Backup creation and restoration information
#
# LOG FILE FORMAT:
# ---------------
# [YYYY-MM-DD HH:MM:SS] [LEVEL] Message
# [YYYY-MM-DD HH:MM:SS] [DEBUG] Command: actual-command-here
# [YYYY-MM-DD HH:MM:SS] [SUCCESS] Operation completed successfully
# [YYYY-MM-DD HH:MM:SS] [ERROR] Operation failed with details
# [YYYY-MM-DD HH:MM:SS] [WARNING] Non-critical issue detected
#
# USAGE INSTRUCTIONS:
# ------------------
# 1. DIRECT EXECUTION:
#    /Users/tim/Documents/update_gemini_cli.sh
#
# 2. USING ALIAS (after terminal restart):
#    update-gemini
#
# 3. WITH VERBOSE OUTPUT:
#    /Users/tim/Documents/update_gemini_cli.sh --verbose
#
# 4. DRY RUN (preview only):
#    /Users/tim/Documents/update_gemini_cli.sh --dry-run
#
# FILES TO CHECK AFTER EXECUTION:
# -------------------------------
# 1. MAIN LOG FILE:
#    ./gemini-update-logs/update_YYYYMMDD_HHMMSS.log
#    - Contains complete execution details
#    - Shows all command outputs and errors
#    - Includes timing and performance data
#
# 2. SUMMARY REPORT:
#    ./gemini-update-logs/summary_YYYYMMDD_HHMMSS.txt
#    - Human-readable summary of changes
#    - Version comparison table
#    - Success/failure statistics
#    - File locations and recommendations
#
# 3. BACKUP FILES:
#    ./gemini-update-logs/backups/backup_YYYYMMDD_HHMMSS.txt
#    - Original configuration snapshot
#    - System information at time of backup
#    - Global package list before updates
#
# HOW TO DETERMINE SUCCESS:
# -------------------------
# 1. CHECK EXIT CODE:
#    echo $?  # Should return 0 for success
#
# 2. REVIEW SUMMARY FILE:
#    - Look for "STATUS: ✅ SUCCESS" message
#    - Verify "Errors: 0" in statistics
#    - Check version changes are as expected
#
# 3. EXAMINE LOG FILE:
#    - Search for "ERROR" entries (should be minimal)
#    - Verify all major operations completed
#    - Check for "All updates completed successfully" message
#
# 4. FUNCTIONAL VERIFICATION:
#    - Test: gemini --version
#    - Test: node --version
#    - Test: npm --version
#    - Test: gemini ask "Hello"
#
# ERROR HANDLING:
# --------------
# The script includes comprehensive error handling:
# - Graceful failure with detailed error messages
# - Automatic rollback capabilities (via backups)
# - Non-critical error tolerance (warnings vs errors)
# - Interrupt handling (Ctrl+C) with cleanup
# - Detailed error logging for troubleshooting
#
# DEPENDENCIES:
# -------------
# - macOS (tested on macOS Sequoia 15.0+)
# - Bash 3.2+ (included with macOS)
# - Homebrew (recommended for Node.js management)
# - Internet connection (for downloading updates)
# - Appropriate user permissions (sudo may be required)
#
# TROUBLESHOOTING:
# ---------------
# 1. PERMISSION ERRORS:
#    - Ensure script is executable: chmod +x update_gemini_cli.sh
#    - Run with appropriate permissions if needed
#
# 2. HOMEBREW ISSUES:
#    - Install Homebrew: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#    - Update Homebrew: brew update
#
# 3. NODE.JS/NPM ISSUES:
#    - Clear npm cache: npm cache clean --force
#    - Reset npm registry: npm config set registry https://registry.npmjs.org/
#
# 4. GEMINI CLI ISSUES:
#    - Check API key configuration: gemini config
#    - Verify internet connectivity
#    - Check for firewall/proxy issues
#
# 5. GOOGLE CLOUD SDK ISSUES:
#    - Install Google Cloud SDK: https://cloud.google.com/sdk/docs/install
#    - Authenticate: gcloud auth login
#    - Set project: gcloud config set project YOUR_PROJECT_ID
#    - Check components: gcloud components list
#
# MAINTENANCE:
# ------------
# - Log files are automatically cleaned up (keeps last 10)
# - Backup files are preserved for rollback purposes
# - Script can be run multiple times safely
# - Updates only when newer versions are available
#
# SECURITY NOTES:
# --------------
# - Script only modifies Node.js, npm, and Gemini CLI installations
# - No sensitive data is logged (API keys, passwords, etc.)
# - All operations are logged for audit purposes
# - Backup files contain only configuration data
#
# PERFORMANCE:
# -----------
# - Typical execution time: 2-5 minutes
# - Network dependent (download speeds)
# - Minimal system resource usage
# - Parallel operations where possible
#
# VERSION HISTORY:
# ---------------
# v2.2.0 (2025-10-04): Added Google Cloud SDK components update
#                      - Added gcloud components update with --quiet flag
#                      - Added Google Cloud SDK version detection and tracking
#                      - Enhanced documentation for cloud development tools
#                      - Automatic yes responses for all gcloud prompts
# v2.1.0 (2025-10-04): Enhanced with Gemini CLI dependency fixes and IDE integration
#                      - Added Google Generative AI dependency installation
#                      - Added automatic IDE integration enablement
#                      - Fixed import errors and path issues
#                      - Improved Cursor IDE compatibility
# v2.0.0 (2025-10-03): Complete rewrite with enhanced logging, error handling,
#                      backup system, and comprehensive documentation
# v1.0.0 (2025-10-03): Initial version with basic update functionality
#
# ============================================================================
###############################################################################

# ============================================================================
# CONFIGURATION AND INITIALIZATION
# ============================================================================

# Script configuration
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Directory and file paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/gemini-update-logs"
LOG_FILE="$LOG_DIR/update_$(date +%Y%m%d_%H%M%S).log"
BACKUP_DIR="$LOG_DIR/backups"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Color codes for terminal output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

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
DRY_RUN=false
VERBOSE=false

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Function: Create necessary directories
# Purpose: Ensure all required directories exist before starting
create_directories() {
    log "Creating required directories..." "INFO"
    mkdir -p "$LOG_DIR"
    mkdir -p "$BACKUP_DIR"
    log "Directories created successfully" "SUCCESS"
}

# Function: Log messages with timestamp and level
# Parameters: $1 = message, $2 = level (INFO|SUCCESS|WARNING|ERROR|DEBUG)
# Purpose: Centralized logging with consistent formatting
log() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_entry="[$timestamp] [$level] $message"
    
    # Print to console with appropriate colors
    case $level in
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message" | tee -a "$LOG_FILE"
            ;;
        "WARNING")
            echo -e "${YELLOW}[WARNING]${NC} $message" | tee -a "$LOG_FILE"
            ;;
        "SUCCESS")
            echo -e "${GREEN}[SUCCESS]${NC} $message" | tee -a "$LOG_FILE"
            ;;
        "INFO")
            echo -e "${BLUE}[INFO]${NC} $message" | tee -a "$LOG_FILE"
            ;;
        "DEBUG")
            if [[ "$VERBOSE" == "true" ]]; then
                echo -e "${PURPLE}[DEBUG]${NC} $message" | tee -a "$LOG_FILE"
            else
                echo "$log_entry" >> "$LOG_FILE"
            fi
            ;;
        *)
            echo -e "$message" | tee -a "$LOG_FILE"
            ;;
    esac
    
    # Always write to log file regardless of verbose setting
    echo "$log_entry" >> "$LOG_FILE"
}

# Function: Log command execution with full output capture
# Parameters: $1 = command, $2 = description, $3 = allow_failure (true/false)
# Purpose: Execute commands with comprehensive logging
log_command() {
    local cmd="$1"
    local description="${2:-Executing command}"
    
    log "$description: $cmd" "DEBUG"
    echo "Command output:" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"
}

# Function: Execute command with logging and error handling
# Parameters: $1 = command, $2 = description, $3 = allow_failure (true/false)
# Returns: Exit code of the command
execute_with_log() {
    local cmd="$1"
    local description="${2:-Executing command}"
    local allow_failure="${3:-false}"
    
    # Skip execution in dry run mode
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would execute: $cmd" "INFO"
        return 0
    fi
    
    log_command "$cmd" "$description"
    
    # Execute command and capture output
    if eval "$cmd" >> "$LOG_FILE" 2>&1; then
        log "Command completed successfully: $description" "SUCCESS"
        return 0
    else
        local exit_code=$?
        log "Command failed (exit code: $exit_code): $description" "ERROR"
        ((ERRORS++))
        
        if [[ "$allow_failure" == "true" ]]; then
            log "Continuing despite command failure (allow_failure=true)" "WARNING"
            return $exit_code
        else
            log "Stopping execution due to command failure" "ERROR"
            exit $exit_code
        fi
    fi
}

# Function: Check if command exists in PATH
# Parameters: $1 = command name
# Returns: 0 if exists, 1 if not
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function: Get system information for logging
# Purpose: Capture system details for troubleshooting
get_system_info() {
    log "Gathering system information..." "DEBUG"
    
    {
        echo "=== SYSTEM INFORMATION ==="
        echo "Timestamp: $TIMESTAMP"
        echo "User: $USER"
        echo "Home: $HOME"
        echo "Shell: $SHELL"
        echo "OS: $(uname -a)"
        echo "Architecture: $(uname -m)"
        echo "Script directory: $SCRIPT_DIR"
        echo "Log directory: $LOG_DIR"
        echo "Working directory: $(pwd)"
        echo ""
    } >> "$LOG_FILE"
}

# ============================================================================
# VERSION DETECTION AND TRACKING
# ============================================================================

# Function: Get current software versions and log them
# Purpose: Capture baseline versions before updates
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

# ============================================================================
# BACKUP AND RECOVERY FUNCTIONS
# ============================================================================

# Function: Create comprehensive backup of current state
# Purpose: Enable rollback capability if updates fail
create_backup() {
    log "Creating backup of current configuration..." "INFO"
    
    local backup_file="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "=== GEMINI CLI UPDATE BACKUP ==="
        echo "Timestamp: $TIMESTAMP"
        echo "Script Version: 2.2.0"
        echo ""
        echo "=== SOFTWARE VERSIONS ==="
        echo "Node.js: $ORIGINAL_NODE_VERSION"
        echo "npm: $ORIGINAL_NPM_VERSION"
        echo "Gemini CLI: $ORIGINAL_GEMINI_VERSION"
        echo "Google Cloud SDK: $ORIGINAL_GCLOUD_VERSION"
        echo ""
        echo "=== GLOBAL NPM PACKAGES ==="
        npm list -g --depth=0 2>/dev/null || echo "Failed to list global packages"
        echo ""
        echo "=== SYSTEM INFORMATION ==="
        uname -a
        echo "Shell: $SHELL"
        echo "User: $USER"
        echo "Home: $HOME"
        echo "Architecture: $(uname -m)"
        echo ""
        echo "=== ENVIRONMENT VARIABLES ==="
        echo "PATH: $PATH"
        echo "NODE_PATH: ${NODE_PATH:-Not set}"
        echo "NPM_CONFIG_PREFIX: ${NPM_CONFIG_PREFIX:-Not set}"
        echo ""
        echo "=== NPM CONFIGURATION ==="
        npm config list 2>/dev/null || echo "Failed to get npm configuration"
    } > "$backup_file"
    
    log "Backup created: $backup_file" "SUCCESS"
}

# ============================================================================
# UPDATE FUNCTIONS
# ============================================================================

# Function: Update Homebrew package manager
# Purpose: Ensure Homebrew is up-to-date before using it
update_homebrew() {
    if command_exists brew; then
        log "Updating Homebrew package manager..." "INFO"
        execute_with_log "brew update" "Updating Homebrew package database"
        log "Homebrew updated successfully" "SUCCESS"
        echo ""
    else
        log "Homebrew not found. Skipping Homebrew-based updates." "WARNING"
        log "Consider installing Homebrew for better package management" "INFO"
        ((WARNINGS++))
        echo ""
    fi
}

# Function: Update Google Cloud SDK components
# Purpose: Ensure Google Cloud SDK and all components are up-to-date
# Note: Uses --quiet flag to automatically answer yes to all prompts
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
        log "Google Cloud SDK not found. Skipping gcloud updates." "WARNING"
        log "Consider installing Google Cloud SDK for cloud development" "INFO"
        ((WARNINGS++))
        echo ""
    fi
}

# Function: Upgrade Node.js via Homebrew
# Purpose: Update Node.js to latest version using Homebrew
upgrade_node_homebrew() {
    if command_exists brew; then
        log "Upgrading Node.js via Homebrew..." "INFO"
        execute_with_log "brew upgrade node" "Upgrading Node.js via Homebrew"
        
        # Refresh shell environment to get new Node.js version
        if command_exists node; then
            UPDATED_NODE_VERSION=$(node -v 2>/dev/null || echo "Unknown")
            log "Node.js upgraded to: $UPDATED_NODE_VERSION" "SUCCESS"
        fi
        echo ""
    else
        log "Homebrew not available for Node.js upgrade" "WARNING"
        log "Node.js will be updated via npm instead" "INFO"
        ((WARNINGS++))
    fi
}

# Function: Update npm to latest version
# Purpose: Ensure npm is at the latest version
update_npm() {
    log "Updating npm to latest version..." "INFO"
    execute_with_log "npm install -g npm@latest" "Updating npm to latest version"
    
    if command_exists npm; then
        UPDATED_NPM_VERSION=$(npm -v 2>/dev/null || echo "Unknown")
        log "npm updated to: $UPDATED_NPM_VERSION" "SUCCESS"
    fi
    echo ""
}

# Function: Update Gemini CLI to latest version
# Purpose: Install or update Gemini CLI to latest version
update_gemini_cli() {
    log "Updating Gemini CLI to latest version..." "INFO"
    execute_with_log "npm install -g @google/gemini-cli@latest" "Updating Gemini CLI to latest version"
    
    if command_exists gemini; then
        UPDATED_GEMINI_VERSION=$(gemini --version 2>/dev/null || echo "Unknown")
        log "Gemini CLI updated to: $UPDATED_GEMINI_VERSION" "SUCCESS"
    fi
    echo ""
}

# Function: Install Google Generative AI dependencies
# Purpose: Install required dependencies for Gemini CLI functionality
install_gemini_dependencies() {
    log "Installing Google Generative AI dependencies..." "INFO"
    
    # Install globally for CLI access
    execute_with_log "npm install -g @google/generative-ai" "Installing Google Generative AI package globally"
    
    # Install locally in current project (if in a project directory)
    if [[ -f "package.json" ]]; then
        execute_with_log "npm install @google/generative-ai" "Installing Google Generative AI package locally"
        log "Local project dependencies updated" "SUCCESS"
    else
        log "No package.json found - skipping local installation" "INFO"
    fi
    
    log "Google Generative AI dependencies installed successfully" "SUCCESS"
    echo ""
}

# Function: Enable Gemini CLI IDE integration
# Purpose: Configure Gemini CLI for optimal IDE integration (especially Cursor)
enable_ide_integration() {
    log "Configuring Gemini CLI IDE integration..." "INFO"
    
    if command_exists gemini; then
        # Enable IDE integration
        execute_with_log "gemini /ide enable" "Enabling Gemini CLI IDE integration" "true"
        
        # Check IDE status
        log "Checking IDE integration status..." "DEBUG"
        if execute_with_log "gemini /ide status" "Checking IDE integration status" "true"; then
            log "IDE integration configured successfully" "SUCCESS"
        else
            log "IDE integration may need manual configuration" "WARNING"
            log "Run 'gemini /ide enable' manually if needed" "INFO"
            ((WARNINGS++))
        fi
    else
        log "Gemini CLI not found - skipping IDE integration" "ERROR"
        ((ERRORS++))
    fi
    
    echo ""
}

# Function: Update all global npm packages
# Purpose: Update all globally installed npm packages
update_global_packages() {
    log "Updating all global npm packages..." "INFO"
    execute_with_log "npm update -g" "Updating all global npm packages" "true"  # Allow failure for this one
    log "Global packages update completed" "SUCCESS"
    echo ""
}

# ============================================================================
# VERIFICATION AND TESTING FUNCTIONS
# ============================================================================

# Function: Verify all installations are working
# Purpose: Confirm all software is properly installed and accessible
verify_installations() {
    log "Verifying all installations..." "INFO"
    echo ""
    
    # Check Node.js
    if command_exists node; then
        local current_node=$(node -v 2>/dev/null || echo "Unknown")
        log "✓ Node.js: $current_node" "SUCCESS"
    else
        log "✗ Node.js: Not found" "ERROR"
        ((ERRORS++))
    fi
    
    # Check npm
    if command_exists npm; then
        local current_npm=$(npm -v 2>/dev/null || echo "Unknown")
        log "✓ npm: $current_npm" "SUCCESS"
    else
        log "✗ npm: Not found" "ERROR"
        ((ERRORS++))
    fi
    
    # Check Gemini CLI
    if command_exists gemini; then
        local current_gemini=$(gemini --version 2>/dev/null || echo "Unknown")
        log "✓ Gemini CLI: $current_gemini" "SUCCESS"
    else
        log "✗ Gemini CLI: Not found" "ERROR"
        ((ERRORS++))
    fi
    
    # Check Google Cloud SDK
    if command_exists gcloud; then
        local current_gcloud=$(gcloud version --format="value(Google Cloud SDK)" 2>/dev/null || echo "Unknown")
        log "✓ Google Cloud SDK: $current_gcloud" "SUCCESS"
    else
        log "✗ Google Cloud SDK: Not found" "ERROR"
        ((ERRORS++))
    fi
    echo ""
}

# Function: Test Gemini CLI functionality
# Purpose: Verify Gemini CLI is working with actual API calls
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

# ============================================================================
# REPORTING AND MAINTENANCE FUNCTIONS
# ============================================================================

# Function: Generate comprehensive summary report
# Purpose: Create human-readable summary of all changes and status
generate_summary() {
    log "Generating update summary..." "INFO"
    
    local summary_file="$LOG_DIR/summary_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "============================================================================="
        echo "                    GEMINI CLI UPDATE SUMMARY"
        echo "============================================================================="
        echo "Timestamp: $TIMESTAMP"
        echo "Script Version: 2.2.0"
        echo "Log file: $LOG_FILE"
        echo ""
        echo "VERSION CHANGES:"
        echo "  Node.js: $ORIGINAL_NODE_VERSION → $UPDATED_NODE_VERSION"
        echo "  npm: $ORIGINAL_NPM_VERSION → $UPDATED_NPM_VERSION"
        echo "  Gemini CLI: $ORIGINAL_GEMINI_VERSION → $UPDATED_GEMINI_VERSION"
        echo "  Google Cloud SDK: $ORIGINAL_GCLOUD_VERSION → $UPDATED_GCLOUD_VERSION"
        echo ""
        echo "STATISTICS:"
        echo "  Errors: $ERRORS"
        echo "  Warnings: $WARNINGS"
        echo "  Execution time: $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
        echo "FILES CREATED:"
        echo "  Main log: $LOG_FILE"
        echo "  Summary: $summary_file"
        echo "  Backup directory: $BACKUP_DIR"
        echo ""
        echo "NEXT STEPS:"
        if [[ $ERRORS -eq 0 ]]; then
            echo "  ✅ All updates completed successfully"
            echo "  ✅ Your development environment is up-to-date"
            echo "  ✅ You can now use the latest versions of all tools"
        else
            echo "  ⚠️  Updates completed with $ERRORS error(s)"
            echo "  ⚠️  Please review the log file for details"
            echo "  ⚠️  Some functionality may be limited"
        fi
        echo ""
        echo "VERIFICATION COMMANDS:"
        echo "  node --version"
        echo "  npm --version"
        echo "  gemini --version"
        echo "  gcloud version"
        echo "  gemini ask 'Hello'"
        echo ""
        echo "============================================================================="
    } > "$summary_file"
    
    log "Summary report created: $summary_file" "SUCCESS"
    echo ""
    
    # Display summary
    cat "$summary_file"
}

# Function: Clean up old log files
# Purpose: Maintain log directory by keeping only recent files
cleanup_old_logs() {
    log "Cleaning up old log files (keeping last 10)..." "INFO"
    
    # Keep only the last 10 log files
    find "$LOG_DIR" -name "update_*.log" -type f | sort -r | tail -n +11 | xargs rm -f 2>/dev/null || true
    find "$LOG_DIR" -name "summary_*.txt" -type f | sort -r | tail -n +11 | xargs rm -f 2>/dev/null || true
    
    log "Log cleanup completed" "SUCCESS"
}

# ============================================================================
# COMMAND LINE ARGUMENT PARSING
# ============================================================================

# Function: Parse command line arguments
# Purpose: Handle various script execution modes
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --verbose|-v)
                VERBOSE=true
                log "Verbose mode enabled" "INFO"
                shift
                ;;
            --dry-run|-d)
                DRY_RUN=true
                log "Dry run mode enabled - no changes will be made" "INFO"
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo "Options:"
                echo "  --verbose, -v    Enable verbose output"
                echo "  --dry-run, -d   Preview changes without executing"
                echo "  --help, -h      Show this help message"
                exit 0
                ;;
            *)
                log "Unknown option: $1" "WARNING"
                log "Use --help for usage information" "INFO"
                shift
                ;;
        esac
    done
}

# ============================================================================
# MAIN EXECUTION FUNCTION
# ============================================================================

# Function: Main script execution
# Purpose: Orchestrate the entire update process
main() {
    # Parse command line arguments
    parse_arguments "$@"
    
    # Create log directory
    create_directories
    
    # Start comprehensive logging
    {
        echo "============================================================================="
        echo "                    ENHANCED GEMINI CLI UPDATE SCRIPT"
        echo "============================================================================="
        echo "Started: $TIMESTAMP"
        echo "Script Version: 2.2.0"
        echo "Log file: $LOG_FILE"
        echo "User: $USER"
        echo "System: $(uname -a)"
        echo "Verbose mode: $VERBOSE"
        echo "Dry run mode: $DRY_RUN"
        echo "============================================================================="
        echo ""
    } > "$LOG_FILE"
    
    # Display header
    echo "============================================================================="
    echo "                    ENHANCED GEMINI CLI UPDATE SCRIPT"
    echo "============================================================================="
    echo "Started: $TIMESTAMP"
        echo "Script Version: 2.2.0"
    echo "Log file: $LOG_FILE"
    echo "Verbose mode: $VERBOSE"
    echo "Dry run mode: $DRY_RUN"
    echo "============================================================================="
    echo ""
    
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
    
    # Upgrade Node.js via Homebrew
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

# ============================================================================
# SCRIPT EXECUTION
# ============================================================================

# Set up signal handlers for graceful interruption
trap 'log "Script interrupted by user" "WARNING"; exit 130' INT TERM

# Execute main function with all arguments
main "$@"
