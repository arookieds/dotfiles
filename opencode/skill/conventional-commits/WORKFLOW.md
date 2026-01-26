# Conventional Commits Skill: Complete Workflow Guide

This guide demonstrates how the Three-Tier Branching Model works in practice, with real-world scenarios and examples.

---

## Overview: Three-Tier Branching Model

```
┌─────────────────────────────────────────────────────────────┐
│ TIER 1: LOCAL TOPIC BRANCHES (Atomic Changes)              │
│ ─────────────────────────────────────────────────────────── │
│ topic/fix-api-timeout                                       │
│ topic/feat-retry-logic                                      │
│ topic/docs-readme                                           │
│ topic/refactor-error-handling                               │
└─────────────────────────────────────────────────────────────┘
                            ↓
                    (Ready to sync)
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ TIER 2: GLOBAL UMBRELLA BRANCHES (Feature/Scope)           │
│ ─────────────────────────────────────────────────────────── │
│ feature/api-reliability                                     │
│ (Contains: fix-api-timeout + feat-retry-logic)              │
└─────────────────────────────────────────────────────────────┘
                            ↓
                (Scope expands, name becomes inaccurate)
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ TIER 3: UMBRELLA EVOLUTION (Hierarchical Merging)          │
│ ─────────────────────────────────────────────────────────── │
│ feature/api-v1-maintenance                                  │
│ (Contains: old umbrella + new topics)                       │
│ (Merged from: feature/api-reliability + topic/docs-readme)  │
└─────────────────────────────────────────────────────────────┘
                            ↓
                    (Ready for PR)
```

---

## Scenario 1: Simple Multi-Topic Development

### Situation
You're working on API reliability improvements. You have three independent changes:
1. Fix API timeout issue
2. Add retry logic
3. Update documentation

### Step-by-Step Workflow

#### Phase 1: Development (Creating Topic Branches)

**Change 1: Fix API Timeout**
```bash
# I detect you're on main with changes
# I propose: topic/fix-api-timeout
git checkout -b topic/fix-api-timeout
# ... you make changes ...
git add src/api/timeout.py
git commit -m "fix(api): increase timeout from 5s to 30s for slow endpoints"
```

**Change 2: Add Retry Logic**
```bash
# You switch back to main and make another change
git checkout main
git checkout -b topic/feat-retry-logic
# ... you make changes ...
git add src/api/retry.py
git commit -m "feat(api): implement exponential backoff retry mechanism"
```

**Change 3: Update Documentation**
```bash
# Another independent change
git checkout main
git checkout -b topic/docs-readme
# ... you make changes ...
git add README.md
git commit -m "docs(readme): add API reliability section with examples"
```

**Result after Phase 1:**
```
Local branches:
  main
  topic/fix-api-timeout (1 commit)
  topic/feat-retry-logic (1 commit)
  topic/docs-readme (1 commit)
```

#### Phase 2: Sync to Umbrella (Ready to Push)

**You say:** "I'm ready to push these changes"

**I execute:**
```bash
# Pre-commit review
bash ./opencode/skill/conventional-commits/scripts/review.sh

# Output shows all staged changes across topics
# I propose: feature/api-reliability

# I ask: "I have prepared the umbrella branch feature/api-reliability. 
#         Should I proceed with merging all topics?"

# You say: "Yes"

# I execute:
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh feature/api-reliability

# This:
# 1. Updates main from origin
# 2. Creates feature/api-reliability from main
# 3. Merges topic/fix-api-timeout
# 4. Merges topic/feat-retry-logic
# 5. Merges topic/docs-readme
# All into feature/api-reliability

# Result: feature/api-reliability contains all 3 commits
git push origin feature/api-reliability
```

**Result after Phase 2:**
```
Remote branches:
  origin/main
  origin/feature/api-reliability (contains 3 commits)

Local branches:
  main
  feature/api-reliability
  topic/fix-api-timeout
  topic/feat-retry-logic
  topic/docs-readme
```

---

## Scenario 2: Umbrella Evolution (Scope Expansion)

### Situation
After pushing `feature/api-reliability`, you realize the scope has expanded:
- You need to add error handling improvements
- You need to add monitoring/logging
- The name "api-reliability" no longer captures all the work

This is when **Umbrella Evolution** kicks in.

### Step-by-Step Workflow

#### Phase 1: New Topics (Continuing Development)

**Change 4: Error Handling**
```bash
git checkout main
git checkout -b topic/refactor-error-handling
# ... you make changes ...
git add src/api/errors.py
git commit -m "refactor(api): standardize error handling across endpoints"
```

**Change 5: Monitoring**
```bash
git checkout main
git checkout -b topic/feat-api-monitoring
# ... you make changes ...
git add src/monitoring/api_metrics.py
git commit -m "feat(monitoring): add Prometheus metrics for API performance"
```

