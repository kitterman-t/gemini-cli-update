# Cross-Platform Gemini CLI Update Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows/)
[![macOS](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos/)
[![Linux](https://img.shields.io/badge/Platform-Linux-green.svg)](https://www.linux.org/)
[![PowerShell](https://img.shields.io/badge/Shell-PowerShell-purple.svg)](https://docs.microsoft.com/powershell/)
[![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/Version-3.0.1-brightgreen.svg)](https://github.com/kitterman-t/gemini-cli-update/releases)
[![Production Ready](https://img.shields.io/badge/Status-Production%20Ready-success.svg)](https://github.com/kitterman-t/gemini-cli-update)

> **Enterprise-grade cross-platform automation script for updating Node.js, npm, Gemini CLI, and Google Cloud SDK on Windows, macOS, and Linux systems.**

## 🚀 Overview

The **Cross-Platform Gemini CLI Update Script** is a comprehensive, production-ready automation solution that ensures your development environment is always up-to-date with the latest versions of essential tools. Built with enterprise-grade reliability, extensive logging, and cross-platform compatibility.

### ✨ Key Features

- **🌐 Cross-Platform Support**: Windows, macOS, and Linux with automatic OS detection
- **🔄 Force Reinstall**: Updates all components regardless of current installation status
- **📊 Comprehensive Logging**: Detailed logs with timestamps, error tracking, and performance metrics
- **💾 Backup System**: Automatic backups before updates for rollback capability
- **🛡️ Error Handling**: Graceful failure handling with detailed error reporting
- **🔧 IDE Integration**: Manual IDE integration support (automatic skipped due to known issue)
- **👀 Dry Run Mode**: Preview changes without executing them
- **📝 Verbose Output**: Detailed execution information for debugging
- **📈 Version Tracking**: Before/after version comparison and change tracking

## 🏗️ Architecture

### Cross-Platform Components

```
gemini-cli-update/
├── update_gemini_cli.sh              # Cross-platform launcher (auto-detects OS)
├── update_gemini_cli.ps1             # Windows PowerShell script
├── update_gemini_cli_macos.sh        # macOS/Linux Bash script (primary)
├── update_gemini_cli_original.sh     # Alternative launcher (alias)
├── README.md                         # This comprehensive documentation
├── README-CROSS-PLATFORM.md          # Detailed cross-platform guide
├── CHANGELOG.md                      # Version history and changes
├── CONTRIBUTING.md                   # Contribution guidelines
├── LICENSE                           # MIT License
├── .gitignore                        # Git ignore rules
└── docs/                             # Technical documentation
    ├── technical-documentation.md
    └── examples/
        └── usage-examples.md
```

### Platform-Specific Features

| Feature | Windows | macOS | Linux |
|---------|---------|-------|-------|
| **Package Managers** | Chocolatey, Scoop | Homebrew, NVM | apt, yum, dnf |
| **Node.js Installation** | Chocolatey/Scoop | Homebrew/NVM | NodeSource Repository |
| **Google Cloud SDK** | Chocolatey | Official Installer | Official Installer |
| **Shell Environment** | PowerShell 5.1+ | Bash 3.2+ | Bash 3.2+ |
| **Permission Model** | Administrator | sudo (when needed) | sudo (when needed) |

## 📋 Prerequisites

### System Requirements

| Platform | Minimum Version | Recommended | Notes |
|----------|----------------|-------------|-------|
| **Windows** | Windows 10 1903+ | Windows 11 | PowerShell 5.1+ included |
| **macOS** | macOS Sequoia 15.0+ | Latest | Bash 3.2+ included |
| **Linux** | Ubuntu 18.04+ | Latest LTS | Most distributions supported |

### Software Dependencies

- **Internet Connection**: Required for downloading updates
- **Appropriate Permissions**: Administrator/sudo access for system-wide installations
- **Package Managers**: Auto-installed if missing (Chocolatey, Scoop, Homebrew, etc.)

## 🛠️ Installation

### Option 1: Clone Repository (Recommended)

```bash
# Clone the repository
git clone https://github.com/kitterman-t/gemini-cli-update.git
cd gemini-cli-update

# Make scripts executable (Unix systems)
chmod +x update_gemini_cli.sh update_gemini_cli_macos.sh update_gemini_cli_original.sh
```

### Option 2: Direct Download

```bash
# Download the cross-platform launcher
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli.sh

# Download platform-specific scripts
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli.ps1
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli_macos.sh
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli_original.sh

# Make executable (Unix systems)
chmod +x update_gemini_cli.sh update_gemini_cli_macos.sh update_gemini_cli_original.sh
```

## 🎯 Usage

### Cross-Platform Launcher (Recommended)

The main script automatically detects your operating system and runs the appropriate version:

```bash
# Basic usage
./update_gemini_cli.sh

# With verbose output and dry run
./update_gemini_cli.sh --verbose --dry-run

# Show help
./update_gemini_cli.sh --help
```

### Platform-Specific Usage

#### Windows (PowerShell)
```powershell
# Basic usage
.\update_gemini_cli.ps1

# With verbose output
.\update_gemini_cli.ps1 -Verbose

# Dry run (preview changes)
.\update_gemini_cli.ps1 -DryRun

# Combine options
.\update_gemini_cli.ps1 -Verbose -DryRun

# Show help
.\update_gemini_cli.ps1 -Help
```

#### macOS/Linux (Bash)
```bash
# Basic usage (recommended - uses launcher)
./update_gemini_cli.sh

# Direct execution of macOS/Linux script
./update_gemini_cli_macos.sh

# With verbose output
./update_gemini_cli.sh --verbose
# or
./update_gemini_cli_macos.sh --verbose

# Dry run (preview changes)
./update_gemini_cli.sh --dry-run
# or
./update_gemini_cli_macos.sh --dry-run

# Combine options
./update_gemini_cli.sh --verbose --dry-run

# Show help
./update_gemini_cli.sh --help
# or
./update_gemini_cli_macos.sh --help
```

### Command Line Options

| Option | Windows | macOS/Linux | Description |
|--------|---------|--------------|-------------|
| `-Verbose`, `-v` | ✅ | `--verbose`, `-v` | Enable verbose output with detailed execution information |
| `-DryRun`, `-d` | ✅ | `--dry-run`, `-d` | Preview changes without executing them |
| `-Help`, `-h` | ✅ | `--help`, `-h` | Show help message and usage information |

## 📊 What Gets Updated

### All Platforms
- **Node.js**: Latest version via platform-specific package managers
- **npm**: Force reinstall to latest version globally
- **Gemini CLI**: Force reinstall to latest version with IDE integration
- **Google Cloud SDK**: Platform-specific installation and updates
- **Dependencies**: Google Generative AI packages and global npm packages

### Platform-Specific Updates

#### Windows
1. **Chocolatey Package Manager** - Updates and upgrades all packages
2. **Scoop Package Manager** - Updates and upgrades all packages
3. **Google Cloud SDK** - Installs/updates via Chocolatey
4. **Node.js** - Force reinstall via Chocolatey/Scoop
5. **npm** - Force reinstall to latest version
6. **Gemini CLI** - Force reinstall with IDE integration
7. **Dependencies** - All global npm packages updated

#### macOS
1. **Homebrew Package Manager** - Updates and upgrades all packages
2. **Google Cloud SDK** - Official installer with component updates
3. **Node.js** - Force reinstall via Homebrew/NVM
4. **npm** - Force reinstall to latest version
5. **Gemini CLI** - Force reinstall with IDE integration
6. **Dependencies** - All global npm packages updated

#### Linux
1. **System Package Manager** - Updates via apt/yum/dnf
2. **Google Cloud SDK** - Official installer with component updates
3. **Node.js** - Force reinstall via NodeSource repository
4. **npm** - Force reinstall to latest version
5. **Gemini CLI** - Force reinstall with IDE integration
6. **Dependencies** - All global npm packages updated

## 📁 Logging System

### Log Directory Structure
```
gemini-update-logs/
├── update_YYYYMMDD_HHMMSS.log     # Main detailed log file
├── summary_YYYYMMDD_HHMMSS.txt    # Human-readable summary
└── backups/
    └── backup_YYYYMMDD_HHMMSS.txt # Configuration backup
```

### Log File Contents
- **Command Executions**: All commands with full output (stdout/stderr)
- **System Information**: OS, architecture, user, paths
- **Version Changes**: Before → after for each component
- **Error Messages**: Warnings, errors, and success confirmations
- **File Operations**: Path references and file operations
- **Timing Information**: Performance metrics for each operation
- **API Test Results**: Gemini CLI functionality verification
- **Backup Information**: Creation and restoration details

## 🔧 Configuration

### Environment Variables
The script automatically detects and uses:
- `$HOME` / `$env:USERPROFILE` - User home directory
- `$PATH` / `$env:PATH` - System PATH for command execution
- `$SHELL` / `$env:COMSPEC` - Current shell environment

### Customization Options
- **Log Directory**: Modify `$LogDir` / `LOG_DIR` variables
- **Backup Retention**: Adjust cleanup policies
- **Package Managers**: Add additional package managers
- **Error Handling**: Customize error recovery behavior

## 🚨 Troubleshooting

### Common Issues

#### Permission Errors
```bash
# Unix systems
chmod +x update_gemini_cli.sh update_gemini_cli_macos.sh update_gemini_cli_original.sh

# Windows PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Package Manager Issues

**Windows - Chocolatey:**
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Windows - Scoop:**
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

**macOS - Homebrew:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Linux - Package Managers:**
```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade

# CentOS/RHEL
sudo yum update

# Fedora
sudo dnf update
```

#### Node.js/npm Issues
```bash
# Clear npm cache
npm cache clean --force

# Reset npm registry
npm config set registry https://registry.npmjs.org/
```

#### Gemini CLI Issues

**IDE Integration Hanging Issue:**
The script skips automatic IDE integration configuration as the `gemini /ide enable` command may hang due to recent configuration format changes. To manually enable IDE integration:

```bash
# Manually enable IDE integration
gemini /ide enable

# Check IDE status
gemini /ide status

# For configuration details, visit:
# https://geminicli.com/docs/get-started/configuration/
```

**Other Gemini CLI Issues:**
```bash
# Check API key configuration
gemini config

# Verify internet connectivity
ping google.com

# Check for graceful errors
gemini ask "test"

# View error reports
ls /var/folders/*/gemini-client-error-*.json
```

#### Google Cloud SDK Issues
```bash
# Install Google Cloud SDK
curl https://sdk.cloud.google.com | bash

# Authenticate
gcloud auth login

# Set project
gcloud config set project YOUR_PROJECT_ID

# Check components
gcloud components list
```

## 📈 Performance

### Execution Time
- **Windows**: 3-6 minutes (depending on package manager)
- **macOS**: 2-5 minutes (Homebrew optimized)
- **Linux**: 3-7 minutes (depending on distribution)

### Resource Usage
- **Disk Space**: ~200MB for logs, backups, and temporary files
- **Memory**: <100MB during execution
- **Network**: ~300MB downloads (varies by platform)
- **CPU**: Low usage, mostly I/O bound

## 🔒 Security

### Data Protection
- **No Sensitive Data Logging**: API keys, passwords excluded
- **Secure Defaults**: Conservative security settings
- **Audit Trail**: All operations logged for security review
- **Backup Security**: Configuration data only

### Permission Model
- **User Permissions**: Respects system security
- **Administrator/sudo Usage**: Minimal, only when required
- **File Permissions**: Maintains system security
- **Network Security**: HTTPS for all downloads

## 📝 Version History

### v3.0.1 (2025-12-06) - Production Optimization & Documentation Enhancement
- ✅ **Enhanced documentation** with comprehensive function comments and usage guides
- ✅ **Improved script headers** with detailed purpose, capabilities, and usage information
- ✅ **Updated all documentation files** with current information and best practices
- ✅ **Version consistency** across all scripts and documentation
- ✅ **Production tested** and verified across multiple execution runs
- ✅ **Enhanced error handling** with proper unbound variable handling
- ✅ **Improved path resolution** in launcher scripts for better portability
- ✅ **Fixed launcher script recursion bug** in update_gemini_cli_original.sh


### v3.0.0 (2025-10-21) - Cross-Platform Release
- ✅ **Cross-platform support** for Windows, macOS, and Linux
- ✅ **PowerShell script** for Windows with Chocolatey/Scoop support
- ✅ **Enhanced Bash script** for macOS/Linux with improved package management
- ✅ **Automatic OS detection** and platform-specific execution
- ✅ **Comprehensive logging** across all platforms
- ✅ **Force reinstall capabilities** for all components
- ✅ **Enhanced error handling** and recovery mechanisms

### v2.3.0 (2025-10-14) - Force Update Enhancement
- ✅ Enhanced force reinstall capabilities for macOS
- ✅ Automatic Homebrew installation if not present
- ✅ Added Google Cloud SDK installation if not present
- ✅ Improved Node.js installation with NVM fallback

### v2.2.0 (2025-10-14) - Path Fixes
- ✅ Fixed path issues for portable script execution
- ✅ Enhanced Google Cloud SDK components update
- ✅ Improved error handling and logging

### v2.1.0 (2025-10-04) - IDE Integration
- ✅ Added Google Generative AI dependency installation
- ✅ Enhanced IDE integration for Cursor support
- ✅ Fixed import errors and path issues

### v2.0.0 (2025-10-03) - Complete Rewrite
- ✅ Complete rewrite with enhanced logging
- ✅ Added comprehensive backup system
- ✅ Implemented error handling and reporting
- ✅ Created detailed documentation

### v1.0.0 (2025-10-03) - Initial Release
- ✅ Initial version with basic update functionality

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup
```bash
# Clone the repository
git clone https://github.com/kitterman-t/gemini-cli-update.git
cd gemini-cli-update

# Test on your platform
./update_gemini_cli.sh --dry-run --verbose
```

### Development Workflow
1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes** following our coding standards
4. **Test thoroughly** on your platform
5. **Commit your changes**: `git commit -m "feat: add your feature description"`
6. **Push to your fork**: `git push origin feature/your-feature-name`
7. **Create a pull request**

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. **Check the logs**: Review the generated log files for detailed error information
2. **Run in verbose mode**: Use `-Verbose` (Windows) or `--verbose` (macOS/Linux) flag
3. **Try dry run**: Use `-DryRun` (Windows) or `--dry-run` (macOS/Linux) to preview changes
4. **Create an issue**: Open an issue on GitHub with detailed information
5. **Check documentation**: Review the comprehensive guides in the `docs/` directory

## 🙏 Acknowledgments

- **Google**: For the Gemini CLI and Google Cloud SDK
- **Node.js Foundation**: For Node.js and npm
- **Microsoft**: For PowerShell and Windows support
- **Homebrew**: For the macOS package manager
- **Chocolatey/Scoop**: For Windows package management
- **Community**: For feedback and contributions

## 📚 Additional Documentation

- **[Cross-Platform Guide](README-CROSS-PLATFORM.md)**: Detailed cross-platform documentation
- **[Technical Documentation](docs/technical-documentation.md)**: Architecture and implementation details
- **[Usage Examples](examples/usage-examples.md)**: Practical usage scenarios
- **[Contributing Guidelines](CONTRIBUTING.md)**: How to contribute to the project
- **[Changelog](CHANGELOG.md)**: Complete version history

---

## 📚 Quick Reference

### Essential Commands
```bash
# Run update (recommended)
./update_gemini_cli.sh

# Preview changes first
./update_gemini_cli.sh --dry-run --verbose

# Check current versions
node --version && npm --version && gemini --version
```

### File Structure
- `update_gemini_cli.sh` - **Primary launcher** (use this)
- `update_gemini_cli_macos.sh` - macOS/Linux implementation
- `update_gemini_cli.ps1` - Windows PowerShell implementation
- `update_gemini_cli_original.sh` - Alternative launcher (same as primary)

### Log Files Location
All logs are stored in: `./gemini-update-logs/`
- `update_*.log` - Detailed execution logs
- `summary_*.txt` - Human-readable summaries
- `backups/*.txt` - Configuration backups

---

**Made with ❤️ for the cross-platform developer community**

*Enterprise-grade automation for modern development environments*