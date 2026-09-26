"""Cards for report 23 — Part 8 (country and market)."""
import json, re
R = 23
rep = open("App Store Reports/23. Streaks - The habit-forming to-do list (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").replace("`","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(173, "§8.1 Eligibility — 21 storefronts ≥50 reviews = 92.01%; 72 sub-50 storefronts 581 reviews (7.99%) labelled limited evidence", "data-caveat",
  "21 storefronts clear the 50-review threshold (6,689, 92.01%); the other 72 (581, 7.99%) are in global numbers but standalone claims are labelled limited evidence", "n/a", "none", "21 / 6,689 (92.01%); 72 / 581 (7.99%)", "none", "method", "yes", [])
c(174, "§8.2 All 21 eligible storefronts table (verbatim)", "market",
  "Per-storefront n, mean, 5★%, 1★% and theme rates (cap-ask, UX, sync, watch, widget, price, refund, data-loss, notif, simple, one-time) for 21 storefronts plus global; rating distributions are language-neutral and should carry the weight",
  "n/a", "mixed", table("## 8.2 All 21 eligible storefronts"), "none", "corpus-level fact", "app-specific", [])
c(175, "§8.3 Germany — the worst-performing large market: n=319, mean 3.62, 16.6% 1★", "market",
  "Germany is the corpus's worst-performing large market, on three readable drivers: price-to-value objection from launch (€3.99 in 2015 — '99Ct wären OK'; rate 3.8% vs 1.3% US), bad German localisation ('Die Übersetzung ins Deutsche ist total fehlgeschlagen'; de and de-adjacent storefronts supply half of all 16 localisation complaints), and the highest sync-complaint (10.0%, 32 of 319) and data-loss (2.8%) rates of any large storefront — a market where a specific quality signal, the translation, undercut the premium price and the reliability regression landed hardest",
  "poor German translation; sync regression hit hardest", "complaint", "n=319, mean 3.62 (global 4.19), 16.6% 1★ (global 8.94%), 43.6% 5★ (63.1%); price 3.8%; sync 10.0%; data loss 2.8%", "do", "meaningful", "yes",
  ["1221572381","1239810635","1272590102","1273715314","1274167690","1274902707","1275317903","1276435627","1296694168","1342979911","1343618828","1272924985","3626095782","1670054290","8119544330","8119556510","8479907454","8607950930","8651289566","8906562435","10702725657","10817334727","11215332179","11495964400"])
c(176, "§8.4 Korea — the refund market: 6.5% refund mentions, 7× global; accidental purchases; highest Watch mention rate 13.5%", "market",
  "Korea is the refund market: refund mentions at 6.5% (14 reviews, mean 2.29) are 7× the global 0.9%, several explicitly accidental ('my sibling bought it by mistake'); Korea also has the highest Apple Watch mention rate in the corpus (13.5%) and Watch failure is the most common substantive complaint",
  "one-tap purchase; Watch-heavy market", "complaint", "n=215, mean 3.98, 14.0% 1★; refund 14 (6.5%), mean 2.29; Watch 13.5%", "research", "meaningful", "yes",
  ["1228688696","1231568108","1232238147","1236584204","1238317691","1394260689","2310465385","5759175647","6709863020","6723289341","6731172815","8004581061","11607282717","14374110006","5087160831","5518344768","6194996941","6518706183","6705225971","7421311142","7507001345","8367240361","8451072345","8491758578","8632520605","8707802136","10510343633","11750944106","13235319229"])
c(177, "§8.4 Korean IME composition bug — task-title field mangles Hangul (약 → 야ㄱ); reported four times over five years, never fixed", "must-never-break",
  "A genuine, fixable localisation defect specific to Korean: the task-title field mangles Hangul (typing 약 stores 야ㄱ; 랑 stores 라ㅇ) — an IME composition bug reported four separate times over five years, apparently never fixed, producing 1★–4★ reviews from otherwise-satisfied users",
  "Hangul IME composition broken in text field", "complaint", "4 reports 2020-02 → 2020-10 (and later)", "must-never-break", "limited evidence (n=4)", "yes",
  ["5541895076","5747933646","5998909121","6586522274"])
