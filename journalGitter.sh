#!/bin/bash

# Ensure the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <commit-message> <journal-date> <journal-text>"
  exit 1
fi

# Assign arguments to variables
commit_message=$1
journal_date=$2
journal_text=$3

# Get the current branch name
branch=$(git branch --show-current)

# Set the journal file name based on the branch name
journal_file="${branch}.md"

# Append the journal entry to the journal file
echo "# Journal Entry - $journal_date" >> "$journal_file"
echo "" >> "$journal_file"
git log -1 >> "$journal_file"
echo "" >> "$journal_file"
echo "$journal_text" >> "$journal_file"
echo "" >> "$journal_file"

# Add the file, commit, and push to the current branch
git add "$journal_file"
git commit -m "$commit_message"
git push origin "$branch"

echo "Journal entry for $journal_date committed to $branch in $journal_file."
