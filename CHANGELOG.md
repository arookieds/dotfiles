# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- **Product Owner Agent Permissions**: Refactored permission model from boolean tools config to granular permission grants
  - Converted `tools:` section to `permission:` section with default-deny pattern
  - Added granular bash command controls (`git add`, `git status`, `git diff` allowed; `git reset` denied)
  - Maintained skill delegation permissions for data-engineer and ai-engineer agents
- **Agent Access Control Refinements**: Enhanced life-coach and product-owner agent permissions (9a5e1b7)
  - life-coach: Added granular bash command permissions for scripts and git operations
  - product-owner: Added bash and git permissions for operational tasks (`git log`, `git checkout -b`, `head`, `tail`)
  - Removed deprecated `lifecoach-mcp-server` permission entry
  - Cleaned up opencode.json configuration
- **MCP Access Grants**: Granted product-owner agent access to critical MCPs (5b42429)
  - GitHub MCP (`github*`) for PR creation and repository management
  - Context7 MCP for documentation queries and context management
  - Playwright MCP for browser automation capabilities
- **Enhanced Agent Bash Permissions**: Added utility commands to both agents
  - life-coach & product-owner: Added `curl`, `jq`, `python3`, `uv`, `uvx`, `cat` commands
  - life-coach: Updated path patterns to absolute paths for consistency
- **MCP Configuration Updates**: Added and refined lifecoach MCPs
  - Added lifecoach-mcp-postgres for database operations
  - Added lifecoach-mcp-filesystem for file system access
  - Disabled lifecoach-mcp-server (legacy) in favor of new MCPs
- **Shell Configuration Fix**: Updated Nushell config to use `$nu.home-dir` instead of deprecated `$nu.home-path`
- **Agent Permission Refinements**:
  - product-owner: Added `lifecoach*` MCP permission
  - Removed unnecessary `sh *` permission from product-owner

## [0.1.0] - 2026-01-25

### Added
- Initial OpenCode agent framework setup
- Product Owner, AI Engineer, Data Engineer, and other specialized agents
- Conventional Commits skill with git safety protocols
- Project onboarding skill with documentation management
- PII-Guard security skill
- Changelog automation and ADR management skills
- PR proposer skill for intelligent PR generation
- Smart merge and repair protocols
- MCP integrations (devdb, github, playwright, context7)

### Features
- Three-tier branching model for complex development workflows
- Atomic commits with conventional format
- Hierarchical umbrella branch management
- Pre-commit security scanning
- Git integrity verification
- Documentation synchronization
- Stakeholder-aligned product management

---

[Unreleased]: https://github.com/arookieds/dotfiles/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/arookieds/dotfiles/releases/tag/v0.1.0
