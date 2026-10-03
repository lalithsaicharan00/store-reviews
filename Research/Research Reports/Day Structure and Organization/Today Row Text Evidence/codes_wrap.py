"""Hand codes for narrowed_wrap.json (204 read, 3 Oct 2026; idioms such as "wrap up", "cut off a bad habit" and
spreadsheet cell wrapping are off topic). Index -> codes."""
CODES = {
 # A habit's or task's name cut off so it can't be read
 1: ['name_cut_off'], 21: ['name_cut_off'], 34: ['name_cut_off'], 60: ['name_cut_off'], 135: ['name_cut_off', 'native'],
 144: ['name_cut_off', 'native'], 146: ['name_cut_off', 'native'],
 # Prefers a long name to run onto a second line rather than end in "…"
 18: ['name_wrap_wanted'], 138: ['name_wrap_wanted', 'native'], 139: ['name_wrap_wanted', 'native'],
 # A second line with lots of spacing costs rows on screen (native)
 191: ['second_line_spacing', 'native'],
 # Fewer lines per item wanted
 74: ['fewer_lines'],
 # Text overlapping other text
 78: ['overlap', 'native'], 79: ['overlap', 'native'],
 # Larger text sizes cut things off
 180: ['dynamic_type_cut', 'native'],
 # Long notes cut off / hidden behind controls
 17: ['note_hidden'], 189: ['note_hidden', 'native'], 174: ['note_hidden', 'native'], 172: ['note_hidden', 'native'],
}
