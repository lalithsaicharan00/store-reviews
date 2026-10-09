"""Hand-coded from all 103 candidates (scan.py), 9 Oct 2026. Keys are store+app#line in that app's reviews.jsonl."""
# Had a backup or a restore, and lost the part made after it (the gap between copies)
GAP = ["A10#30767", "A10#30797", "A10#36599", "A10#42119", "A20#3400", "A23#3883", "A23#4531", "A23#4691",
       "P2#3087", "P3#8779", "P98#600"]
# Believed an account (or signing in) kept their data safe, then found it wasn't there
ACCOUNT_SAFE = ["A10#17190", "A10#21825", "A10#35429", "A10#51700", "A24#37440", "A33#3715", "A4#542",
                "P12#15623", "P12#29471", "P12#35599", "P126#162320", "P22#992"]
# Say backups are not frequent enough, or expect every change saved to the cloud
FREQUENCY = ["A23#4531", "P2#22852"]
# Every other candidate was read and is off topic (subscriptions, charges, streak rules, login bugs with no data claim,
# sync between devices with no loss, or a whole-data loss with no backup involved).
