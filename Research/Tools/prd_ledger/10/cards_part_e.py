import json, re
R = 10
rep = open("App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md").read().split("\n")
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

# ---- PART 7 ----
c(117, "§7.1 Eligibility storefront table (verbatim)", "market",
  "31 storefronts with ≥50 reviews (69,085 reviews, 98.64%) analysed individually; 90 storefronts with 956 reviews (1.36%) generate no standalone conclusions; per-storefront n, mean, 1★ %, 5★ %",
  "n/a", "mixed", table("## 7.1 Eligibility"), "none", "verbatim", "app-specific", [])
c(118, "§7.1 Reminder before reading any theme rate below: classification is English-only", "data-caveat",
  "Where a non-English storefront shows a HIGH theme rate that is a strong finding; where it shows a low rate that is uninformative — non-English storefronts are systematically under-tagged",
  "n/a", "none", "21 non-English-primary storefronts", "none", "method", "yes", [])
c(119, "§7.1 storefront outliers: fr, ru, es, sg, pt worst 1★; pl, cz, mx, in, za, ae best; cn worst mean", "market",
  "Storefront outliers: France, Russia, Spain, Singapore and Portugal carry the highest 1★ rates among eligible storefronts; Poland and Czechia have zero 1★ and the highest means; Mexico, India, South Africa and UAE rate very high; China is the worst-rated eligible storefront",
  "n/a", "mixed", "fr 273 mean 4.513 1★ 4.76%; ru 206 4.549 6.31%; es 151 4.470 5.96%; sg 86 4.663 6.98%; pt 58 4.534 6.90%; pl 112 4.902 0.00%; cz 51 4.922 0.00%; mx 146 4.829; in 100 4.850; za 94 4.830; ae 67 4.896; cn 53 4.208 5★ 52.83%", "research", "storefront-level", "app-specific", [])
c(120, "§7.2 The high-review-volume group (defined) table (verbatim)", "market",
  "Within the four >1,000-review Anglophone storefronts (us, gb, ca, au): per-theme rates for 16 themes",
  "n/a", "mixed", "group 64,513 (92.11%) mean 4.769; rest of world 5,528 mean 4.690; " + table("## 7.2 The high-review-volume group"), "none", "verbatim", "app-specific", [])
c(121, "§7.2 Canada is the group's problem market — where the paid experience is worst and most reported; §7.3 Canada carries the highest paid exposure and the highest billing-dispute rate of any large market", "market",
  "Canada is the problem market: lowest mean and highest 1★ rate in the Anglophone group, highest rates on paywall, price, crashes, data loss, support failure and trial-reminder failure, the highest paid-evidence rate, and a billing-dispute rate nearly double the US and more than double the UK",
  "same product, worse paid outcome in CA", "churn", "ca 4,748 mean 4.689, 1★ 3.33%; paywall 1.39%, price 1.20%, crash 1.31%, data loss 0.93%, support 0.46%, trial-reminder 0.40%; paid-evidence 2.38% vs US 2.08%; billing-dispute 0.95% vs US 0.55%, UK 0.43%", "research", "stable (large n)", "app-specific", [])
c(122, "§7.2 Australia has the corpus's most neurodivergent-identified reviewer base", "audience",
  "Australia has the most neurodivergent-identified reviewer base and simultaneously the highest 'too childish' and boredom rates — a coherent segment signal: users came for ADHD support and are most likely to say the gamification is not aimed at them",
  "n/a", "mixed", "au 2,166: P-adhd-nd 11.40% vs 7.36% global; U-childish 1.06%; U-boring 1.02%; P-motivation 18.10%; P-free-generous 1.62%", "research", "stable (large n)", "yes", [])
c(123, "§7.2 The UK reports the strongest mental-health benefit — the healthiest large market", "market",
  "The UK reports the strongest mental-health benefit and the group's lowest 1★ rate — the healthiest large market",
  "n/a", "praise", "gb 6,667 mean 4.786, 1★ 2.13%; P-mental-health 15.22% vs 11.99% global", "research", "stable (large n)", "app-specific", [])
c(124, "§7.3 A defined 'high-monetisation-exposure' group (proxy, disclosed) table (verbatim)", "market",
  "High-monetisation-exposure proxy group: storefronts ≥50 reviews whose paid-evidence rate exceeds the corpus 1.97% — with billing-dispute rate and mean; only us, ca, au are stable",
  "n/a", "mixed", table("## 7.3 A defined"), "none", "verbatim", "app-specific", [])
