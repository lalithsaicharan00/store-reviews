"""Hand codes for narrowed_task.json (24 read) and narrowed_note2.json (55 read: notes on a habit or check-in, plus the
native Notes app), 3 Oct 2026. Index -> codes."""
TASK = {
 1: ['task_habit_apart'], 4: ['task_habit_apart', 'praise'], 5: ['task_habit_apart'], 6: ['task_habit_apart'],
 7: ['task_habit_apart', 'praise'], 9: ['task_habit_apart', 'praise'], 10: ['task_habit_apart'], 11: ['task_habit_apart'],
 12: ['task_habit_apart'], 17: ['task_habit_apart', 'praise'], 18: ['task_habit_apart'], 23: ['task_habit_apart'],
 14: ['task_habit_same'],
}
NOTE = {
 # Typing a note needs room: a bigger field, the whole note in view
 2: ['note_room'], 3: ['note_room', 'note_lost'], 9: ['note_room'],
 # Notes lost while or after writing (habit apps), and the native Notes app
 1: ['note_lost'], 4: ['note_lost'], 10: ['note_lost'], 11: ['note_lost'], 12: ['note_lost'],
 **{i: ['note_lost', 'native'] for i in [17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 38,
                                         39, 40, 41, 42, 44, 45, 46, 47, 48, 49, 50, 52, 53, 54]},
 # Wants the note shown under the habit on the list
 7: ['note_on_row'],
 # Wants a note per day / per check-in
 6: ['note_per_day'], 8: ['note_per_day'], 0: ['note_per_day', 'praise'],
}
