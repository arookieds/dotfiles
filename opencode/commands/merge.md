---
description: Approve the current PR, perform a normal merge, and delete the feature branch.
agent: product-owner
---

# Smart Merge Protocol

## Action Plan
1. **Validation**:
   - Verify that a PR exists for the current branch using `gh pr view`.
   - Ensure all CI/CD status checks are passing.
2. **Approval**:
   - Execute `gh pr approve`. (Note: This is useful for self-approving in small teams or signaling readiness).
3. **Execution (The Merge)**:
   - Execute `gh pr merge --merge --delete-branch`.
   - **`--merge`**: Performs a standard merge (creating a merge commit) to preserve the feature's history.
   - **`--delete-branch`**: Automatically deletes the branch on GitHub.
4. **Local Cleanup**:
   - Switch back to the base branch: `git checkout main` (or `master`).
   - Sync local state: `git pull origin main`.
   - Delete the local feature branch: `git branch -d [FEATURE_BRANCH]`.
5. **Final Sync**:
   - Call `python3 scripts/doc_manager.py` to ensure the final manifest reflects the merged state.
