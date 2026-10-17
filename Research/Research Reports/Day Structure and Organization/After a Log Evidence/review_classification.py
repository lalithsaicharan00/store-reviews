"""Hand-read map for "After a Log — Should Undo and Add Note Stay or Go" (Claude (Claude Code), 16 Oct 2026).
cite: A = App Store Reviews, P = Play Store Reviews, N = Native Store Reviews; <n>#<line in reviews.jsonl>."""
MAP = {
 'gone_too_soon': {
  'A10#25142': 'only the second after you complete it and then the option is gone',
  'P84#13346': 'the undo button should always be there',
  'P84#14533': 'gave you a little more time',
  'P84#25918': 'cannot hit the undo button before it disappears',
  'P84#31896': 'how to restore a deleted task beyond the undo period',
  'N8#24078': 'The temporary undo button at the bottom of the screen is gone',
 },
 'floating_undo_in_the_way': {
  'N6#6972': 'hidden behind the toast “Task completed | Undo” each time I mark a subtask done',
  'N8#2661': 'the pop-up blocks the area where I need to tap to complete the next task',
  'N8#16081': 'has an Undo button right at the place where the Plus button is located',
  'N8#24001': 'it hovers over for 2 second covering the “task completed” button for the next task',
  'N7#9835': 'the “undo” banner persists and blocks the delete button',
  'N7#3187': 'it stays on the screen for way too long',
  'N7#3197': 'Bug is “Undo” pop-up won’t go away',
  'P84#29974': 'the undo button covers the new task button',
  'P84#8732': 'I could not undo it because the add task plus was in the way',
 },
 'asks_for_a_brief_popup': {
  'N10#20775': 'An undo button that appears for a few seconds on the screen would be a great addition',
  'N10#11474': 'Please add a undo popup when you complete a task',
  'P126#21471': 'adding an Undo option in the “Task Finished” snackbar',
 },
 'controls_that_come_and_go_unpredictably': {
  'N3#24367': 'the undo and redo features appear and disappear along the top at random',
  'N1#25369': 'When you check off an item it hesitates before it removes it',
 },
}
