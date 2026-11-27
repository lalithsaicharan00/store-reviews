# Codebook — Home Screen: Time, Order and Weight

Written by Claude (Claude Code), 22 November 2026.

One line per review in codes/<batch>.txt: `idx<TAB>CODES<TAB>note`. CODES space-separated; `-` = nothing on these questions.
Code only what the reviewer says about their own items or wishes; no inference from the app's features alone.

## Q1 What kind of "when" do their items have (describe their own items)
- FIXED: a set clock time ("meds at 8", "reminder at 9pm")
- WINDOW: a part of the day (morning, afternoon, evening, night)
- ANCHOR: tied to an event (after brushing, when I get home, before bed, when I wake, after work)
- AMOUNT: an amount over the day (8 glasses, 10k steps, 30 min)
- MULTI: several times a day (take pills 3x, every 2 hours)
- PERIOD: n times a week/month, any days
- DAYS: specific weekdays
- INTERVAL: every N days / since last done
- DATE: a task with a date or deadline
- NODATE: a to-do with no date / someday / backlog
- QUIT: quit, avoid, limit
- ANYTIME: says plainly the item has no set time / do it whenever in the day

## Q2 Sequence
- SEQ: does things in an order (morning routine, stack, list order = order of doing) or wants the order kept
- SEQ_FREE: wants freedom to do them in any order / rejects a forced order

## Real life vs fixed time
- DRIFT: real life doesn't follow times (late, shift work, irregular days, travel, kids) and the app's times/days don't fit
- EXACT: wants exact clock times / parts of day too coarse

## Q3 Who decides what's "now"
- AUTO_GOOD: likes the app showing what's relevant now by itself (current part of day, only due)
- AUTO_BAD: dislikes the app hiding/switching by time or deciding for them
- PICK: wants to choose today's items themselves / plan each day / focus list
- SETUP: wants to set it once and not think again
- LEARN: wants the app to learn or suggest when

## Q5 Window passed / not done
- CARRY: wants undone items to stay or carry over (later today or next day)
- VANISH_BAD: complains an undone item disappeared when its time/day/section passed
- PILEUP_BAD: overdue/missed items pile up and feel bad / wants them gone
- FRESH: wants each day to start clean
- LATE_LOG: wants to tick something done later than planned (late but still counts)

## Q4 Quit items
- QUIT_APART: wants quit/avoid items apart from to-do items, or treated differently (gauge, days since, no tick)
- QUIT_TOGETHER: wants them in the same list as the rest
- QUIT_URGE: the moment that matters is an urge/slip

## List length
- LEN:<n>: states how many items they have (number as said; ranges -> lower bound)
- LONG: says they have many / long list (no number)
- FEW: says they keep only a few on purpose

## "See it all" — which question
- Q_MISSING: is anything forgotten / missed / did I do it
- Q_LEFT: how much is left
- Q_NEXT: what's next / what now
- Q_DONE: what I've done today

## Heaviness — where it comes from
- H_ITEMS: the number of items / length
- H_DECIDE: choices, setup, options, deciding what to do
- H_FEEL: emotional weight (red, missed, counts, guilt, pressure)
- H_LOOK: visual busyness (cards, colours, ads, clutter)
- LIGHTER: likes the list getting lighter / shrinking as they go

## Trust vs lightness
- SEE_ALL: prefers everything visible even if long
- HIDE_OK: prefers hiding/folding even at the risk of forgetting
- HID_FORGOT: something hidden (folded, other page, other section, below fold) got forgotten
