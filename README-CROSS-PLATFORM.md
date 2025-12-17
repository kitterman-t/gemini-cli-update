# Cross-Platform Gemini CLI Update Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows/)
[![macOS](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos/)
[![Linux](https://img.shields.io/badge/Platform-Linux-green.svg)](https://www.linux.org/)
[![PowerShell](https://img.shields.io/badge/Shell-PowerShell-purple.svg)](https://docs.microsoft.com/powershell/)
[![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)

A comprehensive cross-platform automation script for updating Node.js, npm, Gemini CLI, and Google Cloud SDK on Windows, macOS, and Linux systems. Features extensive logging, error handling, backup creation, and detailed reporting capabilities.

**Version:** 3.1.0 | **Last Updated:** December 17, 2025 | **Status:** Production Ready

## 🚀 Features

### Cross-Platform Support
- **Windows**: PowerShell 5.1+ with Chocolatey/Scoop package managers
- **macOS**: Bash 3.2+ with Homebrew package manager
- **Linux**: Bash 3.2+ with apt/yum/dnf package managers
- **Automatic OS Detection**: Scripts automatically detect and adapt to your platform

### Comprehensive Updates
- **Node.js**: Latest version via platform-specific package managers
- **npm**: Force reinstall to latest version globally
- **Gemini CLI**: Force reinstall to latest version with IDE integration
- **Google Cloud SDK**: Platform-specific installation and updates
- **Dependencies**: Google Generative AI packages and global npm packages

### Advanced Features
- **Extensive Logging**: Detailed logging with timestamps, error tracking, and performance metrics
- **Backup System**: Creates automatic backups before updates for rollback capability
- **Error Handling**: Graceful failure handling with detailed error reporting
- **IDE Integration**: Automatic Gemini CLI IDE integration for optimal Cursor support
- **Dry Run Mode**: Preview changes without executing them
- **Verbose Output**: Detailed execution information for debugging
- **Version Tracking**: Before/after version comparison and change tracking

## 📋 Prerequisites

### Windows
- **Windows 10/11** (tested on Windows 10 1903+ and Windows 11)
- **PowerShell 5.1+** (included with Windows 10/11)
- **Chocolatey** (auto-installed if missing)
- **Scoop** (auto-installed if missing)
- **Internet connection** (for downloading updates)
- **Administrator privileges** (for system-wide installations)

### macOS
- **macOS Sequoia 15.0+** (tested on macOS Sequoia 15.0+)
- **Bash 3.2+** (included with macOS)
- **Homebrew** (auto-installed if missing)
- **Internet connection** (for downloading updates)
- **Appropriate user permissions** (sudo may be required)

### Linux
- **Ubuntu 18.04+**, **CentOS 7+**, **RHEL 7+**, **Fedora 30+**
- **Bash 3.2+** (included with most distributions)
- **apt/yum/dnf** package manager
- **Internet connection** (for downloading updates)
- **sudo privileges** (for system-wide installations)

## 🛠️ Installation

### Option 1: Clone Repository
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

# Download the PowerShell script (Windows)
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli.ps1

# Download the Bash script (macOS/Linux)
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli_macos.sh
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli_original.sh

# Make executable (Unix systems)
chmod +x update_gemini_cli.sh update_gemini_cli_macos.sh update_gemini_cli_original.sh
```

## 🎯 Usage

### Cross-Platform Launcher
The main script automatically detects your operating system and runs the appropriate version:

```bash
# Run the cross-platform launcher
./update_gemini_cli.sh

# With options
./update_gemini_cli.sh --verbose --dry-run
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

### Windows
1. **Chocolatey Package Manager**
   - Updates Chocolatey package database
   - Upgrades all installed packages

2. **Scoop Package Manager**
   - Updates Scoop package database
   - Upgrades all installed packages

3. **Google Cloud SDK**
   - Installs/updates via Chocolatey
   - Updates all components with --quiet flag

4. **Node.js**
   - Installs/updates via Chocolatey or Scoop
   - Force reinstall to ensure latest version

5. **npm**
   - Updates to latest version globally
   - Force reinstall for clean installation

6. **Gemini CLI**
   - Installs/updates to latest version
   - Enables IDE integration for Cursor support

7. **Dependencies**
   - Installs Google Generative AI dependencies
   - Updates all global npm packages

### macOS
1. **Homebrew Package Manager**
   - Updates Homebrew package database
   - Upgrades all installed packages

2. **Google Cloud SDK**
   - Installs/updates via official installer
   - Updates all components with --quiet flag

3. **Node.js**
   - Installs/updates via Homebrew or NVM
   - Force reinstall to ensure latest version

4. **npm**
   - Updates to latest version globally
   - Force reinstall for clean installation

5. **Gemini CLI**
   - Installs/updates to latest version
   - Enables IDE integration for Cursor support

6. **Dependencies**
   - Installs Google Generative AI dependencies
   - Updates all global npm packages

### Linux
1. **System Package Manager**
   - Updates package database (apt/yum/dnf)
   - Upgrades system packages

2. **Google Cloud SDK**
   - Installs/updates via official installer
   - Updates all components with --quiet flag

3. **Node.js**
   - Installs/updates via NodeSource repository
   - Force reinstall to ensure latest version

4. **npm**
   - Updates to latest version globally
   - Force reinstall for clean installation

5. **Gemini CLI**
   - Installs/updates to latest version
   - Enables IDE integration for Cursor support

6. **Dependencies**
   - Installs Google Generative AI dependencies
   - Updates all global npm packages

## 📁 Logging System

The script creates a comprehensive logging system:

```
gemini-update-logs/
├── update_YYYYMMDD_HHMMSS.log     # Main detailed log file
├── summary_YYYYMMDD_HHMMSS.txt    # Human-readable summary
└── backups/
    └── backup_YYYYMMDD_HHMMSS.txt # Configuration backup
```

### Log File Contents
- All command executions with full output (stdout/stderr)
- System information (OS, architecture, user, paths)
- Version changes (before → after for each component)
- Error messages, warnings, and success confirmations
- File operations and path references
- Timing information for each operation
- API test results and functionality verification
- Backup creation and restoration information

## 🔧 Platform-Specific Configuration

### Windows Configuration
- **PowerShell Execution Policy**: Script handles execution policy automatically
- **Chocolatey Installation**: Auto-installs if not present
- **Scoop Installation**: Auto-installs if not present
- **PATH Management**: Automatically adds installation directories to PATH

### macOS Configuration
- **Homebrew Installation**: Auto-installs if not present
- **NVM Fallback**: Uses NVM if Homebrew unavailable
- **Permission Management**: Handles sudo requirements gracefully

### Linux Configuration
- **Package Manager Detection**: Automatically detects apt/yum/dnf
- **NodeSource Repository**: Adds official Node.js repository
- **Permission Management**: Handles sudo requirements gracefully

## 🚨 Troubleshooting

### Windows Issues

#### PowerShell Execution Policy
```powershell
# If you get execution policy errors
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Chocolatey Issues
```powershell
# Install Chocolatey manually if needed
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### Scoop Issues
```powershell
# Install Scoop manually if needed
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

### macOS Issues

#### Homebrew Issues
```bash
# Install Homebrew manually if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Permission Issues
```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) $(brew --prefix)/*
```

### Linux Issues

#### Package Manager Issues
```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade

# CentOS/RHEL
sudo yum update

# Fedora
sudo dnf update
```

#### Node.js Installation Issues
```bash
# Add NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

## 📈 Performance

### Execution Time
- **Windows**: 3-6 minutes (depending on package manager)
- **macOS**: 2-5 minutes (Homebrew optimized)
- **Linux**: 3-7 minutes (depending on distribution)

### Resource Usage
- **Disk space**: ~200MB for logs, backups, and temporary files
- **Memory**: <100MB during execution
- **Network**: ~300MB downloads (varies by platform)
- **CPU**: Low usage, mostly I/O bound

## 🔒 Security

### Data Protection
- **No sensitive data logging**: API keys, passwords excluded
- **Secure defaults**: Conservative security settings
- **Audit trail**: All operations logged for security review
- **Backup security**: Configuration data only

### Permission Model
- **User permissions**: Respects system security
- **Administrator/sudo usage**: Minimal, only when required
- **File permissions**: Maintains system security
- **Network security**: HTTPS for all downloads

## 📝 Version History

### v3.0.1 (2025-12-06) - Production Optimization & Documentation Enhancement
- ✅ **Enhanced documentation** with comprehensive function comments
- ✅ **Improved script headers** with detailed purpose and usage information
- ✅ **Updated all documentation files** with current information
- ✅ **Version consistency** across all scripts and documentation
- ✅ **Production tested** and verified with zero errors

### v3.0.0 (2025-10-21)
- ✅ **Cross-platform support** for Windows, macOS, and Linux
- ✅ **PowerShell script** for Windows with Chocolatey/Scoop support
- ✅ **Enhanced Bash script** for macOS/Linux with improved package management
- ✅ **Automatic OS detection** and platform-specific execution
- ✅ **Comprehensive logging** across all platforms
- ✅ **Force reinstall capabilities** for all components
- ✅ **Enhanced error handling** and recovery mechanisms

### v2.3.0 (2025-10-14)
- ✅ Enhanced force reinstall capabilities for macOS
- ✅ Automatic Homebrew installation if not present
- ✅ Added Google Cloud SDK installation if not present
- ✅ Improved Node.js installation with NVM fallback

### v2.2.0 (2025-10-14)
- ✅ Fixed path issues for portable script execution
- ✅ Enhanced Google Cloud SDK components update
- ✅ Improved error handling and logging

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

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. **Check the logs**: Review the generated log files for detailed error information
2. **Run in verbose mode**: Use `-Verbose` (Windows) or `--verbose` (macOS/Linux) flag
3. **Try dry run**: Use `-DryRun` (Windows) or `--dry-run` (macOS/Linux) to preview changes
4. **Create an issue**: Open an issue on GitHub with detailed information

## 🙏 Acknowledgments

- **Google**: For the Gemini CLI and Google Cloud SDK
- **Node.js Foundation**: For Node.js and npm
- **Microsoft**: For PowerShell and Windows support
- **Homebrew**: For the macOS package manager
- **Chocolatey/Scoop**: For Windows package management
- **Community**: For feedback and contributions

---

**Made with ❤️ for the cross-platform developer community**