c(125, "§7.3 Denmark, Belgium and Poland show zero paid-evidence reviews", "market",
  "The inverse group: Denmark, Belgium and Poland show zero paid-evidence reviews — markets where the free product does well and the paid product is essentially absent from the written record; Poland also has zero 1★ and the second-highest mean",
  "n/a", "praise", "dk 184, be 166, pl 112: 0 paid-evidence; pl mean 4.902, 0 one-star", "research", "limited evidence", "app-specific", [])
c(126, "§7.4 Localisation is the single largest country-specific finding table (verbatim)", "market",
  "Localisation rate by storefront — WEAK globally, HIGH-PRIORITY at country level in cn, ru, tr, br, es, mx, fr, de; VERY STRONG in at, ch, pt; these are floors",
  "English-only", "blocked-conversion", "U-localization 292 global (0.42%); " + table("## 7.4 Localisation"), "build-free", "verbatim", "yes", [])
c(127, "§7.4 Reviewers frequently state the consequence directly: they will not, or cannot, pay in English", "market",
  "Localisation blocks payment: reviewers say they will not or cannot pay in English — a Russian one-liner 'Wants see a Russian language.. that's all:)' is the fifth most-endorsed review in the entire corpus; 'I'm giving it one star because there's no Russian language version… If the language version appears, I'll delete this review and give it 5 stars'; a Brazilian cites 215 million Portuguese speakers; a Canadian argues French is an official language and the app asks personal questions in a second language; a Chilean 'no pagaré más el plus' without Spanish",
  "English-only", "blocked-conversion", "cn 26.42% (14/53); ru 18.45% (38/206); tr 18.97% (11/58); br 13.38% (19/142); es 11.92% (18/151); mx 8.90%; fr 6.96%; de 5.87% (41/698); RU review with 37 net votes", "build-free", "high-priority at country level", "yes",
  ["10089551843","13365815550","13378852631","13145741750","12685853749","12782609083","12786765767","13015580489","12591344504","12599016250","14391291831","14297425558"])
c(128, "§7.4 China is the corpus's worst-rated eligible storefront; Taiwan travel-destination complaint", "market",
  "China is the worst-rated eligible storefront and a quarter of its reviews are a language request; it also contains a political-content complaint about Taiwan being listed as a separate travel destination — a market-access category of risk",
  "English-only; Taiwan listed as travel destination", "complaint", "cn 53, mean 4.208, 5★ 52.83% vs 87.88% norm; localisation 26.42%; Taiwan complaint 2 reviews [limited evidence]", "research", "limited evidence", "app-specific",
  ["11915474270","12869927574"])
c(129, "§7.5 Accessibility as a market; the onboarding asks about disability and then ignores the answer", "audience",
  "Accessibility is a market segment: blindness/VoiceOver, physical disability and mobility, chronic illness, motion sensitivity and epilepsy, sound sensitivity, light sensitivity; the recurring structural complaint is that the onboarding asks about disability and then ignores the answer — 'I have mobility issues, so I clicked that on the app, ever since, the app has been suggesting that I do things that I've told it I can't do'",
  "asks about disability at onboarding; suggestions ignore it", "complaint", "597 accessibility reviews (0.85%) mean 4.56", "must-have", "emerging", "yes",
  ["7831288958","8427696106","10055344806","11110195517","8427543028","11467978208","12047590938","14249655239","14176678035","12682396517","13469175015","8432577759","8517938841","12097433833","13011506116","14427781194","14316419666"])
c(130, "§7.6 What does NOT vary by country — The billing-dispute mechanism, the data-loss mechanism and the feature-removal backlash are global, not regional", "insight",
  "The shape of the complaint set is stable across the four Anglophone storefronts (same order, within a factor of ~1.8): the billing-dispute mechanism, the data-loss mechanism and the feature-removal backlash are global, not regional — product problems, not market problems",
  "n/a", "none", "overwhelm, paywall, price, crashes, data loss in same order within ×1.8 in us/gb/ca/au", "product-rule", "stable", "yes", [])
c(131, "§7.7 Sub-50 storefronts [limited evidence] — Japan regional price-parity complaint; Estonia, Hong Kong", "market",
  "Sub-50 storefronts are statistically indistinguishable from the corpus; Japan holds the corpus's only regional price-parity complaint — Finch Plus at ¥11,000/yr (~$74) against $40 in the US; Estonia and Hong Kong show lower means on small samples with no conclusion drawn",
  "no regional pricing (JP pays ~$74 vs $40)", "complaint", "90 storefronts 956 reviews (1.36%) mean 4.717; jp n=45 mean 4.533; ee n=34, hk n=37 means below 4.55", "research", "limited evidence", "yes",
  ["13046812794"])

with open("Tools/prd_ledger/10/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
