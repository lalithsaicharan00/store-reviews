# Round 3 follow-up (2026-09-24): edit the existing round-3 section (79:2), no round 4

## The user's points

1. **View sheet headings.**
   - Layouts, Day sections and Groups all get the same heading style (16 px bold), each with a subtext line underneath.
   - Layouts: "Layouts" + "How cards look".
   - Day sections and Groups: a small line explaining that the number beside each is how many habits are *for today*, not the total.
     - Never use the word "due".
     - Make the line smart:
       - if every section's today count equals its total, the line isn't needed;
       - if only one or two differ, name those specifically.
     - The same for groups.
2. **The today card in the calendar strip.** It looks odd, especially where "5 of 11" sits. Improve it, using internal or external research.
3. **Deleting a section.** Tapping an existing section in the Day sections editor needs an edit screen with **Delete**. It's missing.
4. **The empty edge case.**
   - The user deletes all sections, then adds a first one. They should be able to set a start and an end time, or no time at all.
   - Research:
     - Should the default sections (Anytime, Morning, Afternoon, Evening) be deletable at all?
     - If yes, start and end must be editable.
     - Can end times auto-fill?
5. **Group order.** Is manual reordering of groups needed? Groups appear only in filters and in the habit form. Maybe alphabetical or by count is enough.

## Questions (one short report each; 3 and 4 merge because they are the same flow)
- **Q21:** heading hierarchy and the smart count line (wording without "due").
- **Q22:** the today card and where the count goes.
- **Q23:**
  - deleting sections (defaults, Anytime);
  - deleting everything and the first-section edge case;
  - start/end times and untimed sections.
- **Q24:** manual group order versus automatic sorting.
