# Icons — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "the icons and symbols needs to be changed as well. They should be using the SF Pro."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, every page. The Icon component is `528:47`.

## What changed

Every Material icon in the file is now an SF Symbol, drawn as a character of SF Pro, as in Apple's kit. That's about 24,000 pieces of text across all 12 pages: 184 Material glyphs became 160 symbols (plus 17 filled or outline variants of them, below).

- **Material fonts left in the file: none** (read on every page, `Material Symbols Rounded` and `Material Icons Round`).
- **No screen moved.** An icon's box stays the size it was (a 24 box stays 24), and the symbol sits centred in it.
- **Layers:** a text layer named after its glyph, and `Icon · …` and `Icon button · …`, now carry the symbol's name.

## Where each part comes from

- **Which symbol:** the app's own symbol for the same job first (`iOS/Habits/AddHabit/Appearance.swift`'s `IconLibrary` for habits, `Today` and `Menu` for the chrome), then the closest meaning. Every name was checked against this Mac's symbol set.
- **Which code:** macOS has no table of SF Pro's codes. So 9,600 codes (U+100000 to U+10257F) were drawn as contact sheets in Figma, and each symbol, rendered with `NSImage(systemSymbolName:)`, was matched against them by shape (`Research/Temp/ios-icons/`, git-ignored). Then every match was looked at beside the symbol. Four matches were wrong and were corrected by eye: `battery.100`, `camera.fill`, `play.circle`, `arrow.uturn.backward`.
- **The size:** 0.84 × the Material size, Regular (24→20, 22→18, 20→17, 18→15, 16→13, 14→12, 12→10). An SF symbol fills more of its size than a Material glyph does. A habit's glyph in a filled circle is 0.48 × the circle, which is what `HabitIcon` draws (`Components/Components.swift:42`): 32→15.

## Filled or outline

Figma keeps each Material text's fill setting (`fontName.variationSettings.FILL`), so the screens follow what Android's file drew, with two rules on top:

- **A habit's or task's own icon is always `.fill`,** as in the app's `IconLibrary`, even where Android's lists drew it outlined (Edit Today, the icon picker). A habit looks the same everywhere.
- **▶ and ⏸ are always filled** (Rulebook, A101).

| Android, where it was filled | SF Symbol | Code |
|---|---|---|
| notifications | `bell.fill` | U+1002DA |
| schedule | `clock.fill` | U+10042C |
| add_circle | `plus.circle.fill` | U+10004D |
| pause_circle | `pause.circle.fill` | U+100298 |
| play_circle | `play.circle.fill` | U+100296 |
| stop_circle | `stop.circle.fill` | U+10072B |
| info | `info.circle.fill` | U+100175 |
| help | `questionmark.circle.fill` | U+10005D |
| error | `exclamationmark.circle.fill` | U+10005F |
| archive | `archivebox.fill` | U+10022E |
| delete | `trash.fill` | U+100212 |
| visibility | `eye.fill` | U+1002EE |

