# Section Header — Start and Left Checklist

Written by Claude (Claude Code), 28 September 2026, from the user's request of the same day. Research goes in
[Section Header — Start Button, Left Count and Icons](<../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Section Header — Start Button, Left Count and Icons.md>).

**Context (the user's words, tidied):** Today works like Routinery: full-screen, focused running of habits. Each time of day (Morning, Afternoon…) is a routine, so each section has a **play** button that starts it.

## Every point the user made

| # | Requirement | Research? |
|---|---|---|
| R1 | Each time-of-day section acts as a routine ("Morning routine"), started with play | Context |
| R2 | Earlier, the play button appeared only in the **active (Now) section, when it was open**, as a button with a play icon **and the text "Start"**. That worked well | Baseline |
| R3 | Since the play button was added to every section, **"N left" disappeared**. That's wrong | Bug |
| R4 | **How many are left is the most important thing** on a section, open or folded. People open the app often just to see it. The day bar already shows the day's total; each section needs its own | Show always |
| R5 | When everything in a section is done, show that it's all done. That's fine, but the current "✓ All done" takes too much room | Yes: compact format |
| R6 | **Open section:** a button with the play icon **and "Start"** | Decided by user |
| R7 | **Folded section:** only a play icon, no text | Decided by user |
| R8 | **The current (Now) section's button is the primary style** (filled, white) | Decided by user |
| R9 | **Open question:** when a section that **isn't** Now is folded, should it show a play button at all? | Yes: extensive |
| R10 | Space is tight. Find the best way to show left / done / play together. Consider other formats, e.g. "3/3 ✓" or "5 by 5" | Yes |
| R11 | Icons in a folded header: filling the room and ending with "+2" / "+3" is correct. But freeing room from status and play means **more icons show** | Keep, maximise |
| R12 | Follow the header's existing rules (the name gives way before Start and status; at most 8 letters folded, and so on) | Keep |
| R13 | Research extensively; note everything; best possible UX, matching what users expect | Process |
| R14 | Document it and implement it | Process |

## Tasks

- [x] **H1** Read the earlier decisions (Today reports on the section header, Start, "N left", Now) and the git history of this header, to see what changed and why
- [x] **H2** Reviews: what users expect from a section or routine header (how many are left, start buttons, "all done")
- [x] **H3** Decide R9 (play on folded non-Now sections) and R10 (compact left and done formats); measure the widths
- [x] **H4** Build it, then check with screenshots: Now open, Now folded, other open, other folded, all done, past day
- [x] **H5** Document in the report, the spec and Today Improvements