c(178, "§8.5 China — high satisfaction, different objection: capacity barely an issue (2.0%), Chinese reviewers endorse the constraint ('克制的设计')", "market",
  "China has above-global satisfaction (mean 4.27, 67.1% 5★) but 10.6% 1★; capacity is barely an issue (2.0% vs 7.6% global) and Chinese reviewers are the most likely to endorse the constraint ('克制的设计' — restrained design)",
  "n/a", "praise", "n=404, mean 4.27, 67.1% 5★, 10.6% 1★; cap-ask 2.0%", "none", "meaningful", "app-specific",
  ["1313100486","1323530662","1518162248","6716888329"])
c(179, "§8.5 China — price is the objection: '¥25/30 for a reminder'", "market",
  "In China price is the objection — ¥25–30 recurs as the number, and the 1★ Chinese reviews are almost uniformly '¥25/30 for a reminder'", "¥25–30 one-time", "complaint", "price objection cn 2.5%; 10 representative reviews", "research", "meaningful", "yes",
  ["1313100486","1555665144","1617189453","1627725138","1649879883","1710160223","1770999373","1826051424","1882392612","3337964650"])
c(180, "§8.5 China — distinctive, consistent feature asks: count-up timers and record beyond goal, notes/annotations, longer cycles", "feature",
  "Chinese feature asks are distinctive and consistent: count-up timers and recording beyond the goal (including the corpus's most-upvoted review), notes/annotations, and longer cycles", "absent", "complaint", "6 + 3 + 3 representative reviews", "undecided", "meaningful", "yes",
  ["9145507788","8642992805","8019547720","10249897584","12776433938","10956685084","3524837176","1702798894","6099167705","2056232018","9405395737","11315859157"])
c(181, "§8.5 China — machine-translated Chinese help text ('直接机翻？'), 52 net upvotes, still cited in 2024", "market",
  "Machine-translated Chinese help text was flagged with 52 net upvotes in 2017 and is still cited in 2024", "machine-translated help text", "complaint", "52 net upvotes; cited 2017 and 2024", "do", "community-endorsed", "yes", ["1933748530","11977883967"])
c(182, "§8.6 Japan — the Watch market and the most reflective reviews: explicit endorsements of the design philosophy ('人の心理がよく分かってる'), most structured feature requests", "market",
  "Japanese reviewers write the corpus's most explicit endorsements of the design philosophy ('they understand human psychology well') and the most structured feature requests (a bilingual five-point specification for over-achievement); Watch mention 13.3% (highest with Korea); failure modes are Watch↔iPhone sync and data loss",
  "n/a", "mixed", "n=210, mean 4.06; Watch 13.3%", "none", "meaningful", "app-specific",
  ["1282229433","1375644270","1376474685","1450613496","1450678791","1451144582","9592238918","3355577958","4640524404","7957667076","8794032644","8994058429","10661343816","10670030117","10912008189","12143544557","12293062476","1861463137","1873446324","11200491931","11286414449","12257280896"])
c(183, "§8.7 Group A high-review-volume markets (us, gb, cn, ca, de, au, ru, kr) — n=5,445 (74.9%), mean 4.22", "market",
  "Group A (eight highest-volume storefronts): n=5,445 (74.9%), mean 4.22, 5★ 64.0%, 1★ 8.6%; cap-ask 5.23%, price 1.69%, sync 4.39%, refund 1.05%", "n/a", "mixed", "n=5,445 (74.9%), mean 4.22, 5★ 64.0%, 1★ 8.6%", "none", "corpus-level fact", "app-specific", [])
c(184, "§8.8 Group B high-spend markets (us, cn, jp, gb, de, fr, ca, au, kr) — external-knowledge definition; n=5,500 (75.7%), mean 4.22; rest of world 4.12", "market",
  "Group B (high-spend, an external-knowledge definition — no spend or download figure exists in the data): n=5,500 (75.7%), mean 4.22, 5★ 63.8%, 1★ 8.6%, cap-ask 5.07%, price 1.64%, sync 4.25%, refund 1.00%; everything else (72 storefronts, n=1,518, 20.9%): mean 4.12, 5★ 60.6%, 1★ 10.1%, cap-ask 2.96%, price 0.79%, sync 4.81%, refund 0.66%",
  "n/a", "mixed", "Group B 4.22 vs rest 4.12", "none", "corpus-level fact (definition disclosed)", "app-specific", [])
