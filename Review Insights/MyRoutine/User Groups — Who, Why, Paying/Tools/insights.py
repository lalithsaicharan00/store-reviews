"""MyRoutine user-group reports: every step of the method in one tool.

Written by Claude (Claude Code), 26 November 2026. Run from the repository root:

    python3 -I "Review Insights/MyRoutine/User Groups — Who, Why, Paying/Tools/insights.py" <command> <YEAR>

Commands, in the order you use them (README.md beside the reports explains each step):
    status    how far the year's labels are (must be fully labelled and checked)
    basics    the year in numbers: stores, languages, ratings, how many say who/why/liked/paid
    list      every review with a `who` or `why_chose`, line number first: read ALL of these to make groups_YEAR.py
    stats     per group: size, share, rating, paying, liked-feature kinds; then the whole year's liked features,
              paying by language, premium contents, objections, who-they-are counts (keyword lists: check by hand)
    quotes    the first who/why quote of each group member (for the report's quotes)
    limit     every review that seems to mention the free routine limit, to sort by hand
    payers    every paid / charged-unexpectedly review with its reason and liked features, to sort by hand
    problems  problem kinds (broken, missing, dislike) and every wish and dislike, to sort by hand
    appendix  the report's appendix table (append it to the report)
    check     every review ID cited in the report exists in that year's reviews.jsonl, and none is ambiguous
"""
import collections
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
APP = "MyRoutine"

# Kinds of liked feature, matched on the labels' `liked` and `chose_for` feature text (lower case). Made for MyRoutine
# from its 2020 labels (27 Nov 2026): a daily check-off routine app with a social side (other people's routines,
# copying them, following "routiners"), reflections, and web, PC and phone versions. Check new years' words and add.
# KNOWN TRAPS (2020): "look" matched "looking for" and "design" matched "layout designed"; "fun" matched the social
# "fun to peek at others"; "easy" matched "easy to copy others' routines". Each was narrowed; check again by hand.
# More in 2021: "look back/after" (a reflection), "not like a social network", "together" in "to-dos neatly together",
# "best routine app", "more effective than alarms", "stayed on the phone" (not about devices). Narrowed too.
FEATURES = {
    "See, copy and follow other people's routines": r"other (people|users|routiners|routine users)|others|copy|friend|routiner|best routine page|sharing|share|acquaintance|peek|(?<!not like a )social|together with|cheering each other",
    "Check off the day; see it at a glance": r"check(?! each day)|at a glance|weekly view|emoji|green light|green streak|overview",
    "Encouraging, motivating, sense of achievement": r"motivat|achievement|rewarding|feel(s)? good|green light|badge|well-spent|gift|vitality|keeps me going|fun of|is fun",
    "Simple, clean, easy to use": r"simple|clean|(?<!made starting )easy(?! to copy)|intuitive|neat|comfortable|convenient|usability|layout|interface|ui\b|only the necessary|easy on the eyes",
    "Looks good: design, cute": r"cute|\blooks?\b(?! (back|after))|pretty|style of app",
    "Reflection, diary, memo": r"reflection|retrospective|diary|memo|journal|feelings|emotions|sort out thoughts|recall the day",
    "Reminders and push alarms": r"remind|(?<!than )alarm|push|notification",
    "Private routines": r"private",
    "Web, PC and phone, synced": r"web|desktop|laptop|pc\b|computer|mobile app|mobile version|both web|both iphone|and ipad|tablet|syncs|sync so|comfortably on the phone",
    "Builds habits, keeps routines going": r"build(ing)? (good )?habits|keep(s|ing)? (good )?(daily )?habits|habits have taken hold|maintain|steadily|consistently|kept habits|keeping routines|routines going|morning routine",
    "Partial credit: some done still counts": r"percent",
    "Repeat on chosen weekdays": r"weekday",
    "Responsive developer, frequent updates": r"developer|update|fixes",
    "Long free trial": r"free trial",
    "Home-screen widget (from 2021)": r"widget",
    "Free plan is enough (from 2021)": r"free of charge|for free|even though it is free|free features|free up to|routines are free|무료",
}

