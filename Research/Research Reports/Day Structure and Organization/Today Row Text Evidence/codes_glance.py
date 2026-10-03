"""Hand codes for narrowed_glance.json (495 read, 3 Oct 2026; 262 calendar hits read in a 250-character window around
"at a glance"). Index -> codes. Unlisted = off topic (month views, widgets, app icons, general praise)."""
CODES = {
 # Done vs still to do must read at a glance on the list
 1: ['done_vs_left'], 25: ['done_vs_left'], 33: ['done_vs_left', 'praise'], 92: ['done_vs_left', 'praise'],
 93: ['done_vs_left', 'praise'], 97: ['done_vs_left'], 103: ['done_vs_left', 'praise'],
 # Something else on the row (streaks) hid whether today is done
 91: ['streak_hides_today'],
 # Streak on the row
 73: ['streak_on_row'], 74: ['streak_on_row'], 76: ['streak_on_row', 'praise'], 82: ['streak_on_row', 'praise'], 116: ['streak_on_row', 'praise'],
 # Progress toward the goal on the row (where you are against the target)
 80: ['progress_on_row'], 86: ['progress_on_row'], 90: ['progress_on_row'], 123: ['progress_on_row', 'praise'],
 # Which days / how often, on the row
 100: ['frequency_on_row'],
 # Mixed formats on one list are confusing: one way of reading every row
 64: ['one_model'], 77: ['one_model'],
 # Time since last done, beneath the name
 60: ['time_since_on_row'],
 # Quit counters: the elapsed time is what people look at
 44: ['quit_elapsed', 'praise'], 46: ['quit_elapsed', 'praise'], 49: ['quit_elapsed', 'praise'], 50: ['quit_elapsed', 'praise'],
 52: ['quit_elapsed', 'praise'], 55: ['quit_elapsed', 'praise'],
 # Too big / too spread out to see the day at once
 29: ['too_big'], 161: ['too_big', 'native'], 166: ['too_big', 'native'],
 # Tasks and habits told apart on one list
 115: ['task_habit_apart', 'praise'], 135: ['task_habit_apart', 'praise'], 163: ['task_habit_apart', 'native'],
 # Native: symbols without words tell nothing; numbers and words wanted
 203: ['words_over_symbols', 'native'], 216: ['words_over_symbols', 'native'], 230: ['words_over_symbols', 'native'],
 234: ['words_over_symbols', 'native'], 235: ['words_over_symbols', 'native'], 236: ['words_over_symbols', 'native'],
 250: ['words_over_symbols', 'native'], 255: ['words_over_symbols', 'native'], 268: ['words_over_symbols', 'native'],
 283: ['words_over_symbols', 'native'], 284: ['words_over_symbols', 'native'], 487: ['words_over_symbols', 'native'],
 494: ['words_over_symbols', 'native'],
 # Native: kinds told apart at a glance (colour per kind)
 202: ['kinds_apart', 'native'], 214: ['kinds_apart', 'native'], 243: ['kinds_apart', 'native'], 274: ['kinds_apart', 'native'],
 350: ['kinds_apart', 'native'],
}
