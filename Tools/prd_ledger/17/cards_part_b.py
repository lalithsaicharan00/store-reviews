import json, re
R = 17
rep = open("App Store Reports/17. Daily Routine - Organise your time into blocks (REPORT).md").read().split("\n")
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

# ---- PART 3 ----
c(19, "§3.1 Positive themes table (verbatim); Negative themes table (verbatim); Cross-cutting table (verbatim)", "data-caveat",
  "All themes ranked: eight positive, eleven negative, seven cross-cutting",
  "n/a", "mixed", "POS: " + table("### Positive themes") + " ;; NEG: " + table("### Negative themes") + " ;; CROSS: " + table("### Cross-cutting"), "none", "verbatim", "app-specific", [])
c(20, "§3.1 P3 Design, look and feel; P5 Per-block notifications cue the next activity; N2 Bugs, crashes, black screens", "feature",
  "Design praised; per-block notifications that cue the next activity praised (both 5★); bugs, crashes and black screens across the lifespan",
  "timeline with per-block cues", "mixed", "P3 6 (15.79%) 4.17; P5 2 (5.26%) 5.00; N2 7 (18.42%) 2.14", "must-never-break", "counts", "yes",
  ["9504102829","10884354864","9086558708","9244113250","8776556254","13193213543"])
c(21, "§3.2 The corpus is bimodal; 8 of the 20 four- and five-star reviews still carry a criticism or request", "insight",
  "Only 1 review in 38 is a 3★ — users either find the product irreplaceable or cannot get into it at all; 8 of the 20 four- and five-star reviews still carry a criticism or request: engaged users specifying what to build (single-instance edit, calendar, iPad, Mac, tutorial, iCloud, Watch, auto-calculated start times)",
  "n/a", "mixed", table("## 3.2 The corpus is bimodal") + " ; 8 of 20 4–5★ (40.00%) with a request", "do", "counts", "yes",
  ["7780256223","7859394020","8013032927","8275228824","8557538403","9957602682","11035825108","13120304447"])
c(22, "§3.3 Unmet needs — every request in the corpus table (verbatim)", "feature",
  "Every request: iPad app (3), edit/delete a single instance of a repeating block (2), restore calendar integration (2), Apple Watch (2), in-app tutorial (3), Mac app, iCloud sync, cascading time adjustment in reality view, auto-calculate latest start time for a sequence, larger timeline showing time remaining, restore unspecified classic features",
  "absent", "praise", "8 (21.05%) mean 4.12; " + table("## 3.3 Unmet needs"), "research", "counts", "yes",
  ["8275228824","9957602682","13441826130","7780256223","8557538403","11035825108","8013032927","8644242601","8827339965","7859394020"])
c(23, "§3.3 Auto-calculate the latest start time for a sequence — backward scheduling from a fixed anchor, the most product-original idea in the corpus", "feature",
  "The most product-original idea in the corpus: backward scheduling from a fixed anchor — 'say I want to fall asleep by 10pm. I have a pre-sleep routine set in a sequence… I would like for the app to calculate the latest I would have to start my pre-sleep routine before it overlaps with my sleep activity' — a genuine differentiator for a timeline app, requested unprompted by a paying user",
  "absent", "praise", "n=1 (2.63%), paying 4★ user", "research", "n=1, high-value", "yes",
  ["8557538403"])
c(24, "§3.4 Competitive position — favourable and fragile at once: Sorted, Blocos, Epic", "positioning",
  "Competitive position is favourable and fragile at once: Sorted was the only rival with global schedule shifting and was rejected for task pile-up and freezing; Blocos is named as the destination if the app doesn't improve, blocked only by calendar integration; Epic's 'Brains' timeline is the analogy for what the app achieves; nearly a quarter say nothing else does this and the most recent paying user says a named competitor is one feature away",
  "unique timeline; abandoned", "mixed", "competitor named 3 (7.89%) mean 4.33; no alternative 9 (23.68%)", "product-rule", "counts", "yes",
  ["7886496270","13441826130","9504102829"])

