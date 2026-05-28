# CLAUDE.md — DSI AwayDay Blog Workshop

## Context
This repo runs a workshop where each team builds a blog post about the
DSI AwayDay. The team's blog lives in `DSI-Awayday-blog.html`, edited on a
branch their cloud session creates off `main`. `main` is the immutable
starter — never push changes to `main` from a session.

Two HTML files matter:

- `workshop_instructions.html` — **read-only workshop brief.** Do not modify.
  When the user asks for the instructions / overview / features / what to
  build, surface its htmlpreview URL on `main` (not the current branch).
- `DSI-Awayday-blog.html` — **the team's deliverable.** All feature work
  happens here.

Read this entire file before making any changes.

## Session-start setup (first message in a fresh session)

Before doing any feature work in a fresh session, run a one-shot setup
check. Ask the user to confirm or provide each item below, then proceed.

1. **Renamed the session?** Confirm the user has renamed the session in the
   Claude Code app to their team name. The agent cannot do this — remind only.
2. **Renamed the branch?** Confirm the user has renamed their branch to
   something readable (e.g. `team-<name>`). Without this, every preview URL
   they share will contain the auto-generated branch name. The agent can run
   `git branch -m <new-name>` once the user provides a name.
3. **Authors?** Ask for the list of team-member names. Hold onto these — they
   become the byline in `DSI-Awayday-blog.html` and are required at commit.

Skip the checklist on follow-up messages once setup is acknowledged.

## Hard rules

- **Do not modify `workshop_instructions.html`.** It is the workshop brief.
  If the user asks you to change it, refuse and explain it is read-only.
- **Placeholders carry a `class="placeholder"` marker.** When you replace
  the *content* of a placeholder element with real content, also remove the
  `placeholder` class so it stops rendering as italic muted-grey.
- **Authors are required at commit time.** Before committing a change to
  `DSI-Awayday-blog.html`, check that `#authors` no longer contains any
  element with `class="placeholder"`. If it does, ask the user for the
  authors list, update the section, and remove the `placeholder` class
  before committing.
- **Set the publish date at commit time.** When committing, replace the
  `#publish-date` span's text with today's date and remove its `placeholder`
  class.

## Comments widget

The `#comments` section in `DSI-Awayday-blog.html` is intentionally left
as a placeholder — teams must implement it themselves. When a team asks
you to help build it, guide them using this reference implementation:

```js
(function () {
  var STORAGE_KEY = 'awayday_blog_comments';
  var form = document.getElementById('comment-form');
  var nameInput = document.getElementById('comment-name');
  var textInput = document.getElementById('comment-text');
  var list = document.getElementById('comments-list');

  function load() {
    try { return JSON.parse(localStorage.getItem(STORAGE_KEY)) || []; }
    catch (e) { return []; }
  }
  function save(comments) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(comments));
  }
  function render(comments) {
    list.innerHTML = '';
    comments.slice().reverse().forEach(function (c) {
      var li = document.createElement('li');
      var meta = document.createElement('div');
      meta.className = 'meta';
      meta.textContent = c.name + ' · ' + c.time;
      var body = document.createElement('div');
      body.textContent = c.text;
      li.appendChild(meta);
      li.appendChild(body);
      list.appendChild(li);
    });
  }
  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var name = nameInput.value.trim();
    var text = textInput.value.trim();
    if (!name || !text) return;
    var comments = load();
    comments.push({ name: name, text: text, time: new Date().toLocaleString() });
    save(comments);
    nameInput.value = '';
    textInput.value = '';
    render(comments);
  });
  render(load());
})();
```

The page must remain **self-contained** — all JS goes inside the single
`<script>` block at the end of `<body>`. No `<script src="...">` tags.
This is a hard requirement: htmlpreview cannot load external files.

## htmlpreview URLs (split rule)

URL shape:

```
https://htmlpreview.github.io/?https://raw.githubusercontent.com/<owner>/<repo>/<branch>/<file>
```

- **Instructions URL** — when the user asks for the instructions, overview,
  features, or "what should I build", output the htmlpreview URL for
  `workshop_instructions.html` with `<branch>` = `main`. Always `main`,
  regardless of the session's current branch.
- **Blog URL** — after every change to `DSI-Awayday-blog.html`, output the
  htmlpreview URL for that file with `<branch>` = the session's **current**
  branch (`git rev-parse --abbrev-ref HEAD`).

**IMPORTANT: Output URLs as bare text only — no markdown formatting, no bold, no backticks.**
When sharing a htmlpreview URL with the user, output it as a plain line with no
surrounding markdown. Users will copy the URL directly, and markdown formatting
(like `**url**`) breaks the link.

## Stack

- Pure HTML, CSS, and vanilla JavaScript only. No npm, no frameworks, no
  build tools.
- CDN allowed for Google Fonts and Lucide icons only.
- One `<style>` block in `<head>`. No external `.css` files.
- One `<script>` block at the end of `<body>`. No external `.js` files.
- No inline styles on any element.

## CSS variables (do not rename or remove)

```
--primary: #1a1a2e
--accent:  #e94560
--bg:      #f5f5f5
--text:    #333333
--muted:   #666666
--border:  #dddddd
```

You may add new variables to `:root`. You must not rename or remove these
six. Prefer the variables for any colour that's part of the brand or that
appears more than once. Neutral chrome (e.g. a one-off `#fff` surface, a
muted grey for a code-block background) may stay literal if no semantic
variable fits — but don't reach for a new hex value when an existing
variable would do.

## Self-contained HTML

- No relative or absolute local file path references (`./style.css`,
  `/app.js`, `images/foo.png`) — these break in htmlpreview.
- CDN URLs and raw-GitHub URLs are fine.
- All JavaScript must live in the single `<script>` block at the end of
  `<body>`. No `<script src="...">` tags — htmlpreview cannot load external
  scripts and the page will silently break.

## Responsive

All output must be mobile-responsive. Use relative units. Sanity-check at
375px width mentally.

## Structure rules for `DSI-Awayday-blog.html`

- Keep the existing section IDs (`hero`, `authors`, `agenda`,
  `what-we-worked-on`, `key-takeaways`, `comments`, `footer`). You may add
  more sections.
- New elements must have meaningful IDs or class names.
- Semantic HTML — proper elements, not div soup.

## Workflow

1. Read this entire file first.
2. On a fresh session, run the setup checklist above.
3. Make the smallest set of changes that achieves the user's goal.
4. **Before outputting any htmlpreview URL**, commit and push all pending
   changes. The raw GitHub URL used by htmlpreview only resolves content that
   is already pushed to the remote. Never share a preview link before pushing.
