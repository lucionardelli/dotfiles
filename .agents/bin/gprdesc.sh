#!/bin/bash

# 1. Determine Base Branch
# Priority: Argument $1 -> develop -> staging -> main
BASE_BRANCH="$1"

if [ -z "$BASE_BRANCH" ]; then
    for b in develop staging main; do
        if git rev-parse --verify "$b" >/dev/null 2>&1; then
            BASE_BRANCH="$b"
            break
        fi
    done
fi

# 2. Validation
if [ -z "$BASE_BRANCH" ]; then
    echo "Error: No base branch (develop, staging, or main) found."
    exit 1
fi

if ! git rev-parse --verify "$BASE_BRANCH" >/dev/null 2>&1; then
    echo "Error: Branch '$BASE_BRANCH' does not exist."
    exit 1
fi

# 3. Execution
# We use the triple-dot syntax to get changes since the branch diverged
git diff "$BASE_BRANCH...HEAD"