# ---- PART 4 ----
c(25, "§4.1 5★ — three drivers: the relaunch itself, the timeline model, uniqueness; 9 of 14 five-star reviews predate 2023", "insight",
  "5★ is driven by the relaunch itself ('So glad to see this is back!'; 'Thank god, it's back! I've been using it for 10 years'; 'My sole purpose for buying an iPhone so that I could use this app'), the timeline model working, and uniqueness; two 5★ are not straightforward endorsements (a bare 'support ipad icloud'; praise for the relaunch decision — 'It's worth the money'); 9 of the 14 five-star reviews come from before 2023 — disproportionately returning classic users in the first 16 months",
  "n/a", "praise", "5★ 14 (36.84%); relaunch 9 of 14; pre-2023 9 of 14", "none", "band analysis", "app-specific",
  ["7883987615","9316304222","7775035126","7850343184","9504102829","10884354864","14333713628","7886496270","7988825337","9957602682","8417841619"])
c(26, "§4.1 4★ — every single 4★ review is 'great product, specific gap'; table (verbatim); two state the exact condition for a 5★, neither met", "insight",
  "Every 4★ review is 'great product, specific gap' — 'I need iPad and Mac versions yesterday'; 'If these two features are added it is definitely 5⭐️'; 'Once that happens… I have no doubt it'll be 5 stars'; 'still in the beta' — two state the exact condition for a 5★ and neither was met",
  "n/a", "complaint", "4★ 6 (15.79%); " + table("### 4★ — 6 reviews"), "build-free", "band analysis", "yes",
  ["7780256223","7859394020","8013032927","8275228824","8557538403","13120304447"])
c(27, "§4.1 3★ — the corpus's only middle rating and its most operationally useful review", "insight",
  "The corpus's only 3★ is its most operationally useful review: loves the product ('maps out time so beautifully'), is paying, is tired of 'the paywall with zero app updates', names the retention condition (iPad + Watch + debugging) and the churn destination (Blocos, pending calendar integration)",
  "abandoned while charging", "churn", "3★ n=1 (2.63%)", "must-never-break", "n=1", "yes",
  ["13441826130"])
c(28, "§4.1 2★ — split between complexity and disappointment against the classic; 3 of 5 are or were paying customers", "insight",
  "2★ splits between complexity and disappointment against the classic — 'For a subscription user face should not be this bad' (a paying user); deleted after 30 minutes; kept a subscription for months hoping it would reach classic quality ('Please fix legacy app… now. Then come back to this version'); trapped on the payment screen; loved it, now abandoned and crashing — 3 of 5 are or were paying customers, not tyre-kickers",
  "n/a", "churn", "2★ 5 (13.16%); 3 of 5 payers", "must-have", "band analysis", "yes",
  ["8827339965","8644242601","8776556254","10024637302","13193213543"])
c(29, "§4.1 1★ — the largest band; table (verbatim); 10 of 12 are about money and trust, not product quality — the central asymmetry", "insight",
  "10 of the 12 one-star reviews are about money and trust, not product quality — five never used the app (paywall), five used its predecessor and feel cheated; only 2 of 38 reviews are one-star ratings from someone judging this app's actual functionality: the product is not what earns the bad ratings, the commercial model and the migration are",
  "paywall + migration", "1★-burst", "1★ 12 (31.58%); paywall 5, legacy 5, technical 2 (5.26% of all); " + table("### 1★ — 12 reviews"), "product-rule", "band analysis", "yes",
  ["8863711662","9471017050","9992175230","10621025077","12167506108","7849996761","8874399635","9289248731","11033875205","14384355988","9086558708","9244113250"])
c(30, "§4.2 Themes appearing on both sides of the rating line table (verbatim); the learning-curve split is the most actionable line", "contradiction",
  "Both-sides themes: the relaunch (mean 4.46 vs 1.17), the learning curve (the same friction produces 5★ and 2★ — what separates them is whether the user got through the first day, an onboarding variable fully within the developer's control), pricing ('It's worth the money'; 'instantly subscribed… to give my full support' vs three 1★), bugs ('There are still bugs but there is no other app like this')",
  "n/a", "mixed", table("## 4.2 Themes appearing on both sides"), "must-have", "counts", "yes",
  ["7866331165","7988825337","8557538403","8644242601","8827339965","8776556254","8417841619","8013032927","7859394020"])

with open("Tools/prd_ledger/17/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
