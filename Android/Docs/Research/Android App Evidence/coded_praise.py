"""Hand coding of read/praise_top_apps.txt (5-star, English, 120+ chars, 2023+, 12 per app, seed 20261012).
Praise codes: SIMPLE (simple, minimal, easy) · NOADS · FREE · NO_SUB (one-time price / no subscription, premium worth it)
· FLEX (flexible types, schedules, reminders per day) · STATS (statistics, visual record, charts) · WIDGET · REMIND
(reminders/daily messages) · FAST (opens instantly, quick to tick) · PRIVATE (no data sharing) · BACKUP (backup, sync,
data survived) · MOTIVATE (motivation, streaks, quotes, content) · ADHD (says it helps with ADHD) · OFFLINE · GENERIC
(praise with no reason). Requests: REQ_<what>."""
CODED = {
 "P3#3284": "SIMPLE FREE", "P3#1978": "GENERIC REQ_STACKING", "P3#3949": "SIMPLE FLEX FREE REQ_CUMULATIVE",
 "P3#2720": "SIMPLE NOADS FAST", "P3#4281": "SIMPLE FREE REQ_DONATE", "P3#4046": "STATS ADHD",
 "P3#4161": "REMIND REQ_MULTI_REMINDER", "P3#3080": "SIMPLE STATS", "P3#2128": "SIMPLE NOADS PRIVATE",
 "P3#3114": "SIMPLE STATS FREE", "P3#2532": "SIMPLE NOADS REQ_DELETE_ENTRY", "P3#2796": "SIMPLE STATS",
 "P2#5209": "NO_SUB REQ_SYNC", "P2#5811": "NO_SUB FLEX REMIND ADHD", "P2#5533": "NO_SUB",
 "P2#3436": "SIMPLE FLEX STATS NO_SUB REQ_SCHEDULE_KEEPS_PAST", "P2#3825": "NO_SUB STATS REQ_LOG_TIME",
 "P2#6906": "FLEX REMIND", "P2#2154": "GENERIC", "P2#2119": "NO_SUB BACKUP", "P2#5841": "NO_SUB SIMPLE",
 "P2#4233": "GENERIC", "P2#5712": "WIDGET REQ_WHATS_NEW", "P2#6088": "SIMPLE FLEX",
 "P24#1449": "MOTIVATE", "P24#1208": "STATS", "P24#1670": "SIMPLE", "P24#1713": "SIMPLE BACKUP FREE REQ_GOOGLE_LOGIN",
 "P24#1563": "FLEX", "P24#1683": "FLEX", "P24#1561": "WIDGET", "P24#1624": "STATS MOTIVATE",
 "P24#1605": "SIMPLE FREE FAST REQ_THEME", "P24#1532": "GENERIC", "P24#1244": "STATS", "P24#1345": "SIMPLE NOADS",
 "P10#9810": "SIMPLE", "P10#9952": "GENERIC", "P10#7900": "SIMPLE FREE REQ_WIDGET",
 "P10#8503": "SIMPLE FLEX MOTIVATE", "P10#7468": "SIMPLE FAST", "P10#5022": "FREE", "P10#7234": "FREE",
 "P10#5741": "FREE STATS REQ_NOTE_ON_DAY", "P10#8686": "GENERIC", "P10#5217": "REQ_TIMER REQ_COMBINED_TYPES",
 "P10#7929": "SIMPLE MOTIVATE", "P10#9607": "BACKUP FREE",
 "P65#2265": "FREE", "P65#2765": "NOADS", "P65#2552": "REQ_RESTORE_HELP", "P65#1993": "SIMPLE NOADS REQ_STATS",
 "P65#2266": "STATS", "P65#3419": "SIMPLE", "P65#2630": "REQ_PARTIAL_DAY", "P65#2221": "BACKUP",
 "P65#2834": "SIMPLE NOADS REQ_N_PER_WEEK", "P65#2038": "SIMPLE", "P65#3134": "SIMPLE MOTIVATE REQ_OVERACHIEVE",
 "P65#2194": "SIMPLE WIDGET FLEX",
 "P125#4493": "MOTIVATE", "P125#5272": "MOTIVATE REQ_RESTORE_HELP", "P125#4381": "MOTIVATE",
 "P125#6076": "REMIND", "P125#4460": "MOTIVATE", "P125#4490": "SIMPLE MOTIVATE", "P125#3877": "REMIND MOTIVATE",
 "P125#4425": "REMIND OFFLINE MOTIVATE", "P125#3403": "MOTIVATE", "P125#4360": "GENERIC",
 "P125#3091": "REMIND MOTIVATE", "P125#4081": "REMIND MOTIVATE",
}
if __name__ == "__main__":
    import re, collections
    ids = re.findall(r"^\[(P\d+#\d+)\]", open("read/praise_top_apps.txt", encoding="utf-8").read(), re.M)
    assert sorted(ids) == sorted(CODED), set(ids) ^ set(CODED)
    c = collections.Counter(x for v in CODED.values() for x in v.split())
    lines = [f"# Praise sample, top 6 Play habit trackers: {len(CODED)} reviews\n", "| Code | n | Apps | Example IDs |", "|---|---|---|---|"]
    for k, n in c.most_common():
        ex = [i for i, v in CODED.items() if k in v.split()]
        lines.append(f"| {k} | {n} | {len({e.split('#')[0] for e in ex})} | {', '.join(ex[:4])} |")
    open("praise_tally.md", "w", encoding="utf-8").write("\n".join(lines) + "\n"); print("\n".join(lines))
