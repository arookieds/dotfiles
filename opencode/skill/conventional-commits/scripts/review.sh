#!/bin/bash

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           PRE-COMMIT REVIEW REPORT                            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Current branch info
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current Branch: $CURRENT_BRANCH"
echo ""

# Check if on main/master (safety check)
if [[ "$CURRENT_BRANCH" == "main" || "$CURRENT_BRANCH" == "master" ]]; then
  echo "⚠️  WARNING: You are on $CURRENT_BRANCH!"
  echo "   Commits should NOT go directly to main/master."
  echo "   Create a topic/ or feature/ branch first."
  echo ""
fi

# Staged files
echo "📄 Files Staged for Commit:"
if git diff --cached --name-only | grep -q .; then
  git diff --cached --name-only | sed 's/^/   ✓ /'
else
  echo "   (No staged files)"
fi
echo ""

# Unstaged changes
echo "📝 Unstaged Changes:"
if git diff --name-only | grep -q .; then
  echo "   ⚠️  The following files have unstaged changes:"
  git diff --name-only | sed 's/^/   • /'
else
  echo "   ✓ All changes are staged"
fi
echo ""

# Summary statistics
echo "📊 Change Summary:"
git diff --cached --stat | sed 's/^/   /'
echo ""

# Diff preview (first 50 lines)
echo "🔍 Change Preview (first 50 lines):"
echo "   ─────────────────────────────────────────────────────────────"
git diff --cached | head -50 | sed 's/^/   /'
if [ $(git diff --cached | wc -l) -gt 50 ]; then
  echo "   ... (truncated, use 'git diff --cached' to see full diff)"
fi
echo "   ─────────────────────────────────────────────────────────────"
echo ""

# Topic/Feature branch info
echo "🌿 Branch Information:"
if [[ "$CURRENT_BRANCH" == topic/* ]]; then
  echo "   Type: Topic Branch (Atomic change)"
  echo "   Scope: $(echo $CURRENT_BRANCH | cut -d'/' -f2-)"
elif [[ "$CURRENT_BRANCH" == feature/* ]]; then
  echo "   Type: Feature/Umbrella Branch"
  echo "   Scope: $(echo $CURRENT_BRANCH | cut -d'/' -f2-)"
else
  echo "   Type: Other ($CURRENT_BRANCH)"
fi
echo ""

# Commits ahead of main
COMMITS_AHEAD=$(git rev-list --count main..$CURRENT_BRANCH 2>/dev/null || echo "0")
echo "📈 Commits ahead of main: $COMMITS_AHEAD"
echo ""

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║ Review the changes above. Proceed only if everything looks OK. ║"
echo "╚════════════════════════════════════════════════════════════════╝"