| Android, where it was an outline | SF Symbol | Code |
|---|---|---|
| favorite (Plus's rows) | `heart` | U+1002B4 |
| star | `star` | U+1002C2 |
| bolt | `bolt` | U+1002E5 |
| lightbulb | `lightbulb` | U+1006ED |
| check_circle | `checkmark.circle` | U+100062 |

## The table

**Habit and task icons:**

| Android | SF Symbol | Code |
|---|---|---|
| flight | `airplane` | U+100453 |
| recycling | `arrow.3.trianglepath` | U+10065B |
| healing | `bandage.fill` | U+100394 |
| payments | `banknote.fill` | U+100B80 |
| bed | `bed.double.fill` | U+10066A |
| directions_bike, pedal_bike | `bicycle` | U+100865 |
| bolt | `bolt.fill` | U+1002E6 |
| menu_book | `book.fill` | U+10025B |
| psychology | `brain.head.profile` | U+100BCF |
| chat | `bubble.left.fill` | U+10032B |
| cleaning_services | `bubbles.and.sparkles.fill` | U+10148A |
| photo_camera | `camera.fill` | U+10031F |
| directions_car | `car.fill` | U+100659 |
| shopping_cart | `cart.fill` | U+10036A |
| translate | `character.book.closed.fill` | U+100AD6 |
| task_alt | `checkmark.circle` | U+100062 |
| medical_services | `cross.case.fill` | U+100BDA |
| local_hospital | `cross.fill` | U+1008DD |
| coffee | `cup.and.saucer.fill` | U+100E19 |
| savings | `dollarsign.circle.fill` | U+100598 |
| water_drop | `drop.fill` | U+100812 |
| fitness_center | `dumbbell.fill` | U+10158D |
| accessibility_new | `figure.arms.open` | U+1015C5 |
| sports_gymnastics | `figure.flexibility` | U+101551 |
| hiking | `figure.hiking` | U+10152D |
| self_improvement | `figure.mind.and.body` | U+101534 |
| pool | `figure.pool.swim` | U+101306 |
| rowing | `figure.rower` | U+10130B |
| directions_run | `figure.run` | U+100433 |
| directions_walk | `figure.walk` | U+100762 |
| set_meal | `fork.knife` | U+100E29 |
| card_giftcard | `gift.fill` | U+10044A |
| public | `globe` | U+1001AA |
| school | `graduationcap.fill` | U+100AD4 |
| clean_hands | `hands.and.sparkles.fill` | U+100CAF |
| favorite | `heart.fill` | U+1002B5 |
| home | `house.fill` | U+10039F |
| phone_iphone, smartphone | `iphone` | U+1007DC |
| local_florist, potted_plant, spa | `leaf.fill` | U+100973 |
| lightbulb | `lightbulb.fill` | U+1006EE |
| inventory | `list.clipboard.fill` | U+10155D |
| bedtime | `moon.fill` | U+1001BA |
| music_note | `music.note` | U+10046A |
| palette | `paintpalette.fill` | U+100766 |
| rocket_launch | `paperplane.fill` | U+100220 |
| pets | `pawprint.fill` | U+100F9F |
| badge | `person.text.rectangle.fill` | U+100FD3 |
| call | `phone.fill` | U+10033F |
| photo_library | `photo.on.rectangle` | U+1003EB |
| piano | `pianokeys` | U+1007FD |
| medication, pill | `pills.fill` | U+100832 |
| kitchen | `refrigerator.fill` | U+10141F |
| monitor_weight | `scalemass.fill` | U+100B6E |
| inventory_2 | `shippingbox.fill` | U+100419 |
| shower | `shower.fill` | U+1014C3 |
| smoke_free | `smoke.fill` | U+1001E3 |
| sports_soccer | `soccerball` | U+1015C8 |
| auto_awesome | `sparkles` | U+1001BF |
| edit_note | `square.and.pencil` | U+10020E |
| star | `star.fill` | U+1002C3 |
| vaccines | `syringe.fill` | U+100838 |
| sell | `tag.fill` | U+1002E2 |
| sports_tennis | `tennis.racket` | U+1015CD |
| yard | `tree.fill` | U+101770 |
| local_shipping | `truck.box.fill` | U+10107F |
| local_laundry_service | `washer.fill` | U+101421 |

**Actions, states and chrome:**

| Android | SF Symbol | Code |
|---|---|---|
| alarm | `alarm` | U+10042D |
| alarm_on | `alarm.fill` | U+10042E |
| archive | `archivebox` | U+10022D |
| refresh | `arrow.clockwise` | U+100148 |
| settings_backup_restore | `arrow.counterclockwise` | U+100149 |
| autorenew | `arrow.triangle.2.circlepath` | U+1002AF |
| swap_vert | `arrow.up.arrow.down` | U+10012C |
| arrow_outward, open_in_new | `arrow.up.right` | U+10012F |
| first_page | `arrow.up.to.line` | U+10013F |
| undo | `arrow.uturn.backward` | U+100C4D |
| arrow_right | `arrowtriangle.right.fill` | U+100127 |
| battery_full | `battery.100` | U+1006E8 |
| notifications | `bell` | U+1002D9 |
| notifications_active | `bell.badge` | U+100756 |
| notifications_off, notifications_paused | `bell.slash` | U+1002DD |
| chat_bubble | `bubble.left` | U+10032A |
| calendar_month, calendar_today, calendar_view_week, date_range, event, today | `calendar` | U+100249 |
| event_available | `calendar.badge.checkmark` | U+101EE7 |
| event_repeat | `calendar.badge.clock` | U+1009DE |
| insights | `chart.bar.xaxis` | U+1008C9 |
| trending_down | `chart.line.downtrend.xyaxis` | U+101633 |
| trending_up | `chart.line.uptrend.xyaxis` | U+100441 |
| checklist | `checklist` | U+100DFE |
| check | `checkmark` | U+100185 |
| check_circle, done_all | `checkmark.circle.fill` | U+100063 |
| cloud_done | `checkmark.icloud` | U+100893 |
| expand_less | `chevron.down` | U+100188 |
| arrow_back, chevron_left | `chevron.left` | U+100189 |
| code | `chevron.left.forwardslash.chevron.right` | U+10065A |
| chevron_right, expand_more | `chevron.right` | U+10018A |
| arrow_drop_down, arrow_drop_up | `chevron.up.chevron.down` | U+10018F |
| radio_button_unchecked | `circle` | U+100000 |
| contrast | `circle.lefthalf.filled` | U+10084E |
| schedule | `clock` | U+10042B |
| history | `clock.arrow.circlepath` | U+1008D4 |
| backspace | `delete.left` | U+10019B |
| content_paste | `doc.on.clipboard` | U+100243 |
| content_copy | `doc.on.doc` | U+100241 |
| picture_as_pdf | `doc.richtext` | U+100245 |
| description | `doc.text` | U+10023F |
| folder_zip | `doc.zipper` | U+100927 |
| more_vert | `ellipsis` | U+100360 |
| pending | `ellipsis.circle` | U+100361 |
| error | `exclamationmark.circle` | U+10005E |
| cloud_alert, link_off | `exclamationmark.icloud` | U+100311 |
| notification_important | `exclamationmark.triangle` | U+1001FE |
| visibility | `eye` | U+1002ED |
| sentiment_satisfied | `face.smiling` | U+10064C |
| redo | `forward` | U+10028B |
| speed | `gauge.with.dots.needle.33percent` | U+101C09 |
| settings | `gear` | U+10035F |
| policy | `hand.raised` | U+10027B |
| hourglass_top | `hourglass` | U+100587 |
| add_to_drive, cloud_upload | `icloud.and.arrow.up` | U+100317 |
| cloud_off | `icloud.slash` | U+10030F |
| all_inclusive | `infinity` | U+100BE0 |
| info | `info.circle` | U+100174 |
| vibration | `iphone.radiowaves.left.and.right` | U+100847 |
| drag_handle, drag_indicator, menu | `line.3.horizontal` | U+100307 |
| list | `list.bullet` | U+1002F2 |
| search | `magnifyingglass` | U+1002AB |
| mic | `mic` | U+1002B0 |
| block | `nosign` | U+10037C |
| sticky_note_2 | `note.text` | U+1004D5 |
| tag | `number` | U+100183 |
| attach_file | `paperclip` | U+100262 |
| send | `paperplane.fill` | U+100220 |
| pause_circle | `pause.circle` | U+100297 |
| pause | `pause.fill` | U+100286 |
| edit | `pencil` | U+10020A |
| person_add | `person.badge.plus` | U+100715 |
| switch_account | `person.crop.circle` | U+10026D |
| gif_box, image | `photo` | U+1003C5 |
| play_circle | `play.circle` | U+100295 |
| play_arrow | `play.fill` | U+100284 |
| add | `plus` | U+10017C |
| add_circle | `plus.circle` | U+10004C |
| help | `questionmark.circle` | U+10005C |
| keyboard_return | `return` | U+100147 |
| workspace_premium | `rosette` | U+1006EF |
| shift | `shift` | U+10019D |
| tune | `slider.horizontal.3` | U+100306 |
| space_bar | `space` | U+10107A |
| volume_up | `speaker.wave.2` | U+1002A6 |
| save | `square.and.arrow.down` | U+100204 |
| share | `square.and.arrow.up` | U+100202 |
| apps, widgets | `square.grid.2x2` | U+1001F7 |
| stop_circle | `stop.circle` | U+10072A |
| table | `tablecells` | U+1003E3 |
| sort_by_alpha | `textformat` | U+100152 |
| timer | `timer` | U+100431 |
| delete, delete_forever | `trash` | U+100211 |
| unarchive | `tray.and.arrow.up` | U+100225 |
| wifi_off | `wifi.slash` | U+100648 |
| close | `xmark` | U+100184 |

**This table is Figma's. Backup files have their own:** a habit stores all its icon's names, so a file keeps the icon on the other platform ([To Build](<Icon Names in Backup Files — To Build.md>)).

## Choices worth checking

These have no exact twin, so the closest was chosen:

- **`redo` → `forward`:** it's Skip, and the app's Skip is `forward`.
- **`sticky_note_2` → `note.text`:** what the app's Note uses.
- **`drag_indicator` → `line.3.horizontal`:** iOS's reorder grip.
- **`arrow_back` → `chevron.left`:** iOS's Back has no arrow.
- **`arrow_drop_down` → `chevron.up.chevron.down`:** a Pop-up button's mark ([Inputs](<Inputs — iOS Native.md>)).
- **`expand_more` → `chevron.right`, `expand_less` → `chevron.down`:** closed and open, as section 08 decided ([Lists and Rows](<Lists and Rows — iOS Native.md>)).
- **`smoke_free` → `smoke.fill`:** Apple has no "no smoking" symbol. The app's own list has `smoke.fill`.
- **`local_shipping`, `rocket_launch`, `recycling`, `yard`, `spa`, `potted_plant`, `local_florist`:** `truck.box.fill`, `paperplane.fill`, `arrow.3.trianglepath`, `tree.fill`, and `leaf.fill` for the last three. Three Android plants are one leaf here; they aren't side by side in the icon picker.
- **`cleaning_services` → `bubbles.and.sparkles.fill`, `monitor_weight` → `scalemass.fill`, `savings` → `dollarsign.circle.fill`:** the nearest meanings.
- **`widgets`, `apps` → `square.grid.2x2`; `workspace_premium` → `rosette`** (it has no filled form).

**Apple's rules:** the iCloud symbols may only refer to iCloud, and the iPhone symbols only to the iPhone (`symbol_restrictions.strings`), so `add_to_drive` and `cloud_*` are correct only once those flows really are iCloud. Their words still say Google Drive ([System Bars](<System Bars — iOS Native.md>)).

## Fixed along the way

- **A grey square behind 60 icons on Plus:** Android's avatar fill left on the copies, with no radius once the slot became 24. Cleared.
- **A widget's "+500"** was word text in a Material font. It's `iOS/Caption 1/Semibold` now, so it fits its 34 button; "+1" stays Subheadline Semibold.

## What's different on other pages

- **Wide symbols overhang their 24 box slightly:** Vibration's `iphone.radiowaves.left.and.right` and `chevron.left.forwardslash.chevron.right` in Settings, where they sit in a row of narrower ones. iOS's own Settings gives each row a fixed-width symbol column too, so it's left.
- **The Gboard keyboards are still Android's layout,** now with SF symbols on their keys (`delete.left`, `shift`, `return`, `mic`). Apple's kit has a real keyboard to replace them with.
- **Hidden layers inside copies weren't visited,** because an instance's `children` leaves them out. One that holds an old name would show the word if someone switches it on.
- **Component descriptions** still mention Material names in places ([Text Styles](<Text Styles — iOS Native.md>)).
- **Six "+1" labels on the Widgets page are still Google Sans Flex** (`2116:9830`, `2118:9794` and their smaller copies). They're words, not icons, so this change left them.

## Checked

Read on all 12 pages: no Material font, and no icon text still holding a Material name. Two lowercase "search" labels on Habits & Tasks are arrow labels, so they stayed.

Looked at by eye: the 160 symbols beside their codes, sections 08, Today, Edit Today, the icon picker, the routine player, Habits, Settings, Day details, Plus, a backup page and a file page in Onboarding, the 2×2 widgets, and Notifications at a small size.

**Not looked at:** every flow screen, Tasks, History at full size, Widgets beyond the 2×2 board, and dark screens. **Not measured:** the 0.84 was judged by eye against the phone's symbols, not read from the phone. No change was made to the iPhone app.

**The symbol set on this Mac is newer than Figma's SF Pro** in places: `iphone`, for one, draws differently here. Figma's drawing is what's on the screens; the app will draw whatever iOS has.

## Checking this in Figma

- **Copies with their own characters keep the old word when a parent's font changes.** Thousands came out as the word "check" in SF Pro after the copies above them changed. Mark what's left to do by the characters as well as the font.
- **Change copies before mains,** or a copy with its own size can't be told from one that inherited it. Pin the mains' text boxes first (`textAutoResize = NONE`), since a copy's child can't be resized.
- **`fontName` carries the variable axes,** so `FILL`, `wght` and `GRAD` can be read from it.
- **A rename by pattern needs a look at what it hit.** Matching "· word" also renamed "Home screen · widgets", "Red · today", "Month · menu" and a variant. They were restored from the Android file, which keeps the same node ids. Restrict by prefix.
- **`get_screenshot` takes `maxDimension`,** default 1024: 1920 gave contact sheets a clean 48-pixel cell.
- **Shared plugin data works as scratch between scripts** (namespace of 3+ characters): the table went in once rather than in every call. Clear it afterwards.
