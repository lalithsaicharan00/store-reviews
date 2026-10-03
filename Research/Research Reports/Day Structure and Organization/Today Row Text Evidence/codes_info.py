"""Hand codes for narrowed_info.json (129 read, 3 Oct 2026). Index -> codes. Unlisted = off topic."""
CODES = {
 # Wants (or praises) the streak shown on the main list's row
 1: ['streak_on_row'], 2: ['streak_on_row'], 14: ['streak_on_row', 'praise'], 40: ['streak_on_row'], 41: ['streak_on_row'],
 42: ['streak_on_row'], 53: ['streak_on_row'], 55: ['streak_on_row'], 56: ['streak_on_row', 'praise'], 62: ['streak_on_row'],
 64: ['streak_on_row'], 68: ['streak_on_row', 'praise'], 69: ['streak_on_row'], 74: ['streak_on_row'], 76: ['streak_on_row'],
 83: ['streak_on_row'],
 # Wants the set time shown on the row
 0: ['time_on_row'], 8: ['time_on_row'], 75: ['time_on_row', 'amount_on_row', 'praise'], 65: ['time_on_row_wrong'],
 # Wants today's progress / amount on the row or main screen
 17: ['progress_on_row'], 71: ['progress_on_row', 'praise'], 123: ['progress_on_row', 'native'], 125: ['progress_on_row', 'native'],
 # Wants how often (frequency) on the row
 60: ['frequency_on_row'],
 # A weekly habit doesn't show it was done today
 70: ['weekly_done_today'],
 # A subtitle that nags ("NOT TRACKED TODAY")
 39: ['nagging_subtitle'],
 # Wants one-time tasks on the main screen
 82: ['task_on_list'],
}
