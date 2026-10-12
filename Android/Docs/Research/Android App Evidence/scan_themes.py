"""Theme scan over both stores, English only, the same patterns: how often each theme comes up per 10,000 reviews,
split by complaints (1–2★) and praise (4–5★). Machine count of words present, not causes.

Run from Research/:  python -I Temp/android-research/scan_themes.py
Writes themes.md and theme_hits.jsonl (one row per review per theme, for sampling).
Citation: P<app#>#<line> / A<app#>#<line>, line 0-based in that app's reviews.jsonl.
"""
import json, os, re
from collections import Counter, defaultdict

R = os.getcwd()
OUT = os.path.join(R, "Temp", "android-research")
T = {
    "reminders_unreliable": r"(reminder|notification|alarm)s?\b[^.!?]{0,40}\b(don'?t|doesn'?t|didn'?t|not|never|stopped|stop|won'?t|isn'?t|aren'?t)\b[^.!?]{0,25}\b(work|come|show|appear|ring|go off|fire|pop|sound|arrive|trigger)",
    "reminders_wanted": r"\b(add|need|wish|want|would like|please)\b[^.!?]{0,40}\b(reminder|notification|alarm)s?",
    "battery_background": r"battery (optimi[sz]ation|saver|saving|usage)|background (restriction|activity|limit)|kills? the app|killed by|doze|dontkillmyapp|autostart|auto-start|xiaomi|miui|huawei|samsung.{0,20}(sleep|battery)",
    "widget_wanted": r"\b(add|need|wish|want|would like|please|no|lack)\b[^.!?]{0,30}\bwidgets?\b",
    "widget_broken": r"\bwidgets?\b[^.!?]{0,50}\b(don'?t|doesn'?t|not|never|stopped|won'?t|broken|bug|freez|update)",
    "widget_praise": r"\b(love|great|nice|awesome|perfect|best|amazing)\b[^.!?]{0,25}\bwidgets?\b|\bwidgets?\b[^.!?]{0,25}\b(are|is) (great|amazing|perfect|awesome|so good|beautiful)",
    "dark_mode_theme": r"dark (mode|theme)|material you|dynamic colou?r|amoled|black theme|night mode|themes?\b",
    "design_ui": r"\b(ui|interface|design|layout)\b[^.!?]{0,30}\b(clean|beautiful|simple|minimal|cluttered|confusing|ugly|outdated|intuitive)",
    "ads": r"\bads?\b|advert",
    "paywall_subscription": r"subscription|paywall|pay ?wall|premium|pro version|too expensive|lifetime",
    "free_open_source": r"open.?source|f-?droid|no ads|ad-?free|completely free|totally free|free forever",
    "privacy_account": r"privacy|no account|without (an )?account|sign.?up|log ?in|login|data (collection|sharing)|permissions?",
    "backup_restore": r"back ?up|restore|google drive|export|import|csv",
    "data_loss": r"lost (all )?(my )?(data|progress|habits|streak|history)|data (was |got )?(lost|gone|deleted|wiped)|everything (is |was )?(gone|deleted|lost)",
    "sync_devices": r"\bsync\w*|tablet|another device|other device|multiple devices|desktop|web (version|app)|\bpc\b|laptop",
    "watch_wear": r"wear ?os|smart ?watch|galaxy watch|pixel watch|watch app|fitbit|garmin|mi band",
    "health_fit": r"google fit|health connect|samsung health|step count|steps\b",
    "stats_charts": r"\bstat(s|istics)\b|charts?|graphs?|analytics|heat ?map|calendar view",
    "streak_rules": r"streaks?\b[^.!?]{0,40}\b(reset|broke|broken|lost|wrong|skip|vacation|rest day|freeze|sick)",
    "flexible_schedule": r"(\d|one|two|three|four|five|x) times (a|per) (week|month)|specific days|every (other|\d+|x) days?|weekly goal|monthly goal|flexible",
    "measurable_count": r"\b(count|counter|quantity|amount|numeric|measurable|number of|how many|glasses|pages|minutes)\b",
    "timer": r"\btimer|stopwatch|pomodoro|countdown",
    "quit_bad_habit": r"bad habits?|quit(ting)?\b|break (a |the )?habit|addiction|smok|relapse|sober|days since",
    "notes_journal": r"\bnotes?\b|journal|diary|reflection|comment",
    "todo_tasks": r"to-?do|tasks?\b|checklist|subtasks?",
    "crash_bug": r"crash|freez|bug|glitch|not working|doesn'?t work|stopped working|won'?t open",
    "language": r"translat|language|in (spanish|german|french|portuguese|hindi|arabic|russian)",
    "gamification": r"gamif|\brpg\b|\bxp\b|level up|pet\b|avatar|rewards?\b|badges?|achievements?",
    "back_navigation": r"back button|back gesture|swipe back|navigation bar|edge.to.edge|status bar",
    "home_screen_shortcut": r"shortcut|quick tile|quick settings|launcher|app icon",
}
T = {k: re.compile(v, re.I) for k, v in T.items()}

