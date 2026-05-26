# Interactive Agenda

## Your Feature
Turn the flat agenda list into an interactive timeline. Expandable items,
a live "current session" indicator, and clear visual states for past/active/upcoming.

## What "Done" Looks Like
- Each agenda item can be clicked to expand a description
- The currently active item is highlighted (calculated from real elapsed time)
- Completed items look visually distinct from upcoming ones
- Smooth expand/collapse — no janky snapping
- Feels like a real conference schedule, not a styled bullet list

## Your Constraint
You own `<section id="agenda">` and can append styles to the `<style>` block.
Do not touch any other section or existing CSS rules.

## Time Budget
~25 minutes to build. Save 5 minutes to explain your prompting choices.

## Suggested Starting Prompt

Paste this into your Claude Code session to begin:

```
Read the index.html file in full.

I need to replace the content inside <section id="agenda"> with an interactive
timeline component. I will also need a <script> block and new CSS appended to
the existing <style> block.

Requirements:
1. Each agenda item is a clickable row that expands to show a description
2. A "current" indicator highlights the active agenda item, calculated from
   a SESSION_START time you define at the top of the script (set it to
   the current time minus a few minutes so something is already "active")
3. Completed items (before current) show a muted/checked visual state
4. Upcoming items show normal state
5. Smooth CSS transition on expand/collapse (max-height approach)
6. Use only the existing CSS variables — no hardcoded colours

The descriptions for each item are in CLAUDE.md.

Return three separate blocks clearly labelled:
- SECTION HTML (replaces content inside #agenda)
- CSS TO APPEND (add to end of existing <style>)
- SCRIPT BLOCK (new <script> at end of <body>)
```

## Iteration Tips
- If expand/collapse is janky: "The animation needs to use max-height transition,
  not display toggle. Current state snaps instead of animates."
- If the active detection is wrong: "The active item logic should compare elapsed
  minutes since SESSION_START against each item's timestamp offset."
- If styles bleed: "Check that your new CSS classes don't accidentally override
  existing styles elsewhere on the page."
