# PR Summary

Summarize branch changes using PR template format

## Steps

1. **Validate git repository**
   - Check if current directory is a git repository
   - Identify the current branch name
   - Verify there are commits on the branch

2. **Find merge base and analyze changes**
   - Determine the main branch (try `master`, then `main`)
   - Find the merge base: `git merge-base HEAD origin/{main-branch}`
   - Get commit history: `git log {merge-base}..HEAD --oneline`
   - Get full diff: `git diff {merge-base}...HEAD --stat` and sample changes

3. **Check for PR template**
   - Look for `.github/PULL_REQUEST_TEMPLATE.md` in the repository root
   - If it exists, use that format
   - If not, use a standard format with: Issue Summary, Changes, Tests sections

4. **Generate concise summary**
   - **Issue Summary**: Write 1-2 sentences explaining what changed and why
     - Start with an active verb (Adds, Fixes, Updates, Refactors, etc.)
     - Focus on the business value or user impact

   - **Changes**: List 3-5 high-level bullet points
     - Use commit messages to group related changes
     - Each bullet should describe a logical change grouping
     - Format: `- Brief description of change category`

   - **Screenshots**: Add placeholder `<!-- Add screenshots if UI changes -->`

   - **Tests**: Add placeholder `<!-- Describe how to test these changes -->`

   - **Checklist**: If the template has a checklist, include it unchanged

5. **Output and copy the summary**
   - Present the formatted PR summary to show the user what was generated
   - Copy the summary to the clipboard WITHOUT a trailing newline using `printf '%s' "summary" | pbcopy` (macOS), `printf '%s' "summary" | xclip -selection clipboard` (Linux), or `printf '%s' "summary" | clip` (Windows)
   - Inform the user that the summary has been copied to their clipboard
   - Keep it concise - the entire summary should be scannable in under a minute
   - Humanize it using the humanize skill. Write it like a software engineer would write it, with brevity and some laziness, that makes it seem human.

## Notes

- If no changes exist since merge base, inform the user
- Don't fetch Jira tickets or external resources
- Focus on what changed in the codebase, not why from a ticket perspective
- Let commit messages guide the categorization of changes
