"""Cards added from the validator pass (report 24): tactic cards, §11.x where prefixes."""
import json
R = 24
P = "Tools/prd_ledger/24/cards.jsonl"
cards = [json.loads(l) for l in open(P) if l.strip()]
sec = {**{f"R24-{n:03d}": "§11.1" for n in range(171,177)}, **{f"R24-{n:03d}": "§11.2" for n in range(177,181)},
       **{f"R24-{n:03d}": "§11.3" for n in range(181,188)}, **{f"R24-{n:03d}": "§11.4" for n in range(188,191)}}
for k in cards:
    if k["id"] in sec and not k["where"].startswith("§11"): k["where"] = sec[k["id"]] + " " + k["where"]
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
c(193, "§7.2 #4 / §11.4 #19 — tactic: escalating save-offers in the cancellation flow ($19.99 → $12.99 → $5 → $2/month → 30 days free)", "tactic",
  "Tactic and outcome: the cancellation flow offers progressively lower prices; it converts some users, but reviewers publish it as a trick they use deliberately, and it establishes that the list price is not the real price — corrosive to the 791 who already object to price and to the 'publish one price' rule",
  "cancel-flow discount ladder", "mixed", "5 named reviews; price objection 791 (1.82%, mean 2.248)", "dont", "meaningful", "yes",
  ["14078552085","11068061944","11770837150","13135059492","14162136721"])
c(194, "§1.5 / §5.1 — tactic: in-app review prompt on day 1–3", "tactic",
  "Tactic and outcome: the app prompts for a review in the first days of use — dozens of 5★ reviews say so ('they asked me to review it now which I find kind of ridiculous'); it inflates first-impression praise, and the highest-voted reviews are all pre-2024 5★s; billing disputes arrive at renewal, so the 5★ band measures onboarding, not tenure",
  "early review prompt", "5★-burst", "5★ band 25,163 (57.89%), median 105 chars; 4 named reviews", "dont", "disclosed bias", "yes",
  ["13061180549","13802373157","14003379751","12134714782"])
c(195, "§2.2 b / §6.2 (2) — tactic: 'pay what you can' non-refundable set-up fee on the trial", "tactic",
  "Tactic and outcome: a donation-style 'pay what you can' screen ($1 / $10 / ~$16) charges a non-refundable set-up fee on the 'free' trial; outcome is 506 'trial was not free' reviews at mean 1.136 and templated refund refusals quoting the fee clause",
  "paid trial framed as donation", "1★-burst", "506 (1.16%), mean 1.136; 100 name the fee, mean 1.110", "dont", "meaningful", "yes",
  ["8078038999","11270936086","13252486000","13614621943","14057143520"])
with open(P, "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards total")
