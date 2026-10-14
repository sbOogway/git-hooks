#!/usr/bin/env bash
set -euo pipefail

git fetch --prune --quiet

current=$(git branch --show-current)
base=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD || echo origin/main)

# A rebase merge creates new commits, so also compare the changes, not only the commits.
is_merged() {
    git merge-base --is-ancestor "$1" "$base" || ! git cherry "$base" "$1" | grep -q '^+'
}

git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads |
    awk '$2 == "[gone]" { print $1 }' |
    while read -r branch; do
        [[ "$branch" == "$current" ]] && continue
        if is_merged "$branch"; then
            git branch -D "$branch"
        else
            echo "prune-merged-branches: kept $branch, not fully merged" >&2
        fi
    done
