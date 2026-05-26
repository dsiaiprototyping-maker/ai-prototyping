# Cleanup: drop local-multi-team infra, switch to single-branch cloud-session flow

## Context

The workshop was originally built around three teams running locally on their own git worktrees, served by a FastAPI app (`server.py`) that mounted each worktree under a path (`/ui-uplift/`, `/agenda/`, `/feedback/`), with `cloudflared` tunneling port 8080 publicly. The session flow has now changed:

- The walkthrough demos one feature (UI uplift) live on `main`, after first explaining "agent vs agent harness."
- Attendees spin up their own Claude Code cloud sessions which auto-clone the repo and create a new branch per attendee.
- Previews go through `https://htmlpreview.github.io/?https://github.com/{owner}/{repo}/blob/{branch}/index.html` — works because `index.html` is fully self-contained.
- Whole session is **25 minutes**, not 50.

So all local server, tunnel, and worktree infrastructure is dead weight. `main` becomes the bare starter; the walkthrough demos UI uplift live but does not merge to `main`; attendees clone a clean canvas and pick any feature to try.

## Decisions (from grilling)

- **Target state of `main`:** bare starter. Walkthrough output does not merge in.
- **GitHub remote setup:** out of scope. Cleanup commit stays local; pushing to GitHub is a follow-up.
- **Rename Team 1/2/3 → feature names** throughout (briefs, index.html section markers, page copy).
- **Brief filenames:** feature slugs (`ui-uplift.md`, `agenda.md`, `feedback.md`).
- **Brief content:** mechanical rename only (title + filename). Body untouched.
- **`#teams` section in page:** renamed to `#features` with feature-name listing (no brief paths in HTML).
- **Inline scope comment markers in `index.html`:** renamed to `AGENDA FEATURE — Scope` / `FEEDBACK FEATURE — Scope` / `FEEDBACK FEATURE: Add your <script> block here`. Guidance text kept verbatim.
- **`#agenda` content + `#feedback` placeholder + `#about` copy:** rewritten to match the new 25-min single-attendee flow (so `main` is self-consistent).
- **`CLAUDE.md` rewrite scope:** rewrite Context, rewrite Workflow, add a Features section pointing at the briefs, add explicit "output the htmlpreview URL after every UI change" instruction. Stack / Structure Rules / CSS Variables / Responsive / Self-Contained Files all untouched.
- **`huashu-design` skill stack:** dropped entirely (`.agents/`, `.claude/skills/huashu-design` symlink, `skills-lock.json`). Not referenced anywhere in the new flow.
- **`.gitignore`:** added — `.venv/`, `__pycache__/`, `*.pyc`, `.DS_Store`, `.claude/settings.local.json`.
- **`.plans/`:** kept in git (this file gets committed).
- **`deck/`:** untouched. Facilitator content; user updates separately.
- **Commit:** single commit on `main`, local only (no push).

## Files deleted

- `server.py`, `setup.sh`, `start-servers.sh`, `stop-servers.sh`, `show-tunnels.sh`
- `skills-lock.json`
- `__pycache__/`, `.venv/`
- `worktrees/` (via `git worktree remove --force` × 3 + rmdir)
- Branches `team-1/ui-uplift`, `team-2/agenda`, `team-3/feedback` (`git branch -D`)
- `team-claudes/`
- `.agents/`, `.claude/skills/huashu-design` (symlink)

## Files renamed

- `briefs/team-1-brief.md` → `briefs/ui-uplift.md`
- `briefs/team-2-brief.md` → `briefs/agenda.md`
- `briefs/team-3-brief.md` → `briefs/feedback.md`

## Files modified

- `index.html` — reverted from uncommitted `pathTeamMap` diff to base, then edited: nav link `Teams` → `Features`; `#about` copy rewritten; `#agenda` `<ul>` rewritten for 25-min flow; `<section id="teams">` → `<section id="features">` with feature-only labels; comment markers renamed to feature language; `#feedback` placeholder rewritten.
- `CLAUDE.md` — Context rewritten; Features section inserted; Workflow rewritten; "Previewing HTML Files" instruction strengthened to require URL output after every UI change.
- `briefs/ui-uplift.md`, `briefs/agenda.md`, `briefs/feedback.md` — title rename only (e.g., `# Team 1 Brief — UI Uplift` → `# UI Uplift`).

## Files created

- `.gitignore` — 5 lines (see Decisions).
- `.plans/ok-the-approach-for-harmonic-milner.md` (this file).

## Verification

After the commit:

- `git status` is clean.
- `git worktree list` shows only the main checkout.
- `git branch -a` shows only `main`.
- `ls` at repo root contains no `server.py`, `setup.sh`, `start-*.sh`, `stop-*.sh`, `show-tunnels.sh`, `worktrees/`, `team-claudes/`, `.venv/`, `__pycache__/`, `.agents/`, `skills-lock.json`.
- `grep -ri "team-1\|team 1\|three teams\|cloudflared\|worktree" CLAUDE.md briefs/ index.html` returns nothing.
- `index.html` `<head>` has no `pathTeamMap` script.
- Open the htmlpreview URL for `main`'s `index.html` once a GitHub remote is configured and the branch is pushed:
  `https://htmlpreview.github.io/?https://raw.githubusercontent.com/{owner}/{repo}/main/index.html`

## Follow-up (not in this cleanup)

The new flow requires a public GitHub remote so cloud sessions can clone and `htmlpreview.github.io` can fetch raw files. The repo currently has no `origin`. Push `main` to GitHub before the workshop runs.
