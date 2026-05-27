# Plan: Remove gallery, hero image, and image-related scaffolding

## Context
The workshop organizer wants to strip the image gallery section and hero image placeholder from the blog template, and remove all supporting infrastructure (compression script, photo handling instructions, assets directory). Teams will not use images — no gallery, no hero image, no compression workflow.

Note: `workshop_instructions.html` has a "do not modify" rule aimed at workshop *participants*. The organizer is explicitly overriding that here.

---

## Changes

### 1. `DSI-Awayday-blog.html`

**Remove from HTML:**
- Line 173: the entire `<div class="hero-image">…</div>` inside `<header id="hero">`
- Lines 193–201: the entire `<section id="gallery">…</section>`

**Remove from CSS:**
- Lines 43–51: `header#hero .hero-image { … }` block
- Lines 80–103: all three `#gallery` rule blocks (`.gallery-grid`, `.gallery-grid div`, `.gallery-grid img`)

### 2. `CLAUDE.md`

- **Delete** the entire `## Photo handling` section (lines 51–75).
- **Update** `## Structure rules` — remove `gallery` from the kept section IDs list (line 133–134), and delete the two gallery-limit lines (lines 135–136).
- **Update** `## Workflow` — remove step 4 (`bash scripts/compress-awayday-images.sh …`) and renumber remaining steps.

### 3. `workshop_instructions.html`

- Remove the "Hero / title image" `<li>` bullet (line 241).
- Edit the "Body — at least 3 sections" bullet to drop `Image gallery or visual elements` from the suggested list (line 247).
- Remove the "Photo gallery bonus" `<li>` bullet (lines 280–283).

### 4. `scripts/compress-awayday-images.sh`

- Delete this file.

### 5. `assets/awayday/` directory

- Remove `.gitkeep` and the directory (or just the `.gitkeep` so git stops tracking it). Since no images will ever be stored here, clean it up entirely.

---

## Verification

1. Open `DSI-Awayday-blog.html` — hero shows only the title `<h1>`, no image box below it; no gallery section present.
2. No CSS orphans: search for `.gallery-grid` and `.hero-image` in the file — both should be gone.
3. `CLAUDE.md` — no mention of `compress-awayday-images.sh`, `assets/awayday`, photo handling, or gallery limit.
4. `workshop_instructions.html` — no "Hero / title image" bullet, no "Image gallery" suggestion, no "Photo gallery bonus" item.
5. `scripts/` directory contains no `compress-awayday-images.sh`.
6. `assets/awayday/` directory is gone (or empty with no `.gitkeep`).