**Result after Phase 1:**
```
Local branches:
  main
  feature/api-reliability (already pushed)
  topic/fix-api-timeout
  topic/feat-retry-logic
  topic/docs-readme
  topic/refactor-error-handling (NEW)
  topic/feat-api-monitoring (NEW)
```

#### Phase 2: Recognize Scope Expansion

**You say:** "I have more changes, but 'api-reliability' doesn't describe everything anymore"

**I analyze:**
- Old umbrella: `feature/api-reliability` (timeout fix + retry logic + docs)
- New topics: `topic/refactor-error-handling`, `topic/feat-api-monitoring`
- Combined scope: API improvements + monitoring + error handling

**I propose:** "The scope has expanded. I recommend evolving to `feature/api-v1-maintenance` which better describes the complete work."

#### Phase 3: Umbrella Evolution (Hierarchical Merge)

**You say:** "Yes, evolve the umbrella"

**I execute:**
```bash
# Pre-commit review
bash ./opencode/skill/conventional-commits/scripts/review.sh

# I ask: "I have prepared the evolved umbrella branch feature/api-v1-maintenance.
#         Should I proceed with merging the old umbrella and new topics?"

# You say: "Yes"

# I execute:
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/api-v1-maintenance \
  feature/api-reliability

# This:
# 1. Updates main from origin
# 2. Creates feature/api-v1-maintenance from main
# 3. Merges feature/api-reliability (the old umbrella with 3 commits)
# 4. Merges topic/refactor-error-handling
# 5. Merges topic/feat-api-monitoring
# All into feature/api-v1-maintenance

# Result: feature/api-v1-maintenance contains:
#   - All 3 commits from old umbrella
#   - 2 new commits from new topics
#   - Total: 5 commits

git push origin feature/api-v1-maintenance
```

**Result after Phase 3:**
```
Remote branches:
  origin/main
  origin/feature/api-reliability (old umbrella, still there)
  origin/feature/api-v1-maintenance (new evolved umbrella, ready for PR)

Local branches:
  main
  feature/api-reliability (old)
  feature/api-v1-maintenance (new, evolved)
  topic/fix-api-timeout
  topic/feat-retry-logic
  topic/docs-readme
  topic/refactor-error-handling
  topic/feat-api-monitoring
```

---

## Scenario 3: Multiple Umbrella Merges (Complex Evolution)

### Situation
You have two separate feature umbrellas that need to be consolidated:
- `feature/api-reliability` (API improvements)
- `feature/database-optimization` (Database improvements)

And you want to merge them under a single release umbrella.

### Step-by-Step Workflow

#### Phase 1: Two Separate Umbrellas Exist

```
feature/api-reliability
  ├─ topic/fix-api-timeout
  ├─ topic/feat-retry-logic
  └─ topic/docs-readme

feature/database-optimization
  ├─ topic/perf-query-indexing
  ├─ topic/refactor-connection-pool
  └─ topic/docs-db-guide
```

#### Phase 2: Consolidate Under Release Umbrella

**You say:** "I want to consolidate both features into a release"

**I propose:** "I recommend creating `feature/v1-0-release` that merges both umbrellas"

**I execute:**
```bash
# First merge: Bring in api-reliability
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/v1-0-release \
  feature/api-reliability

# This creates feature/v1-0-release with all api-reliability commits

# Then merge: Bring in database-optimization
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/v1-0-release \
  feature/database-optimization

# This merges database-optimization into feature/v1-0-release
```

**Result:**
```
feature/v1-0-release (NEW)
  ├─ feature/api-reliability (merged)
  │   ├─ topic/fix-api-timeout
  │   ├─ topic/feat-retry-logic
  │   └─ topic/docs-readme
  └─ feature/database-optimization (merged)
      ├─ topic/perf-query-indexing
      ├─ topic/refactor-connection-pool
      └─ topic/docs-db-guide
```

---

## Key Decision Points

### When to Create a New Topic Branch?
✅ **Create new topic when:**
- Change is independent and can be reviewed separately
- Change affects a different part of the codebase
- Change has a different commit type (feat vs fix vs docs)
- You want atomic, testable units

❌ **Don't create new topic when:**
- Change is a follow-up to fix the previous topic
- Change is a minor adjustment to the same feature

### When to Evolve the Umbrella?
✅ **Evolve umbrella when:**
- New topics make the current name inaccurate
- Scope has expanded significantly
- You're consolidating multiple umbrellas
- The PR description would be confusing with the old name

❌ **Don't evolve when:**
- Just adding one more small topic
- The current name still accurately describes all work
- You're about to merge to main anyway

