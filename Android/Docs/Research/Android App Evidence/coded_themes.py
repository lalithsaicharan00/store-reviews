"""Hand coding of read/<theme>.txt (Play Store, English, 40+ characters, seeded random 40 per theme, seed 20261012).

reminders_unreliable codes:
  NOFIRE        a reminder or alarm doesn't come at all, or only sometimes
  ONLY_ON_OPEN  it appears only when the app is opened (the app was stopped in the background)
  STOPS_LATER   worked, then stopped after days, weeks, an update or an Android version
  NO_SOUND      a notification arrives but doesn't ring or vibrate as set
  STICKY        a persistent (sticky) notification disappears or broke
  MULTI         wants several reminders a day / repeating reminders
  OEM           names a phone maker or Android version
  PERMS         says all permissions were granted and it still fails
  NOISE         not a reminder failure
"""

CODED = {
    "reminders_unreliable": {
        "P2#11428": "ONLY_ON_OPEN", "P8#5318": "NOFIRE", "P24#2039": "NOFIRE", "P3#4973": "STOPS_LATER",
        "P126#43611": "NOFIRE", "P111#5024": "NO_SOUND", "P24#3468": "NOFIRE", "P3#9519": "NOFIRE MULTI",
        "P33#1187": "ONLY_ON_OPEN", "P18#722": "ONLY_ON_OPEN", "P126#40464": "NOFIRE", "P84#8465": "STOPS_LATER",
        "P24#9082": "NOFIRE", "P3#4624": "STICKY STOPS_LATER", "P12#41115": "NOFIRE", "P26#83": "NOFIRE",
        "P3#16345": "NOFIRE", "P3#14797": "ONLY_ON_OPEN STOPS_LATER", "P84#17354": "NO_SOUND", "P24#2437": "NOFIRE",
        "P49#1390": "NOFIRE", "P4#19624": "NOFIRE", "P33#564": "NOFIRE PERMS", "P3#7088": "STICKY STOPS_LATER",
        "P8#7532": "NOFIRE", "P12#16071": "NOISE", "P4#29868": "NOISE", "P2#2258": "STOPS_LATER OEM",
        "P36#267": "NOFIRE", "P105#691": "NOFIRE", "P24#9791": "NO_SOUND", "P3#15826": "NOFIRE",
        "P98#1106": "NOFIRE", "P84#19905": "NOFIRE", "P126#70972": "NOISE", "P126#63491": "NO_SOUND PERMS",
        "P24#1551": "STOPS_LATER OEM", "P24#7995": "NOFIRE MULTI", "P8#4852": "NOISE", "P8#6329": "NOFIRE OEM",
    },
    # battery_background: the pattern's "doze" also matched "dozen" (most NOISE here; disclosed in the report).
    # TRIED = turned off battery saving / whitelisted and reminders still fail; GUIDE = wants the app to help with
    # the battery setting; DRAIN = the app uses too much battery; FORCED = the app demands unlimited battery;
    # OEM = names a phone maker's system
    "battery_background": {
        "P3#11080": "NOISE", "P126#70351": "DRAIN", "P122#13031": "DRAIN", "P24#9690": "NOISE",
        "P5#1214": "TRIED NOFIRE", "P65#7454": "NOISE", "P84#17845": "NOISE", "P2#11310": "TRIED NOFIRE",
        "P45#61": "NOISE", "P12#8627": "NOISE", "P38#1080": "FORCED", "P84#24004": "DRAIN",
        "P2#11990": "TRIED ONLY_ON_OPEN", "P37#287": "NOISE", "P125#14401": "NOISE", "P12#54018": "NOISE",
        "P63#656": "NOISE", "P126#41455": "NOISE", "P8#3573": "STOPS_LATER", "P3#5567": "NOISE",
        "P84#21775": "NOISE", "P12#8589": "NOISE", "P126#26782": "OEM", "P24#2642": "NOISE",
        "P12#10361": "NOISE", "P2#3651": "NOISE", "P3#7583": "NOISE", "P49#268": "NOISE",
        "P122#18047": "NOISE", "P126#65336": "NOISE", "P3#9095": "TRIED OEM", "P84#25227": "TRIED ONLY_ON_OPEN",
        "P24#10984": "GUIDE", "P3#2190": "NOISE", "P63#934": "OEM", "P84#13153": "NOISE",
        "P3#8144": "TRIED NOFIRE", "P19#462": "NOISE", "P2#11262": "GUIDE", "P84#9687": "NOISE",
    },
    # widget_wanted: NO_WIDGET (the app has none) · MULTI_HABIT (one widget for all of today's habits, not one per
    # habit) · STATS_WIDGET (progress or statistics on the widget) · LOOK (transparent, colour, dark) · CALENDAR_WIDGET ·
    # SIZE (smaller sizes) · INTERACTIVE (tick from the widget) · MORE_WIDGETS · IMPROVE (other) · BROKEN · PAY
    # (willing to pay for it) · PARITY (other platform has it) · PRAISE
    "widget_wanted": {
        "P12#25712": "NO_WIDGET", "P111#10890": "NO_WIDGET", "P111#6353": "NO_WIDGET", "P3#9857": "MULTI_HABIT STATS_WIDGET",
        "P5#2861": "NO_WIDGET", "P84#31487": "LOOK", "P111#3315": "NO_WIDGET", "P111#9565": "NO_WIDGET",
        "P126#45574": "LOOK", "P12#15154": "NO_WIDGET", "P4#25831": "NO_WIDGET PARITY", "P10#7192": "NO_WIDGET",
        "P3#4548": "MULTI_HABIT", "P12#12634": "NO_WIDGET", "P3#12248": "MULTI_HABIT STATS_WIDGET", "P2#2204": "STATS_WIDGET",
        "P111#6998": "NO_WIDGET", "P111#11415": "NO_WIDGET", "P84#32436": "IMPROVE", "P84#31964": "SIZE",
        "P8#1437": "BROKEN INTERACTIVE", "P2#7983": "CALENDAR_WIDGET", "P111#7259": "NO_WIDGET", "P3#14430": "MORE_WIDGETS LOOK",
        "P3#4015": "MORE_WIDGETS", "P111#5628": "NO_WIDGET", "P3#9856": "MULTI_HABIT INTERACTIVE", "P126#48765": "LOOK",
        "P65#9689": "PRAISE", "P111#5576": "NO_WIDGET", "P111#11983": "NO_WIDGET", "P111#9670": "NO_WIDGET",
        "P65#8654": "IMPROVE", "P3#12195": "LOOK", "P111#4048": "CALENDAR_WIDGET", "P25#5": "NO_WIDGET PAY",
        "P8#9355": "NO_WIDGET", "P111#2023": "CALENDAR_WIDGET", "P30#4298": "NO_WIDGET", "P3#8172": "MULTI_HABIT",
    },
    # widget_broken: STALE (doesn't update until the app is opened, or freezes) · TAP_FAILS (a tap on it does nothing) ·
    # CANT_ADD (won't go on the home screen) · AFTER_RESTART (stops after the phone restarts) · BROKEN (other) ·
    # plus the widget_wanted codes; OEM = names a phone; PAID = paid for widgets that don't work; FEEDBACK = wants
    # haptics/sound from the widget; MISSING = promised widgets not there
    "widget_broken": {
        "P8#9241": "MISSING", "P145#398": "NO_WIDGET", "P9#880": "BROKEN PAID", "P3#6209": "PRAISE STATS_WIDGET",
        "P3#5496": "MULTI_HABIT", "P126#42055": "LOOK", "P56#37": "NO_WIDGET", "P84#13555": "CALENDAR_WIDGET",
        "P3#5005": "BROKEN", "P10#10942": "NO_WIDGET", "P84#30914": "PRAISE INTERACTIVE", "P31#437": "MULTI_HABIT BROKEN",
        "P49#3732": "SIZE MORE_WIDGETS", "P8#1570": "FEEDBACK", "P8#1326": "STALE", "P4#17482": "BROKEN OEM PAID",
        "P126#26680": "STALE", "P126#30502": "LOOK", "P8#8809": "STALE", "P8#1410": "STALE",
        "P8#2817": "STALE", "P111#7695": "NO_WIDGET", "P24#1714": "TAP_FAILS", "P3#5497": "TAP_FAILS OEM",
        "P31#449": "BROKEN", "P24#15474": "STALE", "P3#4077": "BROKEN", "P3#2339": "SIZE",
        "P8#1094": "CANT_ADD", "P3#2583": "CANT_ADD", "P111#2964": "NO_WIDGET", "P2#5069": "STALE",
        "P3#4905": "MULTI_HABIT", "P126#64916": "AFTER_RESTART", "P111#9429": "NO_WIDGET PARITY", "P24#10192": "NOISE",
        "P3#3905": "PRAISE", "P3#13247": "BROKEN", "P3#10644": "MULTI_HABIT", "P84#10940": "STALE OEM",
    },
    # dark_mode_theme: DARK_PRAISE · DARK_WANTED · FOLLOW_SYSTEM (follow the phone's light/dark, widgets too) ·
    # THEMES_WANTED (colours, fonts, sizes) · THEMES_PRAISE · FONT · DARK_PAYWALL · WIDGET_LOOK · CONTRAST ·
    # REGRESSION (an update changed the look) · LIGHT_WANTED · NOISE ("theme" meaning topic)
    "dark_mode_theme": {
        "P2#7501": "DARK_PRAISE", "P12#8402": "NOISE", "P4#10450": "DARK_WANTED", "P3#13631": "DARK_PRAISE",
        "P126#41021": "DARK_WANTED FOLLOW_SYSTEM", "P3#10867": "THEMES_WANTED", "P126#42529": "THEMES_WANTED", "P126#49497": "DARK_WANTED WIDGET_LOOK",
        "P12#31214": "NOISE", "P126#59250": "THEMES_WANTED FONT", "P126#49322": "THEMES_WANTED REGRESSION", "P125#16692": "CONTRAST DARK_PRAISE",
        "P84#32017": "DARK_PRAISE", "P3#2567": "DARK_PRAISE", "P3#10365": "DARK_PRAISE", "P49#2261": "DARK_PRAISE",
        "P3#5196": "DARK_PRAISE", "P3#4895": "THEMES_WANTED FONT", "P65#5298": "THEMES_WANTED", "P12#44192": "DARK_WANTED",
        "P126#46023": "THEMES_WANTED", "P84#16466": "THEMES_PRAISE", "P2#9737": "LIGHT_WANTED", "P5#1827": "THEMES_WANTED",
        "P2#7612": "FOLLOW_SYSTEM WIDGET_LOOK", "P3#10479": "DARK_PRAISE", "P2#7671": "THEMES_PRAISE", "P8#3599": "NOISE",
        "P8#6262": "NOISE", "P12#46606": "NOISE", "P3#11336": "DARK_PRAISE", "P2#4834": "THEMES_PRAISE",
        "P49#1903": "DARK_PAYWALL", "P65#3212": "REGRESSION", "P126#34319": "THEMES_WANTED FONT", "P65#4547": "DARK_WANTED",
        "P125#6731": "THEMES_PRAISE", "P65#2653": "DARK_WANTED", "P18#938": "WIDGET_LOOK DARK_WANTED", "P126#50868": "DARK_WANTED",
    },
    # back_navigation (all 108 matches; 40 read): BACK_LOSES_WORK (Back closes a form or journal and loses what was
    # typed) · BACK_EXITS (Back leaves the whole app instead of going one step back) · NO_BACK (a flow with no way back) ·
    # EDGE_TO_EDGE (content under or clashing with the status/navigation bars; transparent bars wanted) · STATUS_ICON
    # (an alarm icon or notification sits in the status bar) · PERSISTENT_NOTIF (a lasting notification wanted or
    # liked) · DARK_STATUS (notifications/status ignore dark mode) · BOTTOM_NAV (bottom navigation wanted) ·
    # NOTIF_OPENS_WRONG (a notification tap doesn't open the right place) · MATERIAL (wants Android's own look)
    "back_navigation": {
        "P136#8": "NOISE", "P126#45981": "BACK_LOSES_WORK", "P126#69256": "STATUS_ICON", "P82#47": "BOTTOM_NAV",
        "P87#73": "BACK_LOSES_WORK", "P122#9087": "EDGE_TO_EDGE", "P4#28225": "NOISE", "P24#3984": "BACK_EXITS",
        "P12#13659": "NO_BACK", "P126#73125": "DARK_STATUS", "P126#44237": "STATUS_ICON", "P126#37337": "DARK_STATUS",
        "P12#53776": "NOISE", "P130#134": "NOISE", "P5#2878": "EDGE_TO_EDGE", "P24#9443": "BACK_EXITS",
        "P122#2706": "BACK_EXITS", "P9#1325": "EDGE_TO_EDGE", "P49#885": "NOISE", "P126#17825": "STATUS_ICON",
        "P49#3169": "BACK_LOSES_WORK NOTIF_OPENS_WRONG", "P126#18736": "NOISE", "P12#57436": "NOISE", "P126#29613": "PERSISTENT_NOTIF",
        "P24#5431": "BACK_EXITS", "P12#47145": "NO_BACK", "P3#1698": "EDGE_TO_EDGE", "P84#7616": "PERSISTENT_NOTIF",
        "P12#34403": "NO_BACK", "P8#9911": "BACK_LOSES_WORK", "P33#1461": "NOISE", "P8#7895": "NOISE",
        "P3#14790": "NOISE", "P125#17362": "NOISE", "P126#68812": "STATUS_ICON", "P126#57315": "PERSISTENT_NOTIF",
        "P122#18837": "EDGE_TO_EDGE MATERIAL", "P122#4202": "BACK_EXITS", "P8#8274": "BACK_EXITS", "P111#2283": "BOTTOM_NAV",
    },
    # free_open_source (praise for what an app doesn't do): NOADS · FREE (all features free) · OPEN_SOURCE · OFFLINE ·
    # NO_ACCOUNT · PRIVACY · SIMPLE (clean, minimal, no clutter) · BACKUP · PAID_ANYWAY (bought or would pay although
    # free works) · LIGHT (small, no battery drain) · NOTES
    "free_open_source": {
        "P3#16025": "NOADS SIMPLE", "P122#3120": "NOADS FREE", "P3#1753": "NOADS NO_ACCOUNT OFFLINE BACKUP SIMPLE", "P3#1993": "FREE",
        "P3#1941": "NOADS FREE", "P8#9133": "OPEN_SOURCE", "P12#39713": "NOADS", "P8#4024": "OPEN_SOURCE",
        "P3#3860": "NOADS FREE SIMPLE", "P84#17305": "NOADS FREE PRIVACY", "P3#8834": "NOADS FREE SIMPLE", "P84#12514": "NOADS PRIVACY PAID_ANYWAY",
        "P3#11385": "NOADS SIMPLE", "P84#13995": "NOADS FREE", "P10#9075": "NOADS", "P122#10109": "NOADS SIMPLE",
        "P3#7689": "NOADS FREE SIMPLE PAID_ANYWAY", "P3#7735": "NOADS SIMPLE", "P84#14373": "NOADS FREE", "P8#5154": "NOADS",
        "P14#88": "NOADS OFFLINE NOTES PAID_ANYWAY", "P65#6759": "NOADS SIMPLE", "P3#1510": "FREE OPEN_SOURCE", "P122#13132": "NOADS SIMPLE",
        "P68#23": "NOADS OFFLINE NO_ACCOUNT PRIVACY SIMPLE LIGHT", "P84#18652": "NOADS", "P3#14798": "NOADS FREE SIMPLE", "P65#2154": "NOADS FREE",
        "P126#54677": "NOADS", "P122#2153": "NOADS", "P122#17447": "FREE PAID_ANYWAY", "P84#16719": "NOADS SIMPLE LIGHT",
        "P84#24315": "NOADS SIMPLE", "P126#29281": "NOADS OFFLINE", "P84#16016": "NOADS", "P2#1632": "NOADS SIMPLE PAID_ANYWAY",
        "P122#20414": "NOADS", "P12#55333": "NOADS PAID_ANYWAY", "P111#4539": "NOADS FREE", "P3#4022": "OPEN_SOURCE FREE BACKUP",
    },
    # home_screen_shortcut: ICON_LOOK (the app icon's shape/fill on Android launchers) · BADGE (a count on the app
    # icon) · SHORTCUT_WANTED (long-press or home-screen shortcuts, a Quick Settings tile) · SHORTCUT_PRAISE · TASKER
    # (automation) · WIDGET_OPENS (a widget tap doesn't open the app) · NAME (a short launcher name) · plus earlier codes
    "home_screen_shortcut": {
        "P3#2510": "SHORTCUT_WANTED", "P2#3840": "NOISE", "P24#4823": "NOISE", "P3#2701": "NOISE",
        "P9#845": "ICON_LOOK STATS_WIDGET", "P126#42437": "AFTER_RESTART", "P84#9836": "SHORTCUT_PRAISE", "P3#7874": "ICON_LOOK",
        "P12#10924": "NOISE", "P38#402": "INTERACTIVE", "P2#2464": "INTERACTIVE DARK_PAYWALL", "P19#383": "NAME",
        "P126#18424": "BADGE", "P9#1073": "ICON_LOOK INTERACTIVE STATS_WIDGET", "P58#14": "ICON_LOOK", "P3#14990": "NOISE",
        "P126#37779": "SHORTCUT_WANTED", "P20#45": "NOISE", "P24#8421": "NOISE", "P126#61211": "PERSISTENT_NOTIF",
        "P84#7078": "INTERACTIVE", "P126#75196": "NOISE", "P126#27007": "OEM", "P129#817": "SHORTCUT_WANTED",
        "P24#3259": "NAME", "P123#554": "NOISE", "P3#15544": "TASKER SHORTCUT_WANTED", "P3#15740": "NOISE",
        "P122#13935": "NOISE", "P84#19515": "BADGE", "P3#5501": "WIDGET_OPENS", "P84#15950": "NOISE",
        "P8#1375": "INTERACTIVE", "P126#60153": "SHORTCUT_WANTED", "P3#9300": "MULTI_HABIT", "P24#14433": "WIDGET_OPENS",
        "P126#48738": "SHORTCUT_WANTED", "P126#40186": "SHORTCUT_PRAISE", "P84#18260": "SHORTCUT_PRAISE", "P111#6145": "SHORTCUT_WANTED",
    },
}
