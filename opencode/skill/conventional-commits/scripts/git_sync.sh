#!/bin/bash
# Sync local topics and existing umbrellas into a new global umbrella branch
# Usage: ./git_sync.sh feature/new-umbrella [feature/old-umbrella]

set -e  # Exit on error

NEW_UMBRELLA=$1
OLD_UMBRELLA=$2

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation
if [ -z "$NEW_UMBRELLA" ]; then
  echo -e "${RED}❌ Error: Missing umbrella name${NC}"
  echo ""
  echo "Usage: ./git_sync.sh feature/new-umbrella [feature/old-umbrella]"
  echo ""
  echo "Examples:"
  echo "  ./git_sync.sh feature/api-reliability"
  echo "  ./git_sync.sh feature/api-v1-maintenance feature/api-reliability"
  exit 1
fi

# Validate branch name format
if [[ ! "$NEW_UMBRELLA" =~ ^feature/ ]]; then
  echo -e "${YELLOW}⚠️  Warning: Branch name should start with 'feature/'${NC}"
  echo "   Proceeding anyway, but consider renaming to: feature/$(echo $NEW_UMBRELLA | cut -d'/' -f2-)"
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           GIT SYNC: UMBRELLA CONSOLIDATION                    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# 1. Update main first
echo -e "${BLUE}📍 Step 1: Updating main from origin...${NC}"
if git checkout main > /dev/null 2>&1; then
  if git pull origin main > /dev/null 2>&1; then
    echo -e "${GREEN}✓ main updated${NC}"
  else
    echo -e "${YELLOW}⚠️  Could not pull main (may be offline or no remote)${NC}"
  fi
else
  echo -e "${RED}❌ Error: Could not checkout main${NC}"
  exit 1
fi
echo ""

# 2. Create or checkout the New Umbrella Branch
echo -e "${BLUE}📍 Step 2: Creating/checking out umbrella: $NEW_UMBRELLA${NC}"
if git rev-parse --verify "$NEW_UMBRELLA" > /dev/null 2>&1; then
  echo -e "${YELLOW}   Branch already exists, checking out...${NC}"
  git checkout "$NEW_UMBRELLA" > /dev/null 2>&1
else
  echo -e "${YELLOW}   Creating new branch from main...${NC}"
  git checkout -b "$NEW_UMBRELLA" > /dev/null 2>&1
fi
echo -e "${GREEN}✓ On branch: $NEW_UMBRELLA${NC}"
echo ""

# 3. Merge Old Umbrella if provided
if [ ! -z "$OLD_UMBRELLA" ]; then
  echo -e "${BLUE}📍 Step 3: Merging old umbrella: $OLD_UMBRELLA${NC}"
  if git rev-parse --verify "$OLD_UMBRELLA" > /dev/null 2>&1; then
    if git merge "$OLD_UMBRELLA" --no-edit > /dev/null 2>&1; then
      echo -e "${GREEN}✓ Merged: $OLD_UMBRELLA${NC}"
    else
      echo -e "${RED}❌ Merge conflict with $OLD_UMBRELLA${NC}"
      echo "   Resolve conflicts manually and commit, then continue."
      exit 1
    fi
  else
    echo -e "${RED}❌ Error: Old umbrella branch '$OLD_UMBRELLA' not found${NC}"
    exit 1
  fi
  echo ""
fi

# 4. Find and Merge Topic Branches
echo -e "${BLUE}📍 Step 4: Finding and merging topic branches...${NC}"
TOPICS=$(git branch --list 'topic/*' | sed 's/^[[:space:]]*\*\?[[:space:]]*//')

if [ -z "$TOPICS" ]; then
  echo -e "${YELLOW}   No topic branches found${NC}"
else
  TOPIC_COUNT=$(echo "$TOPICS" | wc -l)
  echo -e "${YELLOW}   Found $TOPIC_COUNT topic branch(es)${NC}"
  echo ""
  
  for TOPIC in $TOPICS; do
    # Skip if topic is already merged
    if git merge-base --is-ancestor "$TOPIC" HEAD 2>/dev/null; then
      echo -e "${YELLOW}   ⊘ Already merged: $TOPIC${NC}"
    else
      echo -e "${YELLOW}   → Merging: $TOPIC${NC}"
      if git merge "$TOPIC" --no-edit > /dev/null 2>&1; then
        echo -e "${GREEN}     ✓ Merged: $TOPIC${NC}"
      else
        echo -e "${RED}     ❌ Merge conflict with $TOPIC${NC}"
        echo "     Resolve conflicts manually and commit, then continue."
        exit 1
      fi
    fi
  done
fi
echo ""

# 5. Summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}✅ SYNC COMPLETE${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📊 Summary:${NC}"
echo -e "   Umbrella Branch: ${GREEN}$NEW_UMBRELLA${NC}"
if [ ! -z "$OLD_UMBRELLA" ]; then
  echo -e "   Merged From: ${GREEN}$OLD_UMBRELLA${NC}"
fi
echo -e "   Topic Branches: ${GREEN}${TOPIC_COUNT:-0}${NC}"
echo ""
echo -e "${BLUE}📝 Next Steps:${NC}"
echo -e "   1. Review changes: ${YELLOW}git log main..$NEW_UMBRELLA${NC}"
echo -e "   2. Push to remote: ${YELLOW}git push origin $NEW_UMBRELLA${NC}"
echo -e "   3. Create PR on GitHub"
echo -e "   4. After merge, delete branch: ${YELLOW}git branch -d $NEW_UMBRELLA${NC}"
echo ""
