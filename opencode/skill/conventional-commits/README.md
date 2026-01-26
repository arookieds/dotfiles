# Conventional Commits Skill

A comprehensive git workflow skill that enforces atomic commits, intelligent branching, and hierarchical umbrella management for complex multi-topic development.

## 📋 Overview

This skill implements a **Three-Tier Branching Model** that enables:

1. **Atomic Topic Branches** - Each independent change in its own branch
2. **Intelligent Umbrella Branches** - Consolidate related topics into feature branches
3. **Umbrella Evolution** - Dynamically rename and reorganize umbrellas as scope changes
4. **Mandatory Safety Checks** - Pre-commit review and explicit user consent

## 🎯 Key Features

✅ **Multi-Commit Orchestration** - Create multiple commits across different topic branches  
✅ **Hierarchical Merging** - Merge old umbrellas into new ones when scope expands  
✅ **Atomic Changes** - Each topic branch is a single, reviewable unit  
✅ **Safety Barriers** - Manual approval required before every commit/merge  
✅ **Pre-Commit Review** - Detailed diff preview before committing  
✅ **Intelligent Naming** - Proposes descriptive branch names based on changes  
✅ **Conflict Detection** - Alerts on merge conflicts and prevents auto-resolution  
✅ **Clean History** - Conventional Commits format for clear commit messages  

## 📁 Files in This Skill

```
opencode/skill/conventional-commits/
├── SKILL.md                    # Skill definition (loaded by Claude Code)
├── README.md                   # This file
├── WORKFLOW.md                 # Detailed workflow guide with examples
├── scripts/
│   ├── review.sh              # Pre-commit review script
│   ├── git_sync.sh            # Umbrella consolidation script
│   └── examples/
│       └── good-commits.md    # Commit message examples
└── examples/
    └── good-commits.md        # Commit message examples
```

## 🚀 Quick Start

### Scenario 1: Simple Multi-Topic Development

```bash
# Development Phase: Create multiple topic branches
git checkout -b topic/fix-api-timeout
# ... make changes ...
git commit -m "fix(api): increase timeout from 5s to 30s"

git checkout main
git checkout -b topic/feat-retry-logic
# ... make changes ...
git commit -m "feat(api): implement exponential backoff retry"

# Sync Phase: Consolidate to umbrella
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh feature/api-reliability
git push origin feature/api-reliability
```

### Scenario 2: Umbrella Evolution

```bash
# You have feature/api-reliability with 2 commits
# You add more topics that expand the scope

git checkout main
git checkout -b topic/docs-readme
# ... make changes ...
git commit -m "docs(readme): add API reliability section"

# Evolve the umbrella to reflect new scope
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/api-v1-maintenance \
  feature/api-reliability

git push origin feature/api-v1-maintenance
```

## 📖 Documentation

### For Detailed Workflows
See **[WORKFLOW.md](./WORKFLOW.md)** for:
- Step-by-step scenarios with examples
- Decision trees for when to create/evolve branches
- Troubleshooting guide
- Best practices and anti-patterns
- Integration with PR workflow

### For Commit Message Examples
See **[examples/good-commits.md](./examples/good-commits.md)** for:
- Conventional Commits format
- Good vs bad examples
- Type definitions (feat, fix, docs, etc.)

## 🔧 Scripts Reference

### review.sh - Pre-Commit Review
```bash
bash ./opencode/skill/conventional-commits/scripts/review.sh
```

**Output includes:**
- Current branch name
- Staged files for commit
- Unstaged changes warning
- Change statistics
- Diff preview (first 50 lines)
- Branch type and scope
- Commits ahead of main

### git_sync.sh - Umbrella Consolidation

**Merge topics into new umbrella:**
```bash
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh feature/umbrella-name
```

**Evolve umbrella (merge old + new topics):**
```bash
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/new-umbrella-name \
  feature/old-umbrella-name
```

**Features:**
- Validates branch names
- Updates main from origin
- Creates/checks out umbrella branch
- Merges old umbrella if provided
- Finds and merges all topic branches
- Detects already-merged topics
- Handles merge conflicts gracefully
- Provides colored output with progress
- Suggests next steps

## 📋 Commit Message Format

All commits must follow **Conventional Commits** format:

```
<type>(<scope>): <description>

[optional body]
```

### Types
- **feat** - A new feature
- **fix** - A bug fix
- **docs** - Documentation changes
- **style** - Formatting/styling (no code change)
- **refactor** - Code refactoring
- **perf** - Performance improvements
- **test** - Adding/refactoring tests
- **chore** - Build/maintenance tasks

### Examples
```
feat(auth): add OIDC provider support
fix(api): increase timeout from 5s to 30s
refactor(error-handling): standardize error responses
docs(readme): add API reliability section
perf(database): add index on user_id column
```

## 🌿 Three-Tier Branching Model

### Tier 1: Topic Branches (Local)
- **Pattern:** `topic/descriptive-name`
- **Purpose:** Atomic, independent changes
- **Commits:** 1-3 per topic
- **Example:** `topic/fix-api-timeout`, `topic/feat-retry-logic`

### Tier 2: Umbrella Branches (Global)
- **Pattern:** `feature/descriptive-name`
- **Purpose:** Consolidate related topics for PR
- **Commits:** Multiple (merged from topics)
- **Example:** `feature/api-reliability`, `feature/database-optimization`

