# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Product Owner Agent Enforcement**: Comprehensive skill enforcement rules to prevent bypassing conventional-commits workflow
  - CRITICAL Skill Enforcement Rules (4 non-negotiable behavioral constraints)
  - Skill Enforcement Checklist (8-point verification before git operations)
  - Role Violation Detection (clear PO vs operator role boundaries)
  - User as decision maker, agent as facilitator emphasis
- **Three-Tier Branching Model**: Complete implementation in conventional-commits skill
  - Tier 1: Local Topic Branches (atomic changes)
  - Tier 2: Global Umbrella Branches (feature consolidation)
  - Tier 3: Umbrella Evolution (hierarchical merging)
- **Comprehensive Documentation**: WORKFLOW.md and README.md for conventional-commits skill
  - Real-world scenarios with step-by-step examples
  - Decision trees for branch management
  - Troubleshooting guides and best practices
- **Doc Manager Improvements**: Non-destructive README.md updates
  - Marker-based system for safe content preservation
  - Full TOC generation with directory grouping
  - Three-mode operation (update/append/create)
  - `--force-index` flag for explicit overwrites

### Changed
- **Product Owner Permissions**: Fixed tool/permission contradiction
  - Removed `bash: allow` permission (bash tool disabled)
  - Changed `write: allow` to `write: ask` for safer file modifications
  - Clarified permission model for better security
- **Git Sync Script**: Enhanced with better error handling and user feedback
  - Colored output with progress tracking
  - Conflict detection and error handling
  - Branch validation and existence checks
  - Clear next steps guidance
- **Pre-Commit Review Script**: Improved diagnostics and safety warnings
  - Colored output with visual hierarchy
  - Detailed file staging information
  - Branch type and scope information
  - Commits ahead of main tracking
  - Safety warnings for main/master commits

### Fixed
- **Doc Manager Generate Index**: Prevented destructive README.md overwrites
  - Replaced destructive 'w' mode with intelligent content preservation
  - Implemented marker-based system for safe updates
  - Added proper error handling and docstrings
- **Conventional Commits Skill**: Added explicit consent barrier
  - Mandatory review before commits
  - Explicit user approval required
  - Clear "STOP and WAIT" instructions

### Security
- Removed direct bash access for product-owner agent
- Added mandatory consent barrier for all git operations
- Implemented skill enforcement checklist
- Added role violation detection
- Emphasized user as decision maker

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
