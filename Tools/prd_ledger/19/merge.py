"""Stage 3 merge for report 19."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C210","product-rule","Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel","Report 19: the app was the front door to a web-billed subscription that did not appear in Apple's subscription list, carried non-refundable website terms, and could be cancelled only by email; 18 of 105 reviewers (17.14%) described the consequence, 19 were charged after cancelling, 19 were charged with no subscription they recognised, and 60 distinct reviews flowed from a customer who could not see or stop their own plan. If a web funnel must exist, the app shows the active plan, price, next charge date and a working cancel button.")
add("C211","dont","No second, separately-cancelled add-on subscription","Report 19: an e-book/PDF plan at $17–$45/month was enrolled on top of the programme subscription with its own cancellation path; 11 of 105 (10.48%) across five storefronts described it, and two reviewers on two continents reported the same asymmetry — the main plan cancels, the add-on does not. Collapse add-ons into the main plan or delete them.")
add("C212","dont","No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request","Report 19: refunds were refused for 25 of 105 (23.81%); a 'prove 14 consecutive days of use' condition (6), a 30-day money-back guarantee that was advertised and then denied (3 — all three bought because of it), and retention bots answering refund requests (5) turned refusal into fraud allegations, chargebacks and an FTC report. A guarantee you will not honour is a fraud allegation you have pre-purchased; the refund is cheaper than the dispute.")
add("C213","product-rule","If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product","Report 19: 13 of 105 (12.38%) accused the product of targeting people with ADHD because they will forget to cancel — 'preying on ADHDers they know may not remember to cancel'; friction a neurotypical user calls annoying this audience calls predatory, because the marketing itself asserts they cannot complete multi-step tasks. The ADHD positioning and a retention funnel are incompatible; six reviewers escalated to banks, card networks and the FTC.")
add("C214","product-rule","A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone","Report 19: 13 of 105 (12.38%) said the phone's alarm, Notes, calendar, paper or Excel did the same job for free ('If you can set an alarm on your phone you don't need this app'); at $45–$99 that ceiling read as theft rather than expense and produced 96 one-star reviews. A product charging above a few dollars must deliver what a checklist structurally cannot — real personalisation, coaching content, human accountability, or data the user could not assemble.")
add("C215","must-have","Support reply time must be shorter than any cancellation deadline it serves","Report 19: a 24-hour pre-renewal cancellation cut-off was served by a support queue that replied in 48 hours — 'They said cancel within 24 hours before and they take more than 48 hrs to get back to you' — an unsatisfiable deadline by construction; support otherwise ran silent, circular, or hostile ('a rude lecture via email about how I signed up on purpose') for 17 of 105.")

ext("C029", " Report 19: a 105-review corpus that was 91% one-star and 71% about money — charged after cancelling (19), charged with no recognised subscription (19), double-billed (16), charged ≠ agreed ($29.99 annual agreed, $59.99/month billed), and terms permitting weekly renewal made 'again and again every week' structurally possible.")
ext("C112", " Report 19: cancellation required email rather than a button, used bold 'stay' and small 'cancel' buttons, ~10 confirmation steps, was split across two subscriptions, and locked the user out of the account mid-flow; 24 of 105 (22.86%) described it and three asked simply for a cancel button inside the app.")
ext("C180", " Report 19: customers charged $98.50/month and $99 were offered $5 and $49 lifetime plans on cancelling; all three left 1★ and one wrote 'That is probably the real value of the service' — a save-offer at 5% of the charged price converts a pricing objection into a fraud belief.")
ext("C109", " Report 19: a 'free trial' that charged (10 of 105) — '$45 for the initial trial', 'free 7 days charged trial' — with the price hidden at decision time and no renewal warning; four non-payers refused precisely because there was no way to try first.")
ext("C148", " Report 19: five reviewers paid for a personalised plan promised by a quiz and received a blank tracker plus four thin sister apps ('some useless little apps'); a Spanish-language Instagram ad delivered an English-only app; 'not as advertised' ran at 18.10%.")
ext("C076", " Report 19: all eight 5★ reviews in a 441-day corpus landed in one nine-day December window, all US, 44–74 characters, morning-UTC, generic register, one containing a homoglyph ('recọmmend') — the report treats them as unable to bear analytical weight and states every positive figure with and without them.")
ext("C033", " Report 19: 5 of 105 paid and could not use the product — 'I can log in on my laptop but no apps'; iPhone login error 300 with no message while iPad worked; account access lost once cancellation was started.")
ext("C177", " Report 19: reviewers could find no record of what they bought — 'no confirmation email anywhere'; support's answer 'we sent you an EMAIL notification' conceded that one e-mail with the fine print in a footer link was the whole safeguard. A renewal reminder before every charge and a receipt with a working product link after it.")
ext("C005", " Report 19: departing payers named Fabulous and Triimo — the latter because 'customer service aren't trying to rob you'; trust is a feature people comparison-shop on.")
ext("C142", " Report 19: the only constructive reviewer found the product's real asset — a web course library — by accident, because the app never linked to it; the thirteen who called the product 'just a checklist' may have been describing the 10% they were shown.")
ext("C065", " Report 19: 64 of 105 reviewers were confirmed payers and 63 of them left 1★; one third said they could not get their money back and just under one third that they could not stop paying.")
ext("C058", " Report 19 (negative case): paid Instagram/YouTube ads → web quiz → web checkout → a checklist; six reviewers named the channel and the funnel, not the software, generated the corpus.")
ext("C027", " Report 19: an Instagram ad ran in Spanish for an English-only app — 'tell me if there's a Spanish version and if not, refund the money'.")
ext("C010", " Report 19: 'I did the habit so why can't I go back and track it?' — back-dating a completed habit was broken or absent.")
ext("C147", " Report 19: only four non-payers appear in the corpus and all four refused for the same reason — no way to evaluate first; everyone else went through the paywall and then tried to reverse the transaction.")

M = {
 "R19-003":["C210","C002"], "R19-004":["C210","C029"], "R19-005":["C211","C029"], "R19-006":["C029","C112","C210"], "R19-007":["C029","C210"],
 "R19-009":["C212","C029"], "R19-010":["C212"], "R19-011":["C212"], "R19-012":["C212","C036"], "R19-013":["C180","C212"], "R19-014":["C112","C213"],
 "R19-015":["C214"], "R19-016":["C148","C138"], "R19-017":["C213","C042"], "R19-018":["C058","C148"], "R19-019":["C213","C212"], "R19-020":["C142"],
 "R19-023":["C002"], "R19-025":["C010"], "R19-026":["C142"], "R19-027":["C134"], "R19-028":["C210","C113"], "R19-029":["C147","C182"], "R19-030":["C147","C063"],
 "R19-031":["C210","C190","C112"], "R19-032":["C002","C210"], "R19-034":["C002"], "R19-035":["C148","C064","C214"], "R19-036":["C109","C113","C177"],
 "R19-038":["C193"], "R19-040":["C142","C010","C112","C147"], "R19-041":["C027","C148"], "R19-042":["C075"], "R19-043":["C112"], "R19-044":["C005"],
 "R19-045":["C002"], "R19-046":["C002","C065"], "R19-047":["C142"], "R19-048":["C076"], "R19-049":["C076"],
 "R19-050":["C065"], "R19-051":["C058","C109","C212"], "R19-052":["C212"], "R19-053":["C065","C029"], "R19-054":["C147","C182"], "R19-055":["C212","C112"],
 "R19-056":["C036","C215"], "R19-057":["C215","C112"], "R19-058":["C033","C065"], "R19-059":["C177","C210"], "R19-060":["C033","C031"],
 "R19-062":["C213"], "R19-063":["C148"], "R19-064":["C148"], "R19-065":["C062"], "R19-067":["C027","C148","C147"],
 "R19-069":["C071","C029"], "R19-070":["C064"], "R19-071":["C180","C212"], "R19-072":["C211"], "R19-074":["C210"], "R19-075":["C211"], "R19-076":["C112"],
 "R19-077":["C212"], "R19-078":["C177","C152"], "R19-079":["C033","C031","C010"], "R19-080":["C215"], "R19-081":["C180"], "R19-082":["C005","C181","C112"],
 "R19-083":["C213","C042"], "R19-084":["C214","C064"], "R19-085":["C212"], "R19-086":["C148","C138"], "R19-087":["C142"], "R19-088":["C147","C210","C212","C142"],
}
# unattached (nuance register): 001-002 header/method, 008 single uncorroborated harm case, 021-022 method/composition, 024 inventory,
# 033 theme table, 037 singletons, 039 positive table, 061 storefront table, 066 volume note, 068 era table, 073 volume collapse, 089 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/19/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/19/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
