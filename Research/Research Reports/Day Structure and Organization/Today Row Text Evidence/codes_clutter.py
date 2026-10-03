"""Hand codes for narrowed_clutter.json (165 read, 3 Oct 2026). Index -> codes. Unlisted = off topic."""
CODES = {
 # Things other than the person's habits crowd the main list (cards, banners, tips, ads)
 **{i: ['extras_crowd_list'] for i in [4, 5, 6, 16, 18, 20, 21, 22, 23, 24, 29, 30, 31, 32, 34, 35, 36, 37, 38, 39, 40, 41,
                                       42, 43, 44, 45, 46, 47, 48, 87, 88, 89, 90, 91, 92, 96, 97, 99, 100, 101, 104, 160]},
 # Extra text on rows is clutter
 17: ['text_clutter'], 26: ['text_clutter'], 87: ['text_clutter', 'extras_crowd_list'],
 # A label repeated beneath every item is clutter; a group heading would do (native)
 121: ['repeated_label_clutter', 'native'],
 # Text and images overlapping / runs into each other
 102: ['overlap'],
 # Done (or skipped) items should go below the rest so the list stays clear
 76: ['done_sink'], 109: ['done_sink', 'native'], 119: ['done_sink', 'native'], 124: ['done_sink', 'native'], 53: ['done_sink'],
 # Not-today items clutter the list
 67: ['not_today_clutter'], 74: ['not_today_clutter'], 75: ['not_today_clutter'], 111: ['not_today_clutter', 'native'],
 150: ['not_today_clutter', 'native'],
 # Spacing: uneven or cramped rows, controls too close together
 110: ['spacing', 'native'], 128: ['spacing', 'native'], 59: ['spacing'],
 # Long single list overwhelming: wants grouping
 **{i: ['long_list'] for i in [11, 12, 14, 15, 56, 62, 63, 68, 70, 72, 73, 79, 81, 103, 107]},
}
