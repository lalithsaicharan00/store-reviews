"""Hand-read map for "Today — Where Things Go, Other Days and Arranging" (Claude (Claude Code), 16 Oct 2026).

Each entry: cite ("A<n>#<line>" = App Store Reviews/<n>.*/reviews.jsonl line index; "P" = Play Store) -> a fragment
copied from that review. verify.py checks every fragment is in the review at that index.
Directional scans: keyword hits from scan.py, read by hand; not a whole-corpus coding.
"""

MAP = {
    # 1. Where untimed (Anytime) habits sit
    'untimed_after_timed': {
        'A4#7354': 'put the &#34;any time of the day&#34; task at the bottom of the screen instead of at the top',
        'P49#2650': 'visible below the scheduled ones',
        'A4#2652': 'my all day are the first ones',
    },
    'untimed_first': {
        'P126#38191': 'sort the "all day" items to the top',
    },
    # Quit counters: seen, and in the person's order
    'quit_seen_and_ordered': {
        'A3#7508': 'is the first thing I see when I unlock my phone',
        'A3#4174': 'longest counters on the top, or at the bottom, depending on what you want',
        'A3#7546': 'you can choose how to order the counters',
        'A3#1264': 'see the counters from the main screen',
    },
    # 2. Where a new habit goes
    'new_at_end': {
        'A1#48695': 'dont go from top to bottom, its from bottom to top',
        'A33#3402': 'instead of at the bottom - which would make sense for anyone creating a habit stack',
        'A4#2421': 'i want them at the bottom of the list',
        'P4#15479': 'it puts that one on top not bottom',
        'P4#22527': 'the new task I add always goes at the top',
        'P84#32138': 'instead of the order that I wrote them',
        'A85#2214': 'it automatically gets added at the top of the list',
        'A20#3549': 'can go down  to the bottom',
        'P84#31366': 'add the new task at the end of the list',
    },
    'new_at_top': {
        'A10#26449': 'why don’t new tasks appear at the top anymore',
        'A13#5812': 'would be really helpful if it was at the top of the list',
        'P122#15575': 'new exercises to be added to the top of the list',
        'P126#67133': 'I would prefer to see New Task list on the top',
    },
    'new_where_it_belongs': {
        'A13#9511': 'a new habit that I intend to do first, it is at the bottom',
        'A16#875': 'automatically places it at the bottom, creating some chaos',
        'A13#10717': 'you can’t ever add a step in between',
        'A1#55774': 'having it on the top of my list doesn’t help with the flow',
        'P84#19080': 'add things in-between',
    },
    'new_position_setting': {
        'P84#28329': 'whether new main lists are added to the top or bottom',
        'P84#31840': 'Configure whether new items get added to the top or bottom',
        'P84#8660': 'I can change where a new task show on lists',
        'A4#13197': 'Allow us to choose where new “all day” tasks go in the list',
    },
    # 3. Groups and colour
    'habit_colour_as_group_stand_in': {
        'P3#10242': 'I can basically do that with color',
        'P3#5286': 'I use colours for categories',
        'A20#1353': 'I have organised all of my “Sports” activities into the green colour',
        'P3#7230': 'sort habits by group instead of just color',
        'P3#3039': 'have groups for tasks in addition to colors',
        'P3#2718': 'set up categories other than the colors',
    },
    'group_colour_overrides_habit': {
        'P2#3259': 'the categories are color coded, not the habits',
    },
    # 5. Other days: future
    'complete_ahead': {
        'A1#44866': 'mark as done in advance if needed',
        'A1#45355': 'habits can’t be checked in advance',
        'A1#46194': 'complete habit for future days',
        'A1#48894': 'I cannot check the future date',
        'A13#13812': 'those tasks cannot be completed until tomorrow',
        'A4#2452': 'if you happen to get something done early',
        'A4#7026': 'tick it if it is for a future date',
        'A4#13269': 'mark things as done ahead of time',
        'A4#13876': 'it still won’t let you COMPLETE items ahead of time',
        'A4#18815': 'You also can’t mark things complete if you do them ahead of time',
        'A4#20007': 'you can’t complete tasks early',
        'P4#3928': 'check off items that are earmarked for a future date',
        'P2#3463': 'I want to check off tomorrow\'s tasks today',
    },
    'skip_ahead': {
        'P10#12215': 'mark future day tasks as complete or skip',
        'A76#5218': 'mark some days in advance with the &#34;pass&#34; symbol',
        'P2#3463': 'checkoff or skip tasks a day in advance',
    },
    'preview_ahead': {
        'A13#121': 'being able to check tomorrow, so I can now what I have to do',
        'A13#9378': 'habits to be completed today or tomorrow',
        'A23#2114': 'the ability to check the habits lined up for tomorrow',
        'A59#168': 'check my tasks for the day or tomorrow or future weeks',
        'P4#9169': 'I can make a check list today but it is for tomorrow',
    },
    'against_logging_ahead': {
        'A1#52989': 'you can’t check off a future habit',
        'P3#15515': 'the user should not be able to check future dates',
        'P41#60': 'won\'t allow ppl to tick tasks ahead of time',
        'P44#159': 'no back date & no future date',
        'P4#8420': 'reminds you to just focus on today',
        'P12#66772': 'check off items on your to do list in advance and for multiple days so what is the point',
    },
    'wrong_day_by_accident': {
        'P12#21591': 'if you check off tomorrow\'s routine by accident',
        'P130#134': 'leading you to mark tomorrow instead of today',
        'A24#37703': 'confirm the habit as completed for tomorrow, not today',
        'P98#1170': 'I had failed to complete tomorrow\'s habit instead of todays',
        'P12#115047': 'If you check "tomorrow night" tasks as done, you cannot remove the check',
    },
    'reminder_after_done_early': {
        'P2#1377': 'if we complete a habit/task in advance, the notification or alarm should ideally stop',
        'P2#4148': 'if say I complete a task ahead of time the alarms/notifications still go off',
        'P84#17855': 'it\'ll still keep coming up every single day',
    },
    # 6. Arranging
    'reorder_hidden': {
        'A1#2380': 'it&#39;s a bit hidden in the settings menu',
        'A3#4873': 'I don’t see why reordering can’t be done via drag ‘n drop versus separate “reorder” menu',
        'P2#11379': 'you just long press and then drag and drop them',
    },
    'order_must_stay': {
        'A13#13438': 'annoying to have to reorder 20 habits daily',
        'A4#18715': 'it goes out of order the next day',
        'A10#24627': 'every time I wake up in the morning I have to re-order them',
        'A4#17449': 'when I fix the order on one day, it messes with the order on the second day',
        'P4#28423': 'the order changes randomly as I go from one day to the next',
    },
    'order_per_weekday': {
        'A4#6772': 'reorder tasks per day',
        'A4#17598': 'ordering my tasks that stay the same for the days I choose',
        'P12#51559': 'save different orders for different days',
    },
    'within_time_of_day': {
        'P10#9167': 'reorder the tasks even if there are some periods',
        'P10#10919': 'rearrange the habit tiles within and morning afternoon, evening routines',
        'A13#13362': 'The ability to re-order your tasks within the time of day blocks was broken',
    },
    'between_times_of_day': {
        'A13#6565': 'an easier way to rearrange them between morning/afternoon/evening',
    },
    'section_order': {
        'A1#49737': 'manually rearrange the groups on the home page',
    },
    'drag_fails': {
        'P37#843': 'scrolls the whole page instead of sorting a habit',
        'P122#17777': 'jumps all the way to the top',
        'P8#8292': 'It usually just swaps things seemingly at random',
    },
    'keep_together': {
        'P5#803': 'link habits together so that they stay together when you reorder them',
    },
}
