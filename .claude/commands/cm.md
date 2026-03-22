# Commit Message Generator

Your goal is to generate a concise one-line commit message based on the currently staged git changes and copy it to the clipboard.

## Steps

1. Check that there are staged changes:
   - Run `git diff --staged` to get the staged changes.
   - If there are no staged changes, inform the user and exit.

2. Analyze the staged changes:
   - Review the diff output to understand what was added, modified, or removed.
   - Identify the main purpose of the changes (e.g., fix, feat, refactor, docs, test, chore).

3. Generate a one-line commit message:
   - Be concise and descriptive (max ~70 characters).
   - Focus on WHAT changed and WHY, not HOW.
   - Use imperative mood (e.g., "add", "fix", "update", not "added", "fixed", "updated").

4. Copy to clipboard and display:
   - Use `echo -n "message" | pbcopy` to copy the commit message to the clipboard WITHOUT a trailing newline.
   - Display the generated message to the user.
   - Confirm that it has been copied to the clipboard.