### Tier 3: Umbrella Evolution (Hierarchical)
- **Pattern:** `feature/evolved-name`
- **Purpose:** Merge old umbrellas when scope expands
- **Commits:** All previous + new topics
- **Example:** `feature/api-v1-maintenance` (evolved from `feature/api-reliability`)

## 🛡️ Safety Mechanisms

### 1. Zero-Commit Rule for Main
- ❌ Never commit directly to `main` or `master`
- ✅ All work goes through topic/feature branches

### 2. Pre-Commit Review (Mandatory)
- Must execute `review.sh` before committing
- Shows detailed diff preview
- Alerts on unstaged changes
- Displays change statistics

### 3. Explicit User Consent (The Barrier)
- Agent stops after showing review
- Asks: "Should I proceed?"
- Only proceeds on explicit "Yes", "Go", or "Proceed"
- Prevents accidental commits

### 4. Merge Conflict Detection
- Detects conflicts during umbrella sync
- Stops and asks user to resolve manually
- Prevents auto-resolution that could lose data

### 5. Branch Validation
- Validates branch names match patterns
- Checks branch existence before operations
- Prevents operations on non-existent branches

## 🔄 Workflow Integration

### With PR Workflow
1. Create topic branches and commit changes
2. Sync to umbrella branch using `git_sync.sh`
3. Push umbrella to remote
4. Create PR from umbrella to main
5. Use `pr-proposer` skill to generate PR description
6. Get review approval
7. Use `smart-merge` skill to merge PR
8. Delete umbrella branch

### With Other Skills
- **pii-guard**: Scans for sensitive data before commits
- **pr-proposer**: Generates PR descriptions from changelog
- **smart-merge**: Merges PRs with validation
- **changelog-automation**: Updates CHANGELOG.md after commits
- **adr-manager**: Documents architectural decisions

## ❓ FAQ

**Q: Can I have multiple umbrellas at the same time?**  
A: Yes! Each umbrella is independent. You can work on multiple features in parallel.

**Q: What if I commit to the wrong topic branch?**  
A: Use `git reset --soft HEAD~1` to undo and move changes to staging.

**Q: Should I delete topic branches after merging to umbrella?**  
A: Keep them until umbrella is merged to main, then delete for cleanliness.

**Q: Can I manually edit an umbrella branch?**  
A: Avoid it. The skill manages umbrellas automatically. If needed, do it before syncing.

**Q: What if the umbrella branch already exists?**  
A: The script checks out the existing branch and merges into it safely.

**Q: How do I handle merge conflicts?**  
A: Resolve manually in your editor, then `git add .` and `git commit`.

**Q: Can I merge multiple umbrellas?**  
A: Yes! Run `git_sync.sh` multiple times with different old umbrellas.

## 📚 Examples

### Example 1: Bug Fix + Feature + Docs
```bash
# Topic 1: Fix bug
git checkout -b topic/fix-auth-leak
git commit -m "fix(auth): prevent token exposure in logs"

# Topic 2: Add feature
git checkout main
git checkout -b topic/feat-mfa
git commit -m "feat(auth): add multi-factor authentication"

# Topic 3: Update docs
git checkout main
git checkout -b topic/docs-security
git commit -m "docs(security): add MFA setup guide"

# Consolidate
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh feature/auth-improvements
git push origin feature/auth-improvements
```

### Example 2: Scope Expansion
```bash
# Initial umbrella
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh feature/api-v1

# Later: Add monitoring
git checkout main
git checkout -b topic/feat-monitoring
git commit -m "feat(monitoring): add Prometheus metrics"

# Evolve umbrella
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/api-v1-release \
  feature/api-v1
git push origin feature/api-v1-release
```

### Example 3: Release Consolidation
```bash
# Merge multiple features into release
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/v2-0-release \
  feature/api-improvements

bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/v2-0-release \
  feature/database-optimization

git push origin feature/v2-0-release
```

## 🐛 Troubleshooting

### Merge Conflicts
```bash
# Resolve conflicts in your editor
git status  # See conflicted files
# Edit files
git add .
git commit -m "chore(merge): resolve conflicts"
```

### Undo Last Merge
```bash
git reset --soft HEAD~1  # Keep changes staged
# or
git reset --hard HEAD~1  # Discard changes
```

### Split a Topic
```bash
git reset --soft HEAD~1  # Undo commit
git add file1.py
git commit -m "feat(scope): part 1"
git add file2.py
git commit -m "feat(scope): part 2"
```

### View Umbrella Contents
```bash
git log main..feature/umbrella-name  # Commits in umbrella
git diff main..feature/umbrella-name  # All changes
```

## 📞 Support

For issues or questions:
1. Check [WORKFLOW.md](./WORKFLOW.md) for detailed scenarios
2. Review [examples/good-commits.md](./examples/good-commits.md) for commit format
3. Run `review.sh` to diagnose current state
4. Check git status: `git status`, `git log`, `git branch -a`

## 📝 License

Part of the OpenCode agent framework.

---

**Last Updated:** 2026-01-25  
**Version:** 3.0 (Three-Tier Branching with Umbrella Evolution)
