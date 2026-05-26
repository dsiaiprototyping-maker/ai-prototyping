Suggested slide title
Building with Claude — From Prompt to Shipped

Context (for facilitator)
Participants are actively building features on the live workshop page during the session.
Feedback loop: share a screenshot of your browser or the diff — Claude can read both.

Phases

Good prompting
- Point at what you see: "the hero section looks cramped on mobile — fix it"
- Name the constraint: "only change the CSS, don't touch the HTML"
- One visible goal per prompt — if you can screenshot it, it's scoped right

Plan phase
- Ask Claude to plan before it codes: "what would you change and why?"
- Read the plan — reject wrong assumptions before a single line is written
- Choosing the model: Opus for tricky layout or architecture decisions, Sonnet for most feature work

Interview phase
- Claude asks questions before acting — answer them, don't skip
- This is where hidden conflicts surface: "that id is used by another team's section"
- Shared understanding reached here saves rework later

Feedback via screenshot
- Take a screenshot of your browser at any point
- Paste or attach it in your next message: "this is what I see — fix the spacing"
- Claude reads the visual and corrects accordingly — no need to describe every detail

Iteration loop
- Each round: prompt → Claude edits → you refresh the browser → screenshot if something looks off
- Small focused prompts give you a short, reviewable diff each time
- Commit after each working step — safety net if the next prompt goes wrong

One-line takeaway
Build in short loops: prompt, look, screenshot, correct — the browser is your shared source of truth.
