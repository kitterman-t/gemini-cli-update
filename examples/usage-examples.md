# Usage Examples

This document provides practical examples of how to use the Gemini CLI Update Script in various scenarios.

**Last Updated:** December 17, 2025  
**Script Version:** 3.1.0

## 📖 About This Guide

This guide contains real-world examples and use cases for the Gemini CLI Update Script. Each example is tested and verified to work correctly. Use these examples as templates for your own automation and integration needs.

## Basic Usage

### Simple Update
```bash
# Run the script with default settings
./update_gemini_cli.sh
```

### Preview Changes (Dry Run)
```bash
# See what would be updated without making changes
./update_gemini_cli.sh --dry-run
```

### Verbose Output
```bash
# Get detailed information about the update process
./update_gemini_cli.sh --verbose
```

## Advanced Usage

### Combined Options
```bash
# Preview changes with detailed output
./update_gemini_cli.sh --dry-run --verbose
```

### Scheduled Updates
```bash
# Add to crontab for weekly updates (Sundays at 2 AM)
0 2 * * 0 /path/to/update_gemini_cli.sh
```

### Custom Log Directory
```bash
# Modify the script to use a custom log directory
export CUSTOM_LOG_DIR="/custom/path/logs"
./update_gemini_cli.sh
```

## Troubleshooting Examples

### Check Current Versions
```bash
# Before running the script, check current versions
node --version
npm --version
gemini --version
gcloud version
```

### Verify Installation
```bash
# After running the script, verify everything works
node --version
npm --version
gemini --version
gemini ask "Hello, test connection"
```

### Review Logs
```bash
# Check the latest log file
ls -la gemini-update-logs/
cat gemini-update-logs/update_$(date +%Y%m%d)_*.log | tail -20
```

## Integration Examples

### With CI/CD Pipeline
```yaml
# GitHub Actions example
name: Update Development Environment
on:
  schedule:
    - cron: '0 2 * * 0'  # Weekly on Sunday at 2 AM

jobs:
  update-environment:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - name: Update Gemini CLI
        run: |
          chmod +x update_gemini_cli.sh
          ./update_gemini_cli.sh --verbose
```

### With Shell Scripts
```bash
#!/bin/bash
# update-dev-environment.sh

echo "Starting development environment update..."

# Update Gemini CLI
./update_gemini_cli.sh --verbose

# Additional updates
brew update
brew upgrade

echo "Development environment update complete!"
```

### With Makefile
```makefile
# Makefile
.PHONY: update-gemini update-all

update-gemini:
	./update_gemini_cli.sh --verbose

update-all: update-gemini
	brew update
	brew upgrade

clean-logs:
	rm -rf gemini-update-logs/
```

## Error Handling Examples

### Check for Errors
```bash
# Run script and check exit code
./update_gemini_cli.sh
if [ $? -eq 0 ]; then
    echo "Update completed successfully"
else
    echo "Update failed, check logs"
    cat gemini-update-logs/update_*.log | grep ERROR
fi
```

### Backup and Restore
```bash
# Create manual backup before update
cp -r ~/.nvm ~/.nvm.backup
cp -r ~/.npm ~/.npm.backup

# Run update
./update_gemini_cli.sh

# If something goes wrong, restore from backup
# (Note: The script creates its own backups automatically)
```

## Performance Examples

### Monitor Execution Time
```bash
# Time the script execution
time ./update_gemini_cli.sh
```

### Check System Resources
```bash
# Monitor system resources during update
top -l 1 | head -10
./update_gemini_cli.sh
top -l 1 | head -10
```

## Security Examples

### Run with Limited Permissions
```bash
# Create a dedicated user for updates
sudo useradd -m -s /bin/bash updater
sudo -u updater ./update_gemini_cli.sh
```

### Audit Log Analysis
```bash
# Check for security-related events
grep -i "error\|warning\|failed" gemini-update-logs/update_*.log
```

## Customization Examples

### Environment-Specific Updates
```bash
# Set environment variables for custom behavior
export GEMINI_UPDATE_VERBOSE=true
export GEMINI_UPDATE_DRY_RUN=false
./update_gemini_cli.sh
```

### Selective Updates
```bash
# Modify the script to skip certain updates
# Edit the script and comment out unwanted sections
# Example: Skip Google Cloud SDK update
# update_gcloud_components
```

## Monitoring Examples

### Log Monitoring
```bash
# Monitor logs in real-time
tail -f gemini-update-logs/update_*.log
```

### Health Checks
```bash
# Create a health check script
#!/bin/bash
# health-check.sh

echo "Checking development environment health..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found"
    exit 1
fi

# Check npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm not found"
    exit 1
fi

# Check Gemini CLI
if ! command -v gemini &> /dev/null; then
    echo "❌ Gemini CLI not found"
    exit 1
fi

# Test Gemini CLI
if ! gemini ask "Health check" &> /dev/null; then
    echo "❌ Gemini CLI not responding"
    exit 1
fi

echo "✅ All systems healthy"
```

## Best Practices

### Regular Maintenance
```bash
# Weekly maintenance script
#!/bin/bash
# weekly-maintenance.sh

echo "Starting weekly maintenance..."

# Update Gemini CLI
./update_gemini_cli.sh --verbose

# Clean up old logs (keep last 10)
find gemini-update-logs/ -name "*.log" -type f | sort -r | tail -n +11 | xargs rm -f

# Clean up old backups (keep last 5)
find gemini-update-logs/backups/ -name "*.txt" -type f | sort -r | tail -n +6 | xargs rm -f

echo "Weekly maintenance complete!"
```

### Automated Testing
```bash
# Test script functionality
#!/bin/bash
# test-script.sh

echo "Testing Gemini CLI Update Script..."

# Test dry run
./update_gemini_cli.sh --dry-run --verbose
if [ $? -ne 0 ]; then
    echo "❌ Dry run test failed"
    exit 1
fi

# Test verbose mode
./update_gemini_cli.sh --verbose --dry-run
if [ $? -ne 0 ]; then
    echo "❌ Verbose mode test failed"
    exit 1
fi

echo "✅ All tests passed"
```

These examples should help you get the most out of the Gemini CLI Update Script in various scenarios.
