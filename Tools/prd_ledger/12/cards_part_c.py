import json, re
R = 12
rep = open("App Store Reports/12. That Girl - Routine Planner - Cute Daily Calendar Schedule (REPORT).md").read().split("\n")
def table(after, k=0):
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 5 ----
c(36, "Part 5 RATINGS ANALYSIS band table (verbatim); §5.5 1★ four causes table (verbatim)", "data-caveat",
  "Band meanings and 1★ causes: 5★ not reliable as praise; 4★ 'I like it, but one named gap'; 3★ half paywall objection, half specific bug; 2★ 'beautiful but paywalled'; 1★ paywall 53.8%, bugs 14.9%, price 13.3%, entitlement 12.4%, no trial 19.3%, refund 8.0%, rating prompt 7.2%",
  "n/a", "mixed", table("# PART 5 — RATINGS ANALYSIS") + " ;; 1★: " + table("## 5.5 1★"), "none", "verbatim", "app-specific", [])
c(37, "§5.1 The 5★ population, audited line by line table (verbatim); Only 51 of 404 reviews are 5★ ratings supported by post-use praise", "data-caveat",
  "The 5★ population audited line by line: only 51 of 404 (12.62%) are 5★ ratings supported by post-use praise; 9 praise the onboarding pre-use; 14 have text contradicting the rating ('Super faulty i can't add a to do list without it just freezing' at 5★; 'Don't download!!' at 5★); 3 content-free",
  "n/a", "mixed", table("## 5.1 The 5★ population"), "none", "audit", "app-specific",
  ["14109640681","12558262311"])
c(38, "§5.2 4★ — Every one names a specific gap; 4★ here is a specification", "insight",
  "Not a single 4★ review is unqualified praise — no Apple Watch, restore broken on iPad, to-do can't be un-checked and won't import from Apple Reminders, intro too long, delays and double entry, can't plan ahead, rated 4★ because the app demanded a review before use, price, gender framing; for a competitor 4★ is a specification: nine shippable items each named by a retained user",
  "n/a", "complaint", "4★ n=14 (3.47%)", "build-free", "band analysis", "yes",
  ["9852078271","12425415800","14151717931","12137887256","11557928395","11561379247","14029446237","8965419740","10905116935","8836955574","13702266709","14427888328","11146629279"])
c(39, "§5.3 3★ — The most useful reviews in the corpus; this is the cohort a support function would save", "insight",
  "3★ splits cleanly — 7 are paywall objections from people who never got in, the rest are detailed bug reports from people who did; this is the cohort a support function would save",
  "no support function", "complaint", "3★ n=31 (7.67%); 7 (22.6%) paywall", "must-have", "band analysis", "yes",
  ["14056969118","12111794304","11943045550","12251347318","12276664447","12247978715","12341288794","12667337121","10907660652","12619802360","13898871047"])
c(40, "§5.4 2★ — 'Beautiful, but.'; §5.5 Five 1★ reviews still contain a praise component", "insight",
  "2★ is the 'you almost had me' band — 7 of 17 aesthetic-praise reviews are 2★, nearly half are paywall complaints, and the typo complaints (all 2022–23) sit here; five 1★ reviews still contain praise — people who liked the idea enough to be angry",
  "n/a", "mixed", "2★ n=33: 16 (48.5%) paywall, 5 (15.2%) typos; 7 of 17 aesthetic at 2★; 5 of 249 1★ with praise", "none", "band analysis", "yes",
  ["12215752061","8989214254","11586279561","12611951529","13937741808"])