### When to Merge Umbrellas?
✅ **Merge umbrellas when:**
- Creating a release that combines multiple features
- Consolidating related work streams
- Preparing for a major version bump
- Multiple teams' work needs to go together

❌ **Don't merge when:**
- Features are independent and should have separate PRs
- You want to preserve separate review history
- Features have different release timelines

---

## Command Reference

### Create a Topic Branch
```bash
git checkout main
git checkout -b topic/descriptive-name
# Make changes
git add .
git commit -m "type(scope): description"
```

### Sync Topics to Umbrella (First Time)
```bash
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh feature/umbrella-name
```

### Evolve Umbrella (Merge Old + New Topics)
```bash
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/new-umbrella-name \
  feature/old-umbrella-name
```

### Merge Multiple Umbrellas
```bash
# Create new umbrella with first umbrella
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/release-name \
  feature/first-umbrella

# Merge second umbrella into it
bash ./opencode/skill/conventional-commits/scripts/git_sync.sh \
  feature/release-name \
  feature/second-umbrella
```

### Pre-Commit Review
```bash
bash ./opencode/skill/conventional-commits/scripts/review.sh
```

### Push to Remote
```bash
git push origin feature/umbrella-name
```

---

## Commit Message Examples

### Good Examples (Atomic, Clear)
```
feat(auth): add OIDC provider support
fix(api): increase timeout from 5s to 30s
refactor(error-handling): standardize error responses
docs(readme): add API reliability section
perf(database): add index on user_id column
test(api): add retry logic unit tests
```

### Bad Examples (Too Broad, Unclear)
```
update stuff
fix things
add features
work on api
multiple changes
```

---

## Safety Guarantees

This workflow provides:

1. **Atomic Changes**: Each topic branch is a single, reviewable unit
2. **Clear History**: Commit messages explain the "why" of each change
3. **Flexible Scope**: Umbrellas can evolve as scope changes
4. **Hierarchical Organization**: Multiple umbrellas can be consolidated
5. **Manual Approval**: Every commit/merge requires explicit user consent
6. **Pre-Commit Review**: Changes are reviewed before committing
7. **No Direct Main Commits**: All work goes through branches

---

## Troubleshooting

### "My umbrella branch has merge conflicts"
```bash
# Resolve conflicts manually
git status  # See conflicted files
# Edit files to resolve
git add .
git commit -m "chore(merge): resolve conflicts from umbrella evolution"
```

### "I want to undo a topic merge"
```bash
git reset --soft HEAD~1  # Undo last merge, keep changes staged
# Or if you want to completely undo:
git reset --hard HEAD~1
```

### "I created a topic but realized it should be split"
```bash
# Create a new topic for the second part
git checkout -b topic/new-part
git reset --soft HEAD~1  # Undo the commit
# Selectively stage and commit
git add file1.py
git commit -m "feat(scope): first part"
git add file2.py
git commit -m "feat(scope): second part"
```

### "I want to see what's in my umbrella"
```bash
git log main..feature/umbrella-name  # Commits in umbrella but not main
git diff main..feature/umbrella-name  # All changes in umbrella
```

---

## Best Practices

1. **Keep Topics Small**: Aim for 1-3 commits per topic
2. **Use Descriptive Names**: `topic/fix-auth-leak` > `topic/fix-1`
3. **Commit Frequently**: Don't wait until the end to commit
4. **Review Before Syncing**: Use `review.sh` to check what you're committing
5. **Evolve Umbrellas Proactively**: Don't wait until the PR is confusing
6. **Document Your Decisions**: Add notes to PR about why umbrella evolved
7. **Clean Up Old Umbrellas**: After merging to main, delete old umbrella branches

---

## Integration with PR Workflow

After your umbrella branch is ready:

1. Push umbrella to remote: `git push origin feature/umbrella-name`
2. Create PR from umbrella to main
3. Use `pr-proposer` skill to generate PR description from changelog
4. Get review approval
5. Use `smart-merge` skill to merge PR
6. Delete umbrella branch: `git branch -d feature/umbrella-name`

---

## FAQ

**Q: Can I have multiple umbrellas at the same time?**
A: Yes! Each umbrella is independent. You can work on multiple features in parallel.

**Q: What if I commit to the wrong topic branch?**
A: Use `git reset --soft HEAD~1` to undo the commit and move changes to staging, then commit to the correct branch.

**Q: Should I delete topic branches after merging to umbrella?**
A: Not immediately. Keep them until the umbrella is merged to main, then delete them for cleanliness.

**Q: Can I manually edit an umbrella branch?**
A: Yes, but avoid it. The skill is designed to manage umbrellas automatically. If you need to edit, do it before syncing.

**Q: What if the umbrella branch already exists?**
A: The `git_sync.sh` script checks out the existing branch and merges into it, so it's safe to run multiple times.

