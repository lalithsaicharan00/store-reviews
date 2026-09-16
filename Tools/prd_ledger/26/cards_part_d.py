"""Cards added from the validator pass (report 26): dont and contradiction cards; Part 9 question where fix."""
import json
R = 26
P = "Tools/prd_ledger/26/cards.jsonl"
cards = [json.loads(l) for l in open(P) if l.strip()]
for k in cards:
    if k["id"] == "R26-121":
        k["where"] = "§9.3 Research questions Part 9 #1, Part 9 #2, Part 9 #3, Part 9 #4, Part 9 #5, Part 9 #6 — " + k["where"].split("— ",1)[1]
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
c(122, "Warning #1 / §9.3 #1 — dont: never reward a review with an in-app unlock", "dont",
  "Do not reward reviews with cosmetic unlocks: it produces reviewers who say in writing that they have not used the app ('I'm just doing this to get the backgrounds 😋 I haven't even used the app at all'), doubles the share of contentless ≤25-character 5★ reviews to ~35%, makes the true rating unmeasurable, and carries App Store policy exposure",
  "review-for-cosmetic reward", "5★-burst", "13 explicit (floor); ≤25-char share 16.5% → 35.0%", "dont", "weak (floor), high consequence", "yes",
  ["12272181443","12132143279","13061382481","13965948642"])
c(123, "§2.2 / Executive summary #7 — dont: never withdraw a one-time unlock people already bought when the model changes", "dont",
  "Do not withdraw a purchased one-time unlock when moving to a subscription model: seven buyers of the €6.99/$5–7 unlock said in Sept–Oct 2022 that it was taken away ('I consider that a breach of contract'), the grievance recurs for years, and it is why 'already paid, asked to pay again' is the top paid-user complaint",
  "revoked purchased unlock at repricing", "1★-burst", "7 (Sept–Oct 2022) + 3 later", "dont", "meaningful", "yes",
  ["9091405863","9171397848","9199616690","9100759613","9125973744","9126251428","9201257502"])
c(124, "Executive summary #4 / §3.2 — contradiction inside the product: gentle, streak-free positioning (25, mean 4.76) vs an all-or-nothing daily reward rule (20, mean 2.80)", "contradiction",
  "Internal contradiction: Eden is praised precisely for being gentle and streak-free ('when you break a streak you feel dispirited and give up'; 'motivation without the shame' — 25, mean 4.76) while its garden only grows on 100% daily completion, which engaged users call the opposite of self-growth (20, mean 2.80); partial credit reconciles the two",
  "gentle framing, punitive mechanic", "mixed", "25 (4.76) vs 20 (2.80)", "product-rule", "emerging", "yes",
  ["10056813574","13781551382","12599605564","12023585537"])
c(125, "§3.3 / §6.3 — contradiction with the 'freemium trackers are too expensive' reading: price-defenders outnumber price-objectors 2:1, yet the highest-ARPU markets rate lowest because of the free-tier gate", "contradiction",
  "Contradiction with the assumption that paywall complaints mean the price is too high: price-defenders outnumber price-objectors roughly 2:1 (57 vs 29) and 45 call the free tier generous, yet monetisation friction is 11.36% overall and 15.3% in high-spend markets (vs 8.7% elsewhere), where the app also rates lowest (4.489 vs 4.626) — the rich markets are willing to pay and frustrated by the trial design, not the price",
  "cap + growth ceiling before evaluation", "mixed", "57 vs 29; friction 15.3% vs 8.7%; mean 4.489 vs 4.626", "product-rule", "very strong", "yes",
  ["8823685044","10378314260","11348756546","12157437413"])
with open(P, "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards total")