MONEY = r"premium|pay|subscri|price|cost|free|trial|paywall|membership|lifetime|one-time|purchase|expensive|afford|\$|money|buy|plus|pro\b"
ROUTINE_LIMIT = (r"(two|2|2-3|third|3|more|unlimited|another|one more)\s+(own\s+)?(free\s+)?(routines?|schedules)"
                 r"|routines?.{0,30}(limit|without (paying|premium|subscrib)|premium|pay|subscri|free version|free mode)|2-routine")
PREMIUM = {
    "more than two routines (check by hand with `limit`)": ROUTINE_LIMIT,
    "statistics": r"stat", "backup or sync": r"back ?up|sync", "icons": r"icon", "widget": r"widget",
    "watch": r"watch",
}
OBJECTIONS = {
    "subscription, wants one-time or lifetime": r"one-time|one time|lifetime|one-off|single payment|outright|own it|pay once|buy once|permanent",
    "too expensive or can't afford": r"expensive|too high|costly|too much|ridiculous|afford|cheaper|bit high|pricey",
    "trial too short or pushed to pay": r"7 days|7-day|seven|1-week|trial",
}
# Who they say they are, matched on `who` labels. KNOWN TRAPS (fix by hand): "son" matches "person", "cat" matches
# "medication", "stud" matches "Bible study", "class" matches "classic ADHD", "parent" matches minors whose parents
# pay, "work" matches "working on finding themselves" / "works well with timers".
WHO = {
    "ADHD or ADD": r"adhd|\badd\b|tdah", "autism, OCD, executive dysfunction, brain fog": r"autis|executive|brain fog|foggy|ocd",
    "depression, anxiety, mental health": r"depress|anxi|mental|lupus|health issue",
    "student": r"student|school|exam|homework|class|stud", "works": r"\bwork(s|er|ing)?\b|job|shift|company|office|designer|developer|therapist",
    "parent": r"parent|mom|dad|kids|\bson\b|daughter|child", "smartwatch user": r"watch|galaxy fit|wear os|fitbit",
    "iPad or tablet": r"ipad|tablet|\bpad\b",
    "names their phone (iPhone, Galaxy, Android)": r"iphone|galaxy|android",
    "uses the web version or a computer": r"web|laptop|\bpc\b|computer|desktop", "habit books or methods": r"fogg|tiny habits|miracle|atomic|bullet journal|self-management books",
    "tried many apps": r"tried|tested|several|dozens|hops between|thousands",
    "procrastinator, lazy, low willpower": r"procrastinat|lazy|willpower|lethargy|three days|3 days|day 2|discipline|weak-willed|follow-through|follow through",
    "minor or child": r"minor|\d+-year-old|years old|teen|child|elementary",
    "short of money or won't subscribe": r"afford|budget|little money|money|won.t subscribe|never buys|rarely buys|rarely pays|subscri|payments|rarely spends|broke",
}


def labels(year):
    path = os.path.join(ROOT, "Review Labels", APP, str(year), "labels.jsonl")
    return [json.loads(line) for line in open(path, encoding="utf-8")]


def groups(year):
    ns = {}
    exec(open(os.path.join(HERE, f"groups_{year}.py"), encoding="utf-8").read(), ns)
    bad = [g for v in ns["MAP"].values() for g in v if g not in ns["GROUPS"]]
    assert not bad, f"unknown group codes in groups_{year}.py: {sorted(set(bad))}"
    return ns["GROUPS"], ns["MAP"]


def kinds(r):
    s = " ; ".join(x["feature"] for x in r["liked"] + r["chose_for"]).lower()
    return {k for k, p in FEATURES.items() if re.search(p, s)}


def money_text(r):
    return [r["paid"]["why"] or ""] + [p["problem"] for p in r["problems"]]


def short(r):
    return r["review_id"][:8]


def ordered(G, M):
    """Groups ordered by size, largest first; GOAL last."""
    size = collections.Counter(g for v in M.values() for g in v)
    return sorted((g for g in G if size[g]), key=lambda g: (g == "GOAL", -size[g]))


def cmd_status(y):
    d = os.path.join(ROOT, "Review Labels", APP, str(y))
    p = json.load(open(os.path.join(d, "progress.json")))
    c = sum(1 for _ in open(os.path.join(d, "checked.jsonl"))) if os.path.exists(os.path.join(d, "checked.jsonl")) else 0
    print(f"{y}: {p['reviews']} reviews, {p['labelled']} labelled, {c} checked, done={p['done']}")


