# CLAUDE.md — AI Prototyping Workshop

## Context
This is a workshop page — a single-page event microsite. Attendees implement
one feature into this page using their own Claude Code cloud session, which
works on a branch off `main`. Treat `main` as the immutable starter; all your
work happens on the branch your session created. Previews go through
`htmlpreview.github.io` (see "Previewing HTML Files" below).
Read the full file before making any changes.

## Features
Pick one feature to build. Each has a brief in `briefs/`:
- **UI Uplift** — CSS-only visual transformation (`briefs/ui-uplift.md`)
- **Interactive Agenda** — Timeline component with live indicators (`briefs/agenda.md`)
- **Session Feedback** — Star ratings, comments, persistence (`briefs/feedback.md`)

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
2. Pick a feature from the Features section and read its brief in `briefs/`
3. Make the smallest set of changes that achieves the goal
4. Stay inside any scope markers in `index.html` for your feature

## HTML Output Rules

### Self-Contained Files
All HTML files generated in this project must be fully self-contained:
- **CSS** must be inlined within `<style>` tags in the `<head>` — no external `.css` file references
- **JavaScript** must be inlined within `<script>` tags — no external `.js` file references
- **External CDN resources** (e.g. fonts, icon libraries) are allowed via `<link>` or `<script src>` only if they point to a public CDN URL (not a local file)
- No relative or absolute local file path references (e.g. `./style.css`, `/app.js`) — these will break in preview environments

### Previewing HTML Files
After **every** UI change, output the htmlpreview URL for the current branch so the user can verify the change in a browser. Also output it whenever the user asks to view, preview, or open an HTML file. Construct the URL like this:

```
https://htmlpreview.github.io/?https://raw.githubusercontent.com/{owner}/{repo}/{current-branch}/{path-to-file.html}
```

- Determine `{current-branch}` by running `git rev-parse --abbrev-ref HEAD`
- Determine `{owner}` and `{repo}` from `git remote get-url origin`
- `{path-to-file.html}` is the repo-relative path to the HTML file
