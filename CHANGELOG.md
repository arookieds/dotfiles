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
