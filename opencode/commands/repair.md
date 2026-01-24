---
description: Automated Git and Infrastructure repair tool.
agent: product-owner
---

# Infrastructure Repair Protocol

## Action Plan
1. **Triage**: Run `git fsck` to check for low-level corruption.
2. **Auto-Fix**: 
   - If `invalid object` is found, run `rm .git/index && git reset`.
   - Ensure `scripts/doc_manager.py` is executable.
3. **Verify**: Attempt to run `python3 scripts/doc_manager.py --integrity`.
   - *Self-Correction*: If the script says "unrecognized arguments," the agent must update the local script from the global master template.
4. **Final Sync**: Run the documentation sync to ensure the manifest is healthy.
