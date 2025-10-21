# Cross-Platform Gemini CLI Update Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows/)
[![macOS](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos/)
[![Linux](https://img.shields.io/badge/Platform-Linux-green.svg)](https://www.linux.org/)
[![PowerShell](https://img.shields.io/badge/Shell-PowerShell-purple.svg)](https://docs.microsoft.com/powershell/)
[![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)

A comprehensive cross-platform automation script for updating Node.js, npm, Gemini CLI, and Google Cloud SDK on Windows, macOS, and Linux systems. Features extensive logging, error handling, backup creation, and detailed reporting capabilities.

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
chmod +x update_gemini_cli.sh update_gemini_cli_original.sh
```

### Option 2: Direct Download
```bash
# Download the cross-platform launcher
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli.sh

# Download the PowerShell script (Windows)
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli.ps1

# Download the Bash script (macOS/Linux)
curl -O https://raw.githubusercontent.com/kitterman-t/gemini-cli-update/main/update_gemini_cli_original.sh

# Make executable (Unix systems)
chmod +x update_gemini_cli.sh update_gemini_cli_original.sh
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
# Basic usage
./update_gemini_cli_original.sh

# With verbose output
./update_gemini_cli_original.sh --verbose

# Dry run (preview changes)
./update_gemini_cli_original.sh --dry-run

# Combine options
./update_gemini_cli_original.sh --verbose --dry-run

# Show help
./update_gemini_cli_original.sh --help
```

### Command Line Options

| Option | Windows | macOS/Linux | Description |
|--------|---------|--------------|-------------|
| `-Verbose`, `-v` | ✅ | `--verbose`, `-v` | Enable verbose output with detailed execution information |
| `-DryRun`, `-d` | ✅ | `--dry-run`, `-d` | Preview changes without executing them |
| `-Help`, `-h` | ✅ | `--help`, `-h` | Show help message and usage information |

## 📊 What Gets Updated

The script performs the following updates:

1. **Homebrew Package Manager**
   - Updates Homebrew package database
   - Ensures latest package information

2. **Google Cloud SDK**
   - Updates all Google Cloud SDK components
   - Uses `--quiet` flag for automated updates

3. **Node.js**
   - Upgrades to latest version via Homebrew
   - Maintains compatibility with existing projects

4. **npm**
   - Updates to latest version globally
   - Ensures package manager is current

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

## 🔧 Configuration

### Environment Variables
The script automatically detects and uses:
- `$HOME` - User home directory
- `$PATH` - System PATH for command execution
- `$SHELL` - Current shell environment

### Customization
You can modify the script to:
- Change log directory location
- Add additional software to update
- Customize backup retention policy
- Modify error handling behavior

## 🚨 Troubleshooting

### Common Issues

#### Permission Errors
```bash
# Ensure script is executable
chmod +x update_gemini_cli.sh

# Run with appropriate permissions if needed
sudo ./update_gemini_cli.sh
```

#### Homebrew Issues
```bash
# Install Homebrew if not present
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update Homebrew
brew update
```

#### Node.js/npm Issues
```bash
# Clear npm cache
npm cache clean --force

# Reset npm registry
npm config set registry https://registry.npmjs.org/
```

#### Gemini CLI Issues
```bash
# Check API key configuration
gemini config

# Verify internet connectivity
ping google.com

# Check for firewall/proxy issues
curl -I https://api.gemini.com
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

- **Typical execution time**: 2-5 minutes
- **Network dependent**: Download speeds affect total time
- **Minimal system resource usage**: Optimized for efficiency
- **Parallel operations**: Where possible for faster execution

## 🔒 Security

- **Secure by design**: No sensitive data is logged (API keys, passwords)
- **Audit trail**: All operations are logged for security review
- **Backup integrity**: Backup files contain only configuration data
- **Permission management**: Respects system security policies

## 📝 Version History

### v2.2.0 (2025-10-14)
- ✅ Fixed path issues for portable script execution
- ✅ Enhanced Google Cloud SDK components update
- ✅ Improved error handling and logging
- ✅ Added comprehensive documentation

### v2.1.0 (2025-10-04)
- ✅ Added Google Generative AI dependency installation
- ✅ Enhanced IDE integration for Cursor support
- ✅ Fixed import errors and path issues
- ✅ Improved compatibility and reliability

### v2.0.0 (2025-10-03)
- ✅ Complete rewrite with enhanced logging
- ✅ Added comprehensive backup system
- ✅ Implemented error handling and reporting
- ✅ Created detailed documentation

### v1.0.0 (2025-10-03)
- ✅ Initial version with basic update functionality

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup
```bash
# Clone the repository
git clone https://github.com/your-username/gemini-cli-update.git
cd gemini-cli-update

# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes
# ... your modifications ...

# Test your changes
./update_gemini_cli.sh --dry-run

# Commit your changes
git commit -m "feat: add your feature description"

# Push to your fork
git push origin feature/your-feature-name
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. **Check the logs**: Review the generated log files for detailed error information
2. **Run in verbose mode**: Use `--verbose` flag for detailed execution information
3. **Try dry run**: Use `--dry-run` to preview changes without executing
4. **Create an issue**: Open an issue on GitHub with detailed information

## 🙏 Acknowledgments

- **Google**: For the Gemini CLI and Google Cloud SDK
- **Node.js Foundation**: For Node.js and npm
- **Homebrew**: For the macOS package manager
- **Community**: For feedback and contributions

---

**Made with ❤️ for the developer community**
