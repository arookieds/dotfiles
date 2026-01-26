# Conventional Commits Examples

This document provides examples of well-formatted commit messages following the Conventional Commits specification.

## Format

```
<type>(<scope>): <description>

[optional body]
[optional footer]
```

## Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes
- **style**: Formatting/styling (no code change)
- **refactor**: Code refactoring
- **perf**: Performance improvements
- **test**: Adding/refactoring tests
- **chore**: Build/maintenance tasks

---

## ✅ Good Examples

### Features
```
feat(auth): add OIDC provider support for Gemini
feat(api): implement exponential backoff retry mechanism
feat(monitoring): add Prometheus metrics for API performance
feat(database): add connection pooling for improved throughput
feat(ui): add dark mode toggle to settings
```

### Bug Fixes
```
fix(auth): prevent token exposure in logs
fix(api): increase timeout from 5s to 30s for slow endpoints
fix(mcp): resolve race condition in devdb connection pool
fix(database): fix N+1 query in user profile endpoint
fix(ui): correct z-index stacking for modal overlays
```

### Documentation
```
docs(readme): update installation instructions for Helix users
docs(api): add API reliability section with examples
docs(security): add MFA setup guide
docs(contributing): clarify branch naming conventions
docs(changelog): document breaking changes in v2.0
```

### Refactoring
```
refactor(ui): move sidebar logic to a custom hook
refactor(error-handling): standardize error responses across API
refactor(database): extract query builder into separate module
refactor(auth): consolidate token validation logic
```

### Performance
```
perf(database): add index on user_id column
perf(api): cache frequently accessed endpoints
perf(ui): lazy load images in gallery component
perf(build): reduce bundle size by 15%
```

### Tests
```
test(auth): add unit tests for OIDC flow
test(api): add integration tests for retry mechanism
test(database): add tests for connection pool edge cases
test(ui): add snapshot tests for modal component
```

### Maintenance
```
chore(deps): update dependencies to latest versions
chore(build): configure GitHub Actions for CI/CD
chore(git): add pre-commit hooks for linting
chore(docker): update base image to Alpine 3.18
```

---

## ❌ Bad Examples (Avoid These)

### Too Vague
```
❌ update stuff
❌ fix things
❌ add features
❌ work on api
❌ multiple changes
```

### Missing Type
```
❌ add OIDC support
❌ fix race condition
❌ update docs
```

### Missing Scope
```
❌ feat: add new feature
❌ fix: resolve issue
❌ docs: update
```

### Too Long
```
❌ feat(auth): add OIDC provider support for Gemini and also implement JWT refresh tokens and add rate limiting to prevent brute force attacks
```

### Imperative vs Descriptive
```
❌ feat(auth): adds OIDC support        (use "add", not "adds")
❌ feat(auth): added OIDC support       (use "add", not "added")
❌ feat(auth): will add OIDC support    (use "add", not "will add")
```

---

## 📋 Commit Message Checklist

Before committing, verify:

- [ ] Type is one of: feat, fix, docs, style, refactor, perf, test, chore
- [ ] Scope is lowercase and descriptive (e.g., "auth", "api", "database")
- [ ] Description starts with lowercase letter
- [ ] Description uses imperative mood ("add", not "adds" or "added")
- [ ] Description is concise (under 50 characters if possible)
- [ ] No period at the end of description
- [ ] Body (if present) explains "why", not "what"
- [ ] Body is wrapped at 72 characters

---

## 🎯 Real-World Scenarios

### Scenario 1: Bug Fix with Context
```
fix(api): increase timeout from 5s to 30s for slow endpoints

The current 5-second timeout is too aggressive for endpoints that
perform complex calculations or database queries. This causes
legitimate requests to fail with timeout errors.

Increasing to 30 seconds allows slow but valid requests to complete
while still protecting against truly hung connections.

Fixes #1234
```

### Scenario 2: Feature with Breaking Change
```
feat(auth): replace session tokens with JWT

BREAKING CHANGE: Session-based authentication is removed.
All clients must migrate to JWT-based authentication.

Migration guide: https://docs.example.com/jwt-migration

- Implement JWT token generation and validation
- Add token refresh endpoint
- Update authentication middleware
- Remove session storage from database

Closes #5678
```

### Scenario 3: Refactoring with Performance Impact
```
refactor(database): extract query builder into separate module

This refactoring improves code organization and enables query
optimization in a future release.

Performance impact: Neutral (no change in query execution)
Code coverage: 95% (all new functions tested)

Related: #9012
```

### Scenario 4: Documentation Update
```
docs(readme): add API reliability section with examples

Add comprehensive documentation for:
- Retry mechanism and exponential backoff
- Timeout configuration
- Error handling best practices
- Example code for common scenarios

Includes troubleshooting guide for common issues.
```

---

## 🔗 Integration with Workflow

### Topic Branch Commits
Each topic branch should have 1-3 commits, each following this format:

```bash
# Topic: topic/fix-api-timeout
git commit -m "fix(api): increase timeout from 5s to 30s"

# Topic: topic/feat-retry-logic
git commit -m "feat(api): implement exponential backoff retry"

# Topic: topic/docs-readme
git commit -m "docs(readme): add API reliability section"
```

### Umbrella Branch Merges
When topics are merged into an umbrella, the individual commits are preserved:

```bash
# feature/api-reliability contains:
# - fix(api): increase timeout from 5s to 30s
# - feat(api): implement exponential backoff retry
# - docs(readme): add API reliability section
```

### PR Description
The PR description should summarize the commits:

```
## Summary
Improve API reliability through timeout adjustment and retry logic

## Changes
- fix(api): increase timeout from 5s to 30s
- feat(api): implement exponential backoff retry
- docs(readme): add API reliability section

## Testing
- Unit tests for retry mechanism: ✓
- Integration tests with slow endpoints: ✓
- Manual testing with production-like load: ✓
```

---

## 📚 References

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Git Commit Best Practices](https://chris.beams.io/posts/git-commit/)

---

## 💡 Tips

1. **Write commits for future you**: Imagine reading this commit in 6 months
2. **One logical change per commit**: Don't mix unrelated changes
3. **Use imperative mood**: "Add feature" not "Added feature"
4. **Explain the why**: The code shows what changed, commit explains why
5. **Keep it concise**: Long commit messages are hard to read in logs
6. **Reference issues**: Use "Fixes #123" or "Closes #456" in body
7. **Atomic commits**: Each commit should be independently testable

---

**Last Updated:** 2026-01-25