c(185, "§8.8 Finding — the two groups are statistically indistinguishable and only marginally better than the rest of the world; what varies by country is which complaint dominates, not how much", "insight",
  "There is no high-spend/low-spend product split in this corpus: the two defined groups are indistinguishable from each other (4.22) and only marginally better than the rest of the world (4.12) — what varies by country is which complaint dominates, not how much people complain",
  "n/a", "none", "4.22 vs 4.22 vs 4.12", "none", "corpus-level fact", "yes", [])
c(186, "§8.9 What genuinely varies by country (verbatim table)", "market",
  "By-country patterns: price-to-value objection au 5.4% / de 3.8% / ca 3.6% / cn 2.5% vs us 1.3%; refunds/accidental purchase kr 6.5% / cn 1.2% vs 0.9%; Watch centrality kr 13.5% / jp 13.3% vs 8.1%; sync failure de 10.0% / es 10.1% / se 9.7% vs 4.8%; capacity request us 9.8% / gb 10.2% / ca 10.7% / in 9.4% / pl 9.3% / kr 8.4% vs cn 2.0% / es 0.0% / fr 2.1%; localisation-quality complaints de, ru, se, kr, cn, tw, jp (plus es: mixed EN/ES notifications, untranslated elements, English-only icon search); notifications not firing th 18.2% (limited evidence)",
  "n/a", "mixed", table("## 8.9 What genuinely varies by country"), "do", "corpus-level fact", "yes",
  ["1381246799","1381337082","1899009447","4323411409","5215358938","1933748530","11977883967","7847112518","12020722847"])
c(187, "§8.9 Localisation quality complaints — untranslated elements, mixed-language notifications, English-only icon search (es); machine/poor translation in de, ru, se, kr, cn, tw, jp", "market",
  "Localisation-quality complaints span seven storefronts: poor or machine translation (de, ru, se, kr, cn, tw, jp) and in Spanish mixed EN/ES notifications, untranslated elements and an English-only icon search",
  "partial, low-quality localisation", "complaint", "16 (0.22%, weak) global; de supplies half", "do", "weak", "yes",
  ["1381246799","1381337082","1899009447","4323411409","5215358938","7847112518","12020722847"])
c(188, "§8.10 Sub-50 storefronts — Thailand (n=22) notification failure 18.2% [limited evidence]", "market",
  "Thailand (n=22) names notification failure in 4 reviews (18.2%) — the highest rate anywhere; limited evidence", "reminders not firing in Thailand", "complaint", "4 of 22 (18.2%), limited evidence", "must-never-break", "limited evidence", "yes",
  ["3630312469","5608136878","6036356305","6825459841","7151647360","2942900673","3917861651"])
c(189, "§8.10 Denmark (n=30) — the single most thoughtful negative review argues habit apps cannot substitute for a visible physical cue", "insight",
  "The corpus's single most thoughtful negative review (dk, 2★, previously 5★) argues from behavioural psychology that habit apps cannot substitute for a visible physical cue and recommends pen and paper", "n/a", "churn", "1 review", "research", "single review", "yes", ["8489597297"])
c(190, "§8.10 Denmark — macOS bug: Streaks creating millions of files in /private/var/folders, locking the reviewer out of their Mac (unverified, n=1, safety-class severity)", "must-never-break",
  "A macOS-specific bug report says Streaks created millions of files in /private/var/folders and locked the reviewer out of their Mac — the most severe single technical claim in the corpus; unverified, n=1, recorded because a desktop app rendering a machine unusable clears the safety exception to the ignore threshold",
  "Mac app runaway file creation", "complaint", "1 review (dk)", "must-never-break", "single review, unverified, safety-class", "yes", ["8567779004"])

with open("Tools/prd_ledger/23/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
