# Session Feedback Widget

## Your Feature
Build a live session feedback widget — star rating (out of 5), average score
display, and a comment section. Everything persists across browser refresh
using localStorage.

## What "Done" Looks Like
- 5 clickable stars with a hover preview effect (stars fill on hover, lock on click)
- Average score and total vote count update immediately after each new rating
- A text area for comments with a Submit button
- Submitted comments appear as a list below with timestamps
- On page refresh, all ratings and comments reload from localStorage
- If no data yet, a friendly empty state is shown

## Your Constraint
You own `<section id="feedback">` and the `<script>` block at the end of `<body>`.
You can append styles to the `<style>` block.
Do not touch any other section or existing CSS rules.

## Time Budget
~25 minutes to build. Save 5 minutes to explain your prompting choices.

## Suggested Starting Prompt

Paste this into your Claude Code session to begin:

```
Read the index.html file in full.

I need to build a session feedback widget inside <section id="feedback">.
I also need a <script> block at the end of <body> and new CSS appended to
the existing <style> block.

Requirements:

STAR RATING:
- 5 stars rendered as clickable elements (use Unicode ★ or SVG)
- Hover state: fill stars from left up to the hovered star
- Click state: lock the selection; visually distinct from hover
- A user can change their rating by clicking again
- Only one rating per browser session (disable stars after first submit,
  but still show the rating they gave)

AVERAGE SCORE:
- Display "X.X / 5 — Y ratings" below the stars
- Recalculate and re-render on every new rating submission

COMMENTS:
- A <textarea> with a Submit button
- On submit: add comment to the list with a formatted timestamp (HH:MM)
- Comments appear newest-first
- Empty submission should do nothing

PERSISTENCE:
- Use localStorage key: workshop_feedback
- Data shape: { "ratings": [], "comments": [{ "text": "", "time": "" }] }
- On page load: read localStorage, re-render everything from saved data

EMPTY STATE:
- If no ratings yet: "Be the first to rate this session"
- If no comments yet: "No comments yet — share your thoughts above"

Use only the existing CSS variables for colours. No hardcoded hex values.

Return three clearly labelled blocks:
- SECTION HTML (replaces content inside #feedback)
- CSS TO APPEND (add to end of existing <style>)
- SCRIPT BLOCK (new <script> at end of <body>)
```

## Iteration Tips
- If stars don't highlight on hover: "The hover state needs to fill all stars
  from the first up to the hovered one, not just the hovered star itself."
- If localStorage doesn't reload: "On DOMContentLoaded, parse the stored JSON
  and call the render functions with the loaded data."
- If average is NaN: "Guard against an empty ratings array before calling
  reduce — return 0 if the array is empty."