def cmd_basics(y):
    L = labels(y)
    print(len(L), "reviews;", dict(collections.Counter(r["store"] for r in L)), "; average", round(sum(r["rating"] for r in L) / len(L), 2))
    print("ratings", sorted(collections.Counter(r["rating"] for r in L).items(), reverse=True))
    print("languages", collections.Counter(r["language"] for r in L).most_common(10))
    print("who", sum(bool(r["who"]) for r in L), "why", sum(bool(r["why_chose"]) for r in L),
          "either", sum(bool(r["who"] or r["why_chose"]) for r in L), "liked", sum(bool(r["liked"] or r["chose_for"]) for r in L),
          "nothing useful", sum(r["nothing_useful"] for r in L))
    print("paid", dict(collections.Counter(r["paid"]["status"] for r in L)))
    print("dates", min(r["date"] for r in L), "to", max(r["date"] for r in L))


def cmd_list(y):
    for i, r in enumerate(labels(y), 1):
        if r["who"] or r["why_chose"]:
            print(i, "|W:", "; ".join(x["label"] for x in r["who"]), "|Y:", "; ".join(x["reason"] for x in r["why_chose"]))


def cmd_stats(y):
    L = labels(y)
    G, M = groups(y)
    pain = [n for n, v in M.items() if v != ["GOAL"]]
    print(f"{len(L)} reviews; {len(M)} mapped; {len(pain)} name a pain point; {sum(len(M[n]) > 1 for n in pain)} in more than one group")
    for g in ordered(G, M):
        idx = [n for n, v in M.items() if g in v]
        st = collections.Counter(L[n - 1]["paid"]["status"] for n in idx)
        fc = collections.Counter(k for n in idx for k in kinds(L[n - 1]))
        five = sum(L[n - 1]["rating"] == 5 for n in idx)
        print(f"\n== {g} n={len(idx)} ({len(idx) / max(len(pain), 1) * 100:.0f}% of pain) avg {sum(L[n - 1]['rating'] for n in idx) / len(idx):.2f}"
              f" 5★={five} only-this={sum(M[n] == [g] for n in idx)} name-a-feature={sum(1 for n in idx if L[n - 1]['liked'] or L[n - 1]['chose_for'])}")
        print("  paid:", dict(st))
        print("  liked:", [(k[:32], c) for k, c in fc.most_common(7)])
        print("  paid/trial:", [(n, short(L[n - 1]), L[n - 1]["paid"]["status"], L[n - 1]["paid"]["why"]) for n in idx if L[n - 1]["paid"]["status"] in ("paid", "trial")])
        print("  refused:", [(n, L[n - 1]["paid"]["why"]) for n in idx if L[n - 1]["paid"]["status"] == "refused"])
    fc = collections.Counter(k for r in L for k in kinds(r))
    print(f"\nWHOLE YEAR liked (of {sum(1 for r in L if r['liked'] or r['chose_for'])} naming a feature):")
    for k, c in fc.most_common():
        print(f"  {c:4d} {k}")
    print("\nPAYING", dict(collections.Counter(r["paid"]["status"] for r in L)))
    for s in ("paid", "trial", "refused", "free", "charged_unexpectedly"):
        print(f"  {s} by language:", dict(collections.Counter(r["language"] for r in L if r["paid"]["status"] == s).most_common(5)))
    for lg, _ in collections.Counter(r["language"] for r in L).most_common(4):
        k = [r for r in L if r["language"] == lg]
        p = sum(r["paid"]["status"] == "paid" for r in k)
        print(f"  {lg}: {p} of {len(k)} say they paid ({p / len(k) * 100:.1f}%)")
    print("\nPREMIUM CONTENTS and OBJECTIONS (keyword hits with a money word; check by hand):")
    for name, pat in {**PREMIUM, **OBJECTIONS}.items():
        ids = [i for i, r in enumerate(L, 1)
               if any(re.search(pat, t, re.I) for t in money_text(r)) and re.search(MONEY, " ; ".join(money_text(r)), re.I)]
        print(f"  {name}: {len(ids)} {ids[:30]}")
    print("\nWHO THEY SAY THEY ARE (keyword hits on `who`; see the traps in this file and fix by hand):")
    for name, pat in WHO.items():
        ids = [i for i, r in enumerate(L, 1) if re.search(pat, " ; ".join(x["label"] for x in r["who"]).lower())]
        print(f"  {name}: {len(ids)} {ids}")


