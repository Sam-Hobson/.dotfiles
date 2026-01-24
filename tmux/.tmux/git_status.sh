#!/bin/bash

# Git status script for tmux status line (p10k-style)
# Usage: git_status.sh [directory]

dir="${1:-$(pwd)}"

# Change to the directory
cd "$dir" 2>/dev/null || exit 0

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    exit 0
fi

# Get the git directory
git_dir=$(git rev-parse --git-dir 2>/dev/null)

# Determine current branch or state
branch=""
if [ -f "$git_dir/HEAD" ]; then
    head=$(cat "$git_dir/HEAD")
    if [[ "$head" =~ ^ref:\ refs/heads/(.+)$ ]]; then
        branch="${BASH_REMATCH[1]}"
    else
        # Detached HEAD - show short commit hash
        branch=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
        branch="@$branch"
    fi
fi

# Detect ongoing git actions
action=""
if [ -d "$git_dir/rebase-merge" ]; then
    if [ -f "$git_dir/rebase-merge/interactive" ]; then
        action="REBASE-i"
    else
        action="REBASE-m"
    fi
    # Show progress
    step=$(cat "$git_dir/rebase-merge/msgnum" 2>/dev/null)
    total=$(cat "$git_dir/rebase-merge/end" 2>/dev/null)
    if [ -n "$step" ] && [ -n "$total" ]; then
        action="$action $step/$total"
    fi
elif [ -d "$git_dir/rebase-apply" ]; then
    if [ -f "$git_dir/rebase-apply/rebasing" ]; then
        action="REBASE"
    elif [ -f "$git_dir/rebase-apply/applying" ]; then
        action="AM"
    else
        action="AM/REBASE"
    fi
    step=$(cat "$git_dir/rebase-apply/next" 2>/dev/null)
    total=$(cat "$git_dir/rebase-apply/last" 2>/dev/null)
    if [ -n "$step" ] && [ -n "$total" ]; then
        action="$action $step/$total"
    fi
elif [ -f "$git_dir/MERGE_HEAD" ]; then
    action="MERGING"
elif [ -f "$git_dir/CHERRY_PICK_HEAD" ]; then
    action="CHERRY-PICKING"
elif [ -f "$git_dir/REVERT_HEAD" ]; then
    action="REVERTING"
elif [ -f "$git_dir/BISECT_LOG" ]; then
    action="BISECTING"
fi

# Get ahead/behind counts from upstream
ahead=0
behind=0
upstream=$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
if [ -n "$upstream" ]; then
    counts=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
    if [ -n "$counts" ]; then
        ahead=$(echo "$counts" | cut -f1)
        behind=$(echo "$counts" | cut -f2)
    fi
fi

# Parse git status for file counts
staged=0
unstaged=0
untracked=0
conflicts=0

while IFS= read -r line; do
    if [ -z "$line" ]; then
        continue
    fi
    x="${line:0:1}"
    y="${line:1:1}"

    # Untracked
    if [ "$x" = "?" ]; then
        ((untracked++))
        continue
    fi

    # Conflicts
    if [ "$x" = "U" ] || [ "$y" = "U" ] || { [ "$x" = "A" ] && [ "$y" = "A" ]; } || { [ "$x" = "D" ] && [ "$y" = "D" ]; }; then
        ((conflicts++))
        continue
    fi

    # Staged changes (index)
    if [[ "$x" =~ [MADRC] ]]; then
        ((staged++))
    fi

    # Unstaged changes (worktree)
    if [[ "$y" =~ [MD] ]]; then
        ((unstaged++))
    fi
done < <(git status --porcelain 2>/dev/null)

# Build output string
output=""

# Branch name (with icon)
output="$branch"

# Action indicator
if [ -n "$action" ]; then
    output="$output |$action"
fi

# Ahead/behind indicators
if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
    output="$output ↑$ahead↓$behind"
elif [ "$ahead" -gt 0 ]; then
    output="$output ↑$ahead"
elif [ "$behind" -gt 0 ]; then
    output="$output ↓$behind"
fi

# Conflict indicator
if [ "$conflicts" -gt 0 ]; then
    output="$output ~$conflicts"
fi

# Staged indicator
if [ "$staged" -gt 0 ]; then
    output="$output +$staged"
fi

# Unstaged indicator
if [ "$unstaged" -gt 0 ]; then
    output="$output !$unstaged"
fi

# Untracked indicator
if [ "$untracked" -gt 0 ]; then
    output="$output ?$untracked"
fi

# Clean indicator (nothing to commit)
if [ "$staged" -eq 0 ] && [ "$unstaged" -eq 0 ] && [ "$untracked" -eq 0 ] && [ "$conflicts" -eq 0 ]; then
    output="$output ✓"
fi

echo "$output"
