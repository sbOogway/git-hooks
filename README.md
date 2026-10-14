# git-hooks

Shared git hooks for [prek](https://github.com/j178/prek) and [pre-commit](https://pre-commit.com).

| Hook ID | Stage | What it does |
|---|---|---|
| `conventional-commit` | commit-msg | Checks the commit message with gitlint. The title must use [Conventional Commits](https://www.conventionalcommits.org) (`feat`, `fix`, `refactor`, `perf`, `test`, `docs`, `build`, `ci`, `chore`, `style`, `revert`) and have at most 72 characters. |
| `prune-merged-branches` | post-merge | After a pull, deletes the local branches whose upstream branch is gone and whose changes are all in the default branch. It also detects rebase merges. It keeps the current branch and branches with unmerged changes. |

## Use

```yaml
default_install_hook_types: [pre-commit, commit-msg, post-merge]

repos:
  - repo: https://github.com/sbOogway/git-hooks
    rev: v0.2.0
    hooks:
      - id: conventional-commit
      - id: prune-merged-branches
```

Then run `prek install` once in each clone.