# ---- PART 6 ----
c(41, "§6.1 What actually triggers a purchase table (verbatim); No reviewer says they paid because of a specific feature they had seen working", "monetization",
  "Four purchase triggers and only one is product value: coercion — the gate is the only way forward ('I paid 699 so I could test it for one week because the app wouldn't let me do anything unless I did'); exit-offer discount (several felt manipulated and declined); onboarding persuasion / aesthetic ('The set up process is so intelligent and impressive, I opted for a paid subscription'); a promotional 'free lifetime' giveaway (all 5 report it was not honoured); no reviewer in 404 says they paid because of a feature seen working — the product cannot be evaluated before purchase, so no purchase is evidence-based, so no purchase is durable",
  "hard paywall; exit discount; promo code", "purchase-driver", table("## 6.1 What actually triggers"), "product-rule", "n≈17 across triggers", "yes",
  ["10875709898","12074673305","9114009603","13810250486","8939762875","11914052843","12841067761","12136171638","11514752409","12015499097","12060522005","11513929479"])
c(42, "§6.1 The intro is a genuinely effective conversion asset", "tactic",
  "The narrated, personalised onboarding is a genuinely effective conversion asset — reviewers say they subscribed because of it — even as it fails to retain",
  "long narrated onboarding before paywall", "purchase-driver", "2 explicit; 9 of 77 5★ praise onboarding pre-use", "undecided", "n=2", "yes",
  ["11914052843","12841067761"])
c(43, "§6.2 Value actually delivered to buyers — the ceiling of buyer satisfaction", "monetization",
  "The ceiling of buyer satisfaction visible in the corpus: two 4★ and seven 3★ payers report the product working well enough to keep using — 'I pay a yearly subscription and find it very helpful' followed immediately by a restore-purchases bug",
  "subscription", "mixed", "9 of 80 payers at 3–4★; 0 at 5★", "must-never-break", "segment", "yes",
  ["14151717931","12137887256"])
c(44, "§6.3 Upgrade barriers table (verbatim)", "monetization",
  "Upgrade barriers: cannot evaluate before paying (largest), price relative to perceived value, cannot afford / is a minor, reviews already warn them, missing platform (Watch, iPad) blocks purchase",
  "hard paywall; no Watch/iPad", "blocked-conversion", table("## 6.3 Upgrade barriers"), "research", "segment", "yes",
  ["8944662701","10060470838","8889252037","11446516100","14335809799","11575597852"])
c(45, "§6.3 Two reviewers state a missing platform is the reason they will not upgrade", "feature",
  "A missing platform is the stated reason not to buy — 'Im not gonna pay for it. Because there is no apple watch version'; 'Please make an iPad version so I can buy the lifetime subscription!' — a rare clean willingness-to-pay signal naming the same lever as the widget requests: presence on surfaces outside the app",
  "no Watch, no iPad", "blocked-conversion", "n=1 each (0.25%)", "build-paid", "weak by count, clean by content", "yes",
  ["9852078271","11678330257"])
c(46, "§6.3 Cannot afford / is a minor", "audience",
  "A subset of blocked users cannot afford it or are minors without a card — the 'That Girl' aesthetic pulls a young audience into a hard paywall",
  "hard paywall aimed at a young audience", "blocked-conversion", "5 (1.24%)", "research", "hand-identified", "app-specific",
  ["11446516100","14335809799","10331647142","11933820778","11819217162"])
c(47, "§6.4 Churn and refund drivers table (verbatim); locked-in churn archetype", "timeline",
  "Churn and refund drivers among payers, in order: entitlement failure 40%, bugs after paying 32.5%, refund sought 25%, support unreachable 13.75%, value disappointment 7.5%; the archetype of locked-in churn: 'i paid for the year so im stuck with it until then but honestly its pretty bad ill probably delete it'",
  "annual lock-in with no value", "churn", table("## 6.4 Churn and refund drivers"), "must-never-break", "segment (n=80)", "yes",
  ["14329102917","12431370019","13746755144","14082922244","12611951529","12841789013","12033069615","12067724293","12982453369","13898871047","12135855134"])
c(48, "§6.5 What cannot be claimed from this corpus", "data-caveat",
  "Cannot be claimed: conversion rate, revenue split by SKU, refund rate (21 mentions is a floor), or a causal claim that the rating prompt produced the 4.83 average (one documented contributor among several)",
  "n/a", "none", "n/a", "none", "method", "yes", [])

with open("Tools/prd_ledger/12/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
