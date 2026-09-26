"""Stage 3 merge for report 58."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text

ext("C001", " Report 58: a fully free, uncapped launch app whose largest theme family is praise for not charging (52 of 91, 57.14%) — the report's reading is that a future habit cap is 'the single worst monetization lever available' because 15 reviewers name a cap or paywall as what they fled.")
ext("C002", " Report 58: 97.80% five-star with zero 1★/2★ in 87 days — explained by removing the paywall grievance, an app too young to hit renewal, data loss or a year boundary, and founder-audience selection; 'Do not treat 4.956 as a quality measurement'.")
ext("C005", " Report 58: 35 of 91 (38.46%, all 5★) rank it against rivals they tried ('I have spent the last 3 years trying out all the different habit tracking apps'); the only rival named is Finch ('really great when I was younger, but now it was just overwhelming'); comparative language fell 37.8% → 15.2% between halves as early category shoppers gave way to later arrivals — composition, not erosion.")
ext("C006", " Report 58: UX praise 58 of 91 (63.74%) defined by restraint — 'not overcrowded and overwhelming'; 'no visual noise'; 'doesn't have all the complicated tracking mechanics other apps have'; simplicity and aesthetics are separable, so cosmetic depth can ship without structural complexity; categories only as an opt-in invisible until used.")
ext("C007", " Report 58: unlimited free habits against rivals' caps — 'Finally a habit tracker app where you can add more than 5 habits for free!' (HR); 'all the other apps like tell me I have to pay to put more things on the checklist' (SA); 'when we normalised that a habit tracker app, doesn't allow us to track habits?' (UY); 14 praise the absence of a cap.")
ext("C009", " Report 58: icons / emojis and colours / themes are the only repeat request (3 + 2) and what a 3★ asks for ('I feel like the app is depressed I hope you add colors') — ship the baseline expansion free first, and only then consider paid packs, because selling what a 3★ calls missing reads as a paywall on a deficiency.")
ext("C012", " Report 58: daily / weekly / monthly / yearly progress views with unrestricted history are an adoption reason for 5 ('you can see all of your history not just a month back').")
ext("C013", " Report 58: cross-device use requested by 2 (a 3★ whose whole review is 'so I can work in two different places') against 2 who chose the app because it has no account — if sync ships it must be optional and never a precondition for first use; accounts and servers bring the 1★ failure classes the corpus is free of.")
ext("C023", " Report 58: 'THE WIDGET that is clickable?? the best ever'; 'The widget option is legit a life saver!'.")
ext("C024", " Report 58: streaks praised by 5 ('It's so fun every time I get a streak').")
ext("C032", " Report 58: the history view shows only 2026 and a reviewer worries 'I hope all of my 2026 is not removed' — the corpus ends 118 days before the app's first year boundary while 5 reviewers adopted it for unrestricted history; fix 1: verify and publicise year-rollover behaviour before 1 Jan 2027.")
ext("C035", " Report 58: no account and no e-mail sign-up named as adoption reasons by 2 ('It makes it quick and easy to start using').")
ext("C040", " Report 58: widget habit icons render as white boxes in iOS clear / tinted icon mode — the only functional defect in 91 reviews, with a stated repro.")
ext("C042", " Report 58: 8 of 91 self-identify as ADHD or neurodivergent, unprompted, across 6 storefronts, all 5★, 5 tying it to simplicity ('ADHD HEAVEN… Not overwhelming or complicated… my brain is happy'; 'Setting up is simple. No extras') while the listing does not target ADHD — 'produced by users, not by marketing'; one wants more celebration for dopamine.")
ext("C043", " Report 58: times per day, per weekday ('only make habits show up on specific days for my gym sessions'), biweekly and monthly — 4 reviewers, 4 storefronts, one gap in a weekly-goal model.")
ext("C045", " Report 58: user-defined sections requested once — test as an opt-in invisible until the first section is created.")
ext("C049", " Report 58: themed mood, gratitude and day-rating logging proposed in a 1,030-character review.")
ext("C052", " Report 58: points redeemable for self-chosen real-world rewards requested once.")
ext("C058", " Report 58: founder TikTok is the only named channel — 8 of 91 ('I saw the creator talking about her app on TikTok'; 'thanks to that tik tok girl'), no reviewer names search, friends or ads; single-channel, founder-dependent acquisition that also inflates the mean via audience selection; attribution fell 13.3% → 4.3% between halves.")
ext("C061", " Report 58: willingness to pay is patronage-shaped, not access-shaped — 'I wish and hope and pray it will continue to be free and to those who can, please support the developers! <3' (PH); 'The framing that works is support the creator, not unlock the feature'.")
ext("C094", " Report 58: no review prompt and a 3.30% contentless-praise rate — if a prompt is ever added, gate it behind a real usage milestone so the corpus keeps its value as a discovery instrument.")
ext("C097", " Report 58: a voluntary in-app tip is the only payment surface, received warmly ('there are no ads! But you can leave a tip, which is very nice ✨'), zero objections — unlikely to scale alone.")
ext("C101", " Report 58: an ADHD reviewer asks for 'more of celebration for those who like dopamine hits' while 7 of 8 neurodivergent reviewers praise restraint — make it off-by-default and measure.")
ext("C134", " Report 58: acquisition is founder-dependent and the listing does not claim the ADHD audience that found it; test copy leading with simplicity (the US already leads with simplicity, 50.0% vs 33.8%).")
ext("C178", " Report 58: 'no visual noise'; 'straight to the point of habit tracking'.")
ext("C202", " Report 58: following friends requested once alongside cross-device use.")
ext("C209", " Report 58: §8.5 do not require an account to start.")
ext("C216", " Report 58: 'an effective habit tracker that did not discourage me when I missed a day'.")
ext("C246", " Report 58: 8 of 91 praise no ads, and 'no ads' plus 'no bad free version' is the pitch against competitors.")
ext("C062", " Report 58: all four 'please stay free' pleas and 3 of 4 budget self-identifications are outside high-spend storefronts (PH 3) while free praise is flat — test any monetisation in high-spend storefronts first because they have not publicly asked for the model to be preserved.")
ext("C025", " Report 58: budget-constrained adopters ('as a broke student'; 'Good for broke but productive people'; 'I'm a young lady trying to save up') will not convert to a subscription.")

M = {
 "R58-003":["C002"], "R58-005":["C058"], "R58-007":["C001","C246","C007","C002"], "R58-008":["C007","C001"], "R58-009":["C005"], "R58-010":["C097","C061"],
 "R58-011":["C061","C001","C025"], "R58-012":["C006","C178"], "R58-013":["C042","C101"], "R58-014":["C032","C012","C034"], "R58-016":["C032","C061","C009","C043","C040","C013","C058","C042"],
 "R58-017":["C012","C023","C024","C216","C097"], "R58-018":["C001","C097"], "R58-022":["C009","C012","C024","C023"], "R58-023":["C035","C209"],
 "R58-025":["C043","C009","C013","C045","C052","C101","C049","C202"], "R58-026":["C040"], "R58-027":["C043"], "R58-028":["C009"], "R58-029":["C002"],
 "R58-031":["C001","C013","C035"], "R58-033":["C025","C061","C062"], "R58-034":["C001","C007","C009","C097","C246"], "R58-036":["C134"], "R58-037":["C062","C025"],
 "R58-039":["C038","C027"], "R58-040":["C062"], "R58-041":["C058"], "R58-044":["C001"], "R58-045":["C005"], "R58-049":["C001","C007","C061","C009"],
 "R58-050":["C013","C035"], "R58-051":["C042","C134"], "R58-052":["C058"], "R58-053":["C101","C052"], "R58-054":["C045","C006"], "R58-055":["C134"], "R58-056":["C094"],
 "R58-058":["C007","C246","C209","C006"], "R58-059":["C002"], "R58-060":["C007","C001"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/58/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/58/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached")
print("unbacked:", [x["id"] for x in C.values() if "Report 58" in x["statement"] and not any(k.startswith("R58-") for k in x["cards"])])
