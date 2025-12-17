# Contributing to Gemini CLI Update Script

Thank you for your interest in contributing to the Gemini CLI Update Script! This document provides comprehensive guidelines and information for contributors.

**Last Updated:** December 17, 2025  
**Script Version:** 3.1.0

## 🎯 Contribution Philosophy

We welcome contributions that improve the script's reliability, usability, documentation, and cross-platform compatibility. All contributions should maintain the high standards of code quality, comprehensive error handling, and detailed logging that make this script production-ready.

## 🤝 How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to avoid duplicates
2. **Check the troubleshooting section** in the README
3. **Run the script with `--verbose` flag** to get detailed information
4. **Include relevant log files** from the `gemini-update-logs/` directory

When creating an issue, please include:

- **OS version** (e.g., macOS Sequoia 15.0)
- **Script version** (run `./update_gemini_cli.sh --help`)
- **Error messages** and log output
- **Steps to reproduce** the issue
- **Expected vs actual behavior**

### Suggesting Enhancements

We welcome suggestions for new features and improvements! Please:

1. **Check existing issues** for similar suggestions
2. **Describe the enhancement** clearly
3. **Explain the use case** and benefits
4. **Provide examples** if applicable

### Code Contributions

#### Development Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/gemini-cli-update.git
   cd gemini-cli-update
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the coding standards below
   - Add tests if applicable
   - Update documentation

4. **Test your changes**
   ```bash
   # Test with dry run
   ./update_gemini_cli.sh --dry-run --verbose
   
   # Test actual execution (if safe)
   ./update_gemini_cli.sh --verbose
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

6. **Push and create a pull request**
   ```bash
   git push origin feature/your-feature-name
   ```

## 📋 Coding Standards

### Bash Script Guidelines

- **Use consistent indentation** (4 spaces)
- **Add comments** for complex logic
- **Follow the existing code style**
- **Use meaningful variable names**
- **Handle errors gracefully**

### Code Style

```bash
# Good: Clear variable names and comments
LOG_DIR="$SCRIPT_DIR/gemini-update-logs"
log "Creating backup of current configuration..." "INFO"

# Good: Proper error handling
if command_exists node; then
    ORIGINAL_NODE_VERSION=$(node -v 2>/dev/null || echo "Unknown")
else
    ORIGINAL_NODE_VERSION="Not installed"
    log "Node.js: Not installed" "WARNING"
fi
```

### Documentation Standards

- **Update README.md** for new features
- **Add entries to CHANGELOG.md** for all changes
- **Include usage examples** for new functionality
- **Update inline comments** in the script

## 🧪 Testing

### Testing Guidelines

1. **Always test with `--dry-run` first**
2. **Test on different macOS versions** if possible
3. **Verify error handling** with missing dependencies
4. **Check log output** for proper formatting
5. **Test backup and restore functionality**

### Test Scenarios

- [ ] Script execution with all dependencies present
- [ ] Script execution with missing dependencies
- [ ] Dry run mode functionality
- [ ] Verbose output mode
- [ ] Error handling and recovery
- [ ] Log file creation and formatting
- [ ] Backup creation and content
- [ ] Cleanup functionality

## 📝 Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/) specification:

### Format
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples
```bash
# Good commit messages
git commit -m "feat(logging): add timestamp to all log entries"
git commit -m "fix(backup): resolve path issues in backup creation"
git commit -m "docs(readme): update installation instructions"
git commit -m "refactor(script): improve error handling logic"
```

## 🔄 Pull Request Process

### Before Submitting

1. **Ensure your code follows the style guidelines**
2. **Test your changes thoroughly**
3. **Update documentation as needed**
4. **Add entries to CHANGELOG.md**
5. **Ensure all tests pass**

### Pull Request Template

When creating a pull request, please include:

- **Description** of the changes
- **Type of change** (bug fix, feature, etc.)
- **Testing performed**
- **Screenshots** if applicable
- **Breaking changes** if any

### Review Process

1. **Automated checks** will run on your PR
2. **Maintainers will review** your code
3. **Feedback will be provided** for improvements
4. **Changes may be requested** before merging

## 🏷️ Release Process

### Version Numbering

We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality (backwards compatible)
- **PATCH**: Bug fixes (backwards compatible)

### Release Checklist

- [ ] All tests pass
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated
- [ ] Version numbers are updated
- [ ] Release notes are prepared

## 🐛 Bug Reports

### Before Reporting

1. **Check if the issue is already reported**
2. **Try the latest version**
3. **Run with `--verbose` flag**
4. **Check the log files**

### Bug Report Template

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Run command '...'
2. See error

**Expected behavior**
What you expected to happen.

**Environment:**
- OS: [e.g. macOS Sequoia 15.0]
- Script version: [e.g. 2.2.0]
- Node.js version: [e.g. v24.3.0]

**Log files**
Include relevant log files from `gemini-update-logs/`

**Additional context**
Any other context about the problem.
```

## 💡 Feature Requests

### Before Requesting

1. **Check if the feature already exists**
2. **Consider if it fits the project scope**
3. **Think about implementation complexity**

### Feature Request Template

```markdown
**Is your feature request related to a problem?**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Other solutions or workarounds you've considered.

**Additional context**
Any other context or screenshots about the feature request.
```

## 📚 Resources

### Documentation
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/bash.html)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)

### Tools
- [ShellCheck](https://www.shellcheck.net/) - Bash script linting
- [GitHub CLI](https://cli.github.com/) - GitHub command line tool
- [Homebrew](https://brew.sh/) - macOS package manager

## 🎯 Areas for Contribution

### High Priority
- **Cross-platform support** (Linux, Windows)
- **Additional package managers** (yarn, pnpm)
- **Enhanced error recovery**
- **Performance optimizations**

### Medium Priority
- **Additional IDE integrations**
- **Custom configuration options**
- **Advanced logging features**
- **Automated testing**

### Low Priority
- **GUI interface**
- **Web dashboard**
- **Plugin system**
- **Advanced analytics**

## 📞 Getting Help

If you need help with contributing:

1. **Check the documentation** in README.md
2. **Search existing issues** for similar problems
3. **Create a new issue** with detailed information
4. **Join discussions** in GitHub issues

## 🙏 Recognition

Contributors will be recognized in:
- **README.md** contributors section
- **CHANGELOG.md** for significant contributions
- **Release notes** for major features

Thank you for contributing to the Gemini CLI Update Script! 🚀