def cmd_quotes(y):
    L = labels(y)
    G, M = groups(y)
    for g in ordered(G, M):
        print("\n##", g)
        for n in [n for n, v in M.items() if g in v]:
            r = L[n - 1]
            q = r["why_chose"] or r["who"]
            if q:
                print(f"  {n} {short(r)} {r['language']} {r['rating']}★ “{q[0]['quote'][:140]}”")


def cmd_limit(y):
    for i, r in enumerate(labels(y), 1):
        t = money_text(r) + [x["feature"] for x in r["liked"]]
        if re.search(ROUTINE_LIMIT, " ; ".join(t), re.I) and re.search(MONEY, " ; ".join(t), re.I):
            print(i, short(r), r["paid"]["status"][:4], "|", " ; ".join(x for x in t if re.search(ROUTINE_LIMIT, x, re.I))[:130])


def cmd_payers(y):
    G, M = groups(y)
    for i, r in enumerate(labels(y), 1):
        if r["paid"]["status"] in ("paid", "charged_unexpectedly"):
            print(i, short(r), r["language"], r["paid"]["status"], "|", r["paid"]["why"], "|", [x["feature"] for x in r["liked"]][:3], "|", M.get(i, ""))


def cmd_problems(y):
    L = labels(y)
    print("problem kinds (items):", dict(collections.Counter(p["kind"] for r in L for p in r["problems"])))
    print("reviews with at least one:", {k: sum(any(p["kind"] == k for p in r["problems"]) for r in L)
                                        for k in sorted({p["kind"] for r in L for p in r["problems"]})})
    for k in ("missing", "dislike"):
        print(f"\n{k.upper()} (one line per item, to sort by hand):")
        for i, r in enumerate(L, 1):
            for p in r["problems"]:
                if p["kind"] == k:
                    print(f"  {i} {short(r)} {r['rating']}★ {p['problem']}")


def cmd_appendix(y):
    L = labels(y)
    G, M = groups(y)
    order = ordered(G, M)
    names = {g: (f"{k} " if g != "GOAL" else "") + G[g].split(":")[0].split(" (")[0].split(";")[0] for k, g in enumerate(order, 1)}
    print("\n| Line | ID | Store | ★ | Language | Groups | Paid |\n|---|---|---|---|---|---|---|")
    for n in sorted(M):
        r = L[n - 1]
        gs = "; ".join(names[g] for g in sorted(M[n], key=order.index))
        print(f"| {n} | `{short(r)}` | {'App Store' if r['store'] == 'appstore' else 'Play'} | {r['rating']} | {r['language']} | {gs} | {r['paid']['status'].replace('_', ' ')} |")
    pain = sum(v != ["GOAL"] for v in M.values())
    print(f"\n{len(M)} people: {pain} in at least one pain-point group, {len(M) - pain} with a goal only. "
          f"Checked: every ID in this report is in `Review Labels/{APP}/{y}/reviews.jsonl`.")


def cmd_check(y):
    ids = [json.loads(l)["review_id"] for l in open(os.path.join(ROOT, "Review Labels", APP, str(y), "reviews.jsonl"), encoding="utf-8")]
    found = [f for f in os.listdir(os.path.dirname(HERE)) if f.startswith(f"{APP} {y} ") and f.endswith(".md")]
    assert len(found) == 1, f"expected one report for {y}, found {found}"
    text = open(os.path.join(os.path.dirname(HERE), found[0]), encoding="utf-8").read()
    cited = set(re.findall(r"`([0-9a-f]{8}(?:-[0-9a-f-]{27})?|\d{8,10})`", text)) - {"1518956326"}  # the App Store app ID
    bad = sorted(c for c in cited if not any(i.startswith(c) for i in ids))
    amb = sorted(c for c in cited if sum(i.startswith(c) for i in ids) > 1)
    print(f"{found[0]}: {len(cited)} cited IDs; not found: {bad}; ambiguous: {amb}")
    sys.exit(1 if bad or amb else 0)


if __name__ == "__main__":
    cmds = {k[4:]: v for k, v in globals().items() if k.startswith("cmd_")}
    if len(sys.argv) != 3 or sys.argv[1] not in cmds:
        print(__doc__)
        sys.exit(2)
    cmds[sys.argv[1]](int(sys.argv[2]))