def text_of(store, r):
    return (r.get("text") or "") if store == "P" else ((r.get("title") or "") + " — " + (r.get("body") or ""))

tot = Counter(); cnt = defaultdict(Counter)
with open(os.path.join(OUT, "theme_hits.jsonl"), "w", encoding="utf-8") as out:
    for store, folder in (("P", "Play Store Reviews"), ("A", "App Store Reviews")):
        for d in os.listdir(os.path.join(R, folder)):
            p = os.path.join(R, folder, d, "reviews.jsonl")
            if not os.path.exists(p):
                continue
            num = d.split(".")[0]
            for i, l in enumerate(open(p, encoding="utf-8")):
                r = json.loads(l)
                t = text_of(store, r)
                if store == "P" and r.get("language") != "en":
                    continue
                if store == "A" and not re.search(r"\b(the|and|for|with|app)\b", t, re.I):
                    continue
                rating = r.get("rating") or 0
                band = "neg" if rating <= 2 else ("pos" if rating >= 4 else "mid")
                tot[(store, "all")] += 1; tot[(store, band)] += 1
                for k, rx in T.items():
                    if rx.search(t):
                        cnt[(store, band)][k] += 1; cnt[(store, "all")][k] += 1
                        out.write(json.dumps({"theme": k, "cite": f"{store}{num}#{i}", "id": r["review_id"],
                                              "app": d, "rating": rating, "date": (r.get("date") or "")[:10],
                                              "text": t.replace("\n", " ")[:900]}, ensure_ascii=False) + "\n")

def per10k(store, band, k):
    return 10000 * cnt[(store, band)][k] / max(tot[(store, band)], 1)

lines = ["# Themes per 10,000 English reviews, both stores, same patterns (machine count)", "",
         f"Play: {tot[('P','all')]:,} reviews ({tot[('P','neg')]:,} at 1–2★, {tot[('P','pos')]:,} at 4–5★). "
         f"App Store: {tot[('A','all')]:,} ({tot[('A','neg')]:,} / {tot[('A','pos')]:,}).", "",
         "| Theme | Play all | App all | Play ÷ App | Play 1–2★ | App 1–2★ | Play 4–5★ | App 4–5★ |", "|---|---|---|---|---|---|---|---|"]
rows = []
for k in T:
    pa, aa = per10k("P", "all", k), per10k("A", "all", k)
    rows.append((pa / max(aa, 0.01), k, pa, aa))
for ratio, k, pa, aa in sorted(rows, reverse=True):
    lines.append(f"| {k} | {pa:.0f} | {aa:.0f} | {ratio:.2f} | {per10k('P','neg',k):.0f} | {per10k('A','neg',k):.0f} | {per10k('P','pos',k):.0f} | {per10k('A','pos',k):.0f} |")
open(os.path.join(OUT, "themes.md"), "w", encoding="utf-8").write("\n".join(lines) + "\n")
print("\n".join(lines))
