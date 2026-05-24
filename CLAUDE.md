# CLAUDE.md — AI Prototyping Workshop

## Context
This is a live workshop page. Three teams are simultaneously building features
on separate git worktree branches. Your changes must merge cleanly with theirs.
Read the full file before making any changes.

## Stack
- Pure HTML, CSS, and vanilla JavaScript only
- No npm packages, no build tools, no frameworks
- CDN allowed for Google Fonts and Lucide icons only
- One `<style>` block in `<head>` — no separate CSS files
- One `<script>` block at end of `<body>` — no separate JS files
- No inline styles on any element

## Structure Rules
- Never remove or rename existing IDs or section elements
- New elements must have meaningful IDs or class names
- All colours must reference CSS variables from `:root` — never hardcode hex values
- HTML must stay semantic — use proper elements, not div soup

## CSS Variables (do not rename or remove)
```
--primary: #1a1a2e
--accent:  #e94560
--bg:      #f5f5f5
--text:    #333333
--muted:   #666666
--border:  #dddddd
```
You may add new variables to `:root` but must not change the ones above.

## Responsive
All output must be mobile-responsive. Use relative units. Test at 375px width mentally.

## Workflow
1. Read the entire file first
2. Identify your assigned scope (see team-specific section below)
3. Make the smallest set of changes that achieves the goal
4. Do not modify anything outside your assigned scope
