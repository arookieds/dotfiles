---
description: Push branch and trigger the pr-proposer skill.
agent: product-owner
---

# Publish & PR Protocol

## Action Plan
1. **Upstream Sync**:
   - Check if the branch has an upstream. If not, execute `git push -u origin HEAD`.
   - If upstream exists, run `git push`.
2. **Skill Handover**:
   - Once the push is successful, call the specialized PR skill:
   - `opencode run --skill pr-proposer "Create a PR for the current changes. Reference ADR-0003 for security context."`
3. **Verification**:
   - Confirm the PR URL is returned to the console.
