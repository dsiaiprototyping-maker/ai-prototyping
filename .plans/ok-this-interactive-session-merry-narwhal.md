# Repo pivot — workshop instructions + DSI AwayDay blog target

## Context

Today the repo is a single-page workshop microsite (`index.html`) where each
team's cloud session edits one of three feature scopes inside the same file.
That model is being retired. The new workshop:

- Teams build a **blog post about the DSI AwayDay** in a *separate* file
  (`DSI-Awayday-blog.html`) per cloud-session branch.
- The current `index.html` becomes a **read-only workshop brief**
  (`workshop_instructions.html`) that everyone in the room reads.
- The brief lives on `main` and is immutable; only the blog file is edited.
- Photos provided to teams are committed under `assets/awayday/` and embedded
  in the blog via raw-GitHub URLs (htmlpreview can't resolve relative paths).
- `CLAUDE.md` is rewritten so the agent enforces the new flow: prompts for
  session/branch rename + authors on first message, surfaces the correct
  htmlpreview URL per file, and refuses to touch the instructions page.

Outcome: one canonical brief everyone reads, one editable artefact per team,
and clear agent rules so the workshop runs without local coordination.

## Files to change

### 1. Rename `index.html` → `workshop_instructions.html` and rewrite contents

Full rewrite (Q2 → b). Drop the existing scope-marker comments and the
Feedback placeholder. Keep the `:root` variables block unchanged
(`--primary`, `--accent`, `--bg`, `--text`, `--muted`, `--border`). New sections, in order:

1. **Header** — "DSI AwayDay Blog Workshop" + one-line subtitle.
2. **What you're building** — short paragraph: each team builds a blog post
   about today's AwayDay in `DSI-Awayday-blog.html` on their own branch.
3. **How to log in** —
   - Install the Claude Code app
   - Sign in with `dsi.ai.prototyping@gmail.com`
   - Enter the login code (provided by organizers)
   - In the app: **Code → New Session**, send your first message to start it
   - **Rename the session** (top of the session panel)
   - **Rename the branch** (so your preview URL is shareable)
4. **Suggested blog structure** — components with strength labels:
   - Hero / title image — *SHOULD*
   - Authors (team-member names) — **MUST** (agent prompts if missing)
   - Date — auto-set at commit time
   - Body — at least 3 sections: Agenda/Purpose, UI overhaul, Image gallery / visual elements — *SHOULD*
   - Comments widget at the end (LS-persisted, mirrors the old feedback pattern) — *SHOULD*
5. **Rules** — vanilla HTML/CSS/JS only; no build tools; one `<style>` block
   in `<head>`; one `<script>` block at end of `<body>`; no inline styles; new
   colours via `:root` vars only; mobile-responsive (test at 375px); photos
   live under `assets/awayday/<descriptive-name>.<ext>` and are referenced via
   the raw-GitHub URL for the current branch.
6. **How to preview** — show the htmlpreview URL pattern and call out the
   split: instructions always preview off `main`; blog always previews off
   the team's current branch.
7. **How you'll be reviewed** — completion of suggested features, general UI
   aesthetics, and use of skills / best practices (good prompting, sensible
   commits, clean structure).
8. **Tips for prompting** — 3–4 bullets reinforcing the workshop's prompting
   lesson (be specific, iterate, show examples, ask the agent to plan).
9. **Footer** — same dark footer as today ("Built live with Claude · AI
   Prototyping Workshop").

### 2. Create `DSI-Awayday-blog.html`

Sectioned skeleton (Q6 → b) with visible placeholders so previewing the
empty page reveals the recommended structure. Same `:root` variables block
as the instructions page and the same base styles, but no scope-marker
comments — the whole file is in scope. Sections:

- `<header id="hero">` — title placeholder + hero image placeholder
- `<section id="authors">` — "Authors: [to be filled in]" placeholder
- `<section id="purpose">` — "Agenda / Purpose" placeholder copy
- `<section id="ui-overhaul">` — "UI overhaul" placeholder copy
- `<section id="gallery">` — "Image gallery" placeholder grid stub
- `<section id="comments">` — comments widget stub (form + list region)
- `<footer id="footer">` — date placeholder ("Published: [auto]")

Each placeholder is one visible line of text on the rendered page so a
first-time previewer can read "Replace this with your hero image" etc.

### 3. Create `assets/awayday/`

New directory for committed photos. Add a `.gitkeep` so the empty folder is
tracked.

### 4. Delete `briefs/`

Remove `briefs/ui-uplift.md`, `briefs/agenda.md`, `briefs/feedback.md`, and
the directory itself (Q7 → a). The feedback-widget pattern is inlined as a
one-paragraph hint inside the Rules section of `workshop_instructions.html`.

### 5. Rewrite `CLAUDE.md`

Replace the existing rules so the agent enforces the new flow. New rules
to encode:

- **Workshop frame.** Each cloud session builds a blog post about the DSI
  AwayDay in `DSI-Awayday-blog.html` on its own branch. `main` is the
  immutable starter.
- **Do not modify `workshop_instructions.html`.** It is the read-only
  workshop brief.
- **Session-start setup (front-loaded, Q10 → a).** On the first user
  message of a fresh session, the agent must surface a setup checklist
  before doing feature work:
  1. Confirm the user has **renamed the session** in the Claude Code app.
  2. Confirm the user has **renamed the branch** (e.g. `team-<name>`).
  3. Ask for the **authors list** (team-member names) and remember it for
     the byline.
  Proceed only after the user acknowledges.
- **Authors required at commit.** When committing changes to
  `DSI-Awayday-blog.html`, if the authors section is still a placeholder,
  the agent must ask for authors before committing.
- **Photo handling.** When the user provides an image, save it to
  `assets/awayday/<descriptive-kebab-name>.<ext>` and reference it in the
  blog via the raw-GitHub URL for the current branch:
  `https://raw.githubusercontent.com/<owner>/<repo>/<current-branch>/assets/awayday/<name>.<ext>`.
  Never use a relative path — htmlpreview cannot resolve it.
- **htmlpreview URLs (split rule).**
  - When the user asks for *instructions / overview / features*, output the
    htmlpreview URL for `workshop_instructions.html` on **`main`** (not the
    current branch).
  - After every change to `DSI-Awayday-blog.html`, output the htmlpreview
    URL for that file on the **current branch**.
  - Determine owner/repo from `git remote get-url origin`.
- **Stack rules** (carry over from today): vanilla HTML/CSS/JS, no build
  tools, no inline styles, one `<style>` block in `<head>`, one `<script>`
  block at end of `<body>`, CDN allowed for Google Fonts and Lucide icons
  only.
- **CSS variables** — keep the six `:root` vars (`--primary`, `--accent`,
  `--bg`, `--text`, `--muted`, `--border`). New vars may be added; existing
  ones must not be renamed or removed.
- **Self-contained HTML** — no relative or absolute local file paths in
  `src`/`href` (CDN URLs and raw-GitHub URLs are fine).
- **Mobile-responsive** — relative units, sanity-check at 375px.

### 6. `README.md`

One-line update so it points at `workshop_instructions.html` instead of the
old `index.html`.

## Critical files to read before editing

- `/Users/basavaraj/Downloads/dsi_may_awayday/index.html` — current
  microsite; source for the rewrite + the canonical `:root` block.
- `/Users/basavaraj/Downloads/dsi_may_awayday/CLAUDE.md` — current rules;
  many carry over verbatim (stack rules, CSS vars, htmlpreview URL recipe).
- `/Users/basavaraj/Downloads/dsi_may_awayday/briefs/feedback.md` — source
  for the LS-persisted comments-widget pattern that the instructions page
  will reference in one paragraph before the briefs folder is deleted.

## Verification

End-to-end check on the local working copy, then on `main` after merge.

1. **Structure.**
   ```
   ls -la
   # expect: workshop_instructions.html, DSI-Awayday-blog.html, CLAUDE.md,
   #         README.md, assets/awayday/.gitkeep, deck/, .claude/, .agents/
   # NOT expected: index.html, briefs/
   ```
2. **Instructions render correctly on main.**
   Open
   `https://htmlpreview.github.io/?https://raw.githubusercontent.com/<owner>/<repo>/main/workshop_instructions.html`
   and confirm all nine sections render, fonts/colours match, and the page
   is mobile-readable at 375px (DevTools).
3. **Blog skeleton renders with placeholders.**
   Open the htmlpreview URL for `DSI-Awayday-blog.html` on a feature branch
   and confirm every section's placeholder line is visible.
4. **Photo round-trip.**
   On a feature branch, commit a sample image to
   `assets/awayday/sample.jpg`, reference it in the blog via the raw-GitHub
   URL for that branch, push, and confirm htmlpreview renders the image.
5. **Agent flow (manual).**
   Start a fresh cloud session and send a one-line first message. Confirm
   the agent surfaces the setup checklist (session rename, branch rename,
   authors) before doing feature work. Attempt to commit without authors
   filled in and confirm the agent asks for them.
6. **Immutability of instructions.**
   Ask the agent to "edit the instructions page". Confirm it refuses and
   explains the page is the read-only workshop brief.
