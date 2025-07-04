# 🤖 Automated Release System

This repository uses automated versioning and release creation through GitHub Actions.

## 🚀 How It Works

### Automatic Triggers
- **Every push to `main`** - Creates a new patch release (1.0.0 → 1.0.1)
- **Manual trigger** - You can manually choose version increment type

### Version Increment Rules

The system automatically determines the version increment based on:

1. **Manual Workflow Dispatch** - You choose: patch, minor, or major
2. **Commit Message Keywords**:
   - `[major]` in commit message → Major version (1.0.0 → 2.0.0)
   - `[minor]` in commit message → Minor version (1.0.0 → 1.1.0)
   - Default → Patch version (1.0.0 → 1.0.1)

3. **Skip Release**:
   - `[skip release]` in commit message → No release created

## 📋 Examples

### Automatic Patch Release
```bash
git commit -m "Fix font configuration issue"
git push origin main
# Creates v1.0.1 automatically
```

### Minor Version Release
```bash
git commit -m "[minor] Add new development tools and features"
git push origin main
# Creates v1.1.0 automatically
```

### Major Version Release
```bash
git commit -m "[major] Breaking changes: restructure makefile targets"
git push origin main
# Creates v2.0.0 automatically
```

### Skip Release
```bash
git commit -m "Update documentation [skip release]"
git push origin main
# No release created
```

## 🎛 Manual Release Creation

1. Go to **Actions** tab in GitHub
2. Select **Automated Release** workflow
3. Click **Run workflow**
4. Choose version increment: patch, minor, or major
5. Click **Run workflow**

## 📦 What Gets Created

Each release automatically includes:

- **Git Tag** - Properly formatted (v1.0.1, v1.1.0, etc.)
- **GitHub Release** - With generated release notes
- **Release Notes** - List of commits since last release
- **Installation Instructions** - Always up-to-date
- **Documentation Links** - README, Contributing, Code of Conduct

## 🔧 Technical Details

- **Version Format**: Semantic versioning (MAJOR.MINOR.PATCH)
- **Tag Format**: `v1.0.1`, `v1.1.0`, `v2.0.0`
- **Duplicate Protection**: Won't create duplicate tags
- **Commit History**: Includes all commits since last release
- **Automatic Notes**: Generates release notes from commit messages

## 🛠 Customization

To modify the release automation:

1. Edit `.github/workflows/release.yml`
2. Customize release note templates
3. Adjust version increment logic
4. Modify trigger conditions

## 📊 Current Version Tracking

The system automatically:
- Finds the latest existing tag
- Calculates the next version
- Creates release notes from commit history
- Publishes to GitHub Releases

## 🎯 Best Practices

1. **Use descriptive commit messages** - They become release notes
2. **Use keywords for version control** - `[minor]`, `[major]`, `[skip release]`
3. **Review auto-generated releases** - Check release notes after creation
4. **Manual releases for major changes** - Use workflow dispatch for important releases

---

**🤖 This system ensures consistent, automated releases while maintaining full control over versioning.**