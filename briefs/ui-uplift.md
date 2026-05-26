# UI Uplift

## Your Feature
Transform the base page from plain HTML into a polished, professional event microsite —
using CSS only. No HTML changes. No JavaScript.

## What "Done" Looks Like
- A visually striking header with the event title and a strong typographic treatment
- A nav bar that looks like a real product nav
- Clean section spacing with subtle visual separation
- The accent colour (#e94560) used in at least one intentional way
- A page you'd be comfortable sharing as a real event link

## Your Constraint
**CSS only.** You cannot touch any HTML. The structure is frozen.
Your entire output lives in the `<style>` block.

## Time Budget
~25 minutes to build. Save 5 minutes to explain your prompting choices.

## Suggested Starting Prompt

Paste this into your Claude Code session to begin:

```
Read the index.html file in full.

I need a CSS-only visual uplift for this event microsite. Do not change any HTML.
Only modify the <style> block in <head>.

Design direction:
- Dark, modern tech aesthetic
- Use Inter or Space Grotesk from Google Fonts for headings
- Keep the existing CSS variables — you may add new ones to :root
- Use the accent colour (#e94560) for one deliberate highlight (e.g. a border,
  an underline, a button-like element in the nav)
- Generous whitespace, clear visual hierarchy
- Sections should feel like cards or have a subtle separation treatment
- The header should feel like a hero — full-width, confident, not just a coloured bar
- Mobile-responsive

Return only the complete updated <style> block. Nothing else.
```

## Iteration Tips
If the first output isn't right, be specific about what's wrong:
- "The nav links need more breathing room between them"
- "The section headings feel too small relative to the body text"
- "The header needs more vertical padding"

Vague feedback ("make it better") gives vague results.
