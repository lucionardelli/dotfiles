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


# 3. Get current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 4. Parse Jira issue key and description
ISSUE_KEY=$(echo "$CURRENT_BRANCH" | cut -d'-' -f1 | tr '[:lower:]' '[:upper:]')
ISSUE_DESC=$(echo "$CURRENT_BRANCH" | cut -d'-' -f2- | sed 's/-/ /g')

# 5. Print PR title
echo "PR_TITLE: ${ISSUE_KEY}: ${ISSUE_DESC^}"

# 6. Execution: diff against base
git diff "$BASE_BRANCH...HEAD"
