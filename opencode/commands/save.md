---
description: Intelligent, secure snapshot of development progress.
agent: product-owner
---

# Smart Save Protocol

## Action Plan
1. **Branch Triage**:
   - Check current branch via `git branch --show-current`.
   - If branch is `main` or `master`, block execution and warn the user: "⛔ Direct commits to protected branches are disabled."
2. **Pre-Flight Security**:
   - Run `opencode run --agent product-owner "HEADLESS: pii-guard scan"`.
   - If PII/PHI is found, **ABORT** and show remediation.
3. **Drafting (AI Summary)**:
   - If `$ARGUMENTS` is provided, use it as the primary intent.
   - If no arguments, analyze the diff (`git diff --cached`) to understand the changes.
4. **Message Generation**:
   - Construct a [Conventional Commits](https://www.conventionalcommits.org/) message (e.g., `feat:`, `fix:`, `chore:`).
5. **Execution**:
   - **Stash Check**: If there are untracked files, `git stash -u` before committing and `git stash pop` after.
   - Run `git commit -m "[AI Message]"`.
6. **Integrity Sync**:
   - Call `python3 scripts/doc_manager.py` to update the documentation manifest.
