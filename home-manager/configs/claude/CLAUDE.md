# Git workflow

- **Conventional commits.** Every commit message must follow the Conventional
  Commits spec: `type(scope): summary` (e.g. `feat(auth): add token refresh`).
  Allowed types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `build`,
  `ci`, `perf`, `style`.
- **Atomic commits.** Each commit must contain exactly one logical change.
  Do not bundle unrelated edits; split staging with `git add -p` when needed.
- **No self-attribution.** Never add a `Co-Authored-By` trailer or any
  "Generated with Claude Code" line to commits.
- **Squash check before merge.** Before declaring a PR ready to merge, review
  the branch history (`git log --oneline main..HEAD`) and check whether commits
  should be squashed or reordered to keep history clean — e.g. fold "fix typo"
  / "address review" commits into the commit they belong with. Propose the
  squash plan and ask before rewriting history.
