"""Hand codes for narrowed_quit.json (465 read, 3 Oct 2026). Index -> codes. Unlisted = off topic (the word "quit" in
another sense: quitting the app, subscriptions, crashes)."""
ELAPSED = [81, 83, 84, 85, 88, 89, 91, 92, 93, 97, 98, 99, 102, 105, 113, 114, 118, 119, 122, 123, 124, 128, 129, 130, 131,
           132, 137, 138, 140, 141, 146, 150, 157, 159, 160, 161, 163, 167, 168, 169, 176, 178, 182, 184, 186, 190, 191, 192,
           194, 201, 202, 211, 215, 217, 219, 220, 222, 225, 230, 231, 232, 233, 237, 240, 243, 244, 249, 252, 254, 259, 260,
           262, 263, 268, 270, 300, 327, 348, 373]
CODES = {i: ['quit_elapsed'] for i in ELAPSED}
for i in [92, 95, 133, 172, 179, 250, 321]: CODES.setdefault(i, []).append('quit_best')        # the past best, kept and shown
CODES.setdefault(269, []).append('quit_best_hurts')                                            # best/average shown hurts
for i in [149, 156, 187, 246, 284, 373]: CODES.setdefault(i, []).append('quit_units')          # hours early, days/months later
for i in [121, 154, 179, 238, 261]: CODES.setdefault(i, []).append('quit_slip_neutral')        # a slip isn't back to zero
CODES.setdefault(131, []).append('quit_one_fact')                                              # "all I want to see is how many days"
CODES.setdefault(405, []).append('limit_left')                                                 # a cut-back: how many left today
for i in [90, 193, 241, 330]: CODES.setdefault(i, []).append('quit_money')
CODES.setdefault(303, []).append('one_model')                                                  # a quit day shown as 0% though it succeeded
