"""Cards for report 24 — Part 8 (country and market)."""
import json, re
R = 24
rep = open("App Store Reports/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help (REPORT).md").read().split("\n")
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

c(146, "§8.1 Eligibility; §8.2 All 52 eligible storefronts table (verbatim) — 52 storefronts ≥50 = 42,213 (97.11%); 94 sub-50 = 1,256 (2.89%)", "market",
  "Per-storefront n, mean, 5★%, 1★% and bill_core% for the 52 storefronts with ≥50 reviews (42,213, 97.11% of the corpus); the remaining 94 hold 1,256 (2.89%) and are reported only in aggregate",
  "n/a", "mixed", table("## 8.2 All 52 eligible storefronts"), "none", "corpus-level fact", "app-specific", [])
c(147, "§8.3 Group A — the English-language billing crisis: US, UK, CA, AU, NZ, IE = 62.87%; every one above the corpus billing rate and every one collapses in E4 (verbatim era table)", "market",
  "Group A (US, UK, Canada, Australia, New Zealand, Ireland = 27,328, 62.87%): every one has a bill_core rate above the corpus average and every one collapses in E4 — US 3.447/11.00% → 4.334/4.15% → 4.246/5.77% → 2.560/42.63%; UK 2.948/15.90% → 3.986/7.92% → 4.022/8.77% → 2.113/47.26%; Canada 3.356/16.67% → 4.060/7.61% → 3.940/10.11% → 2.355/48.20%; Australia 3.394/11.11% → 3.974/7.73% → 3.976/7.19% → 2.226/51.63% — in Australia in 2024–26 more than half of everything written is a billing dispute",
  "web billing funnel in English markets", "1★-burst", table("## 8.3 Group A — the English-language billing crisis"), "product-rule", "very strong", "yes", [])
c(148, "§8.4 Group B — Latin America and the Gulf, where the product is working: br, mx, cl, co, ar, pe, ec, do, cr, sa = 12.33%, group mean 4.285; Brazil the best control case, healthy through E4", "market",
  "Group B (Brazil, Mexico, Chile, Colombia, Argentina, Peru, Ecuador, Dominican Republic, Costa Rica, Saudi Arabia = 5,360, 12.33%): group mean 4.285, market means 4.12–4.59, bill_core 2.35%–6.42%; Brazil is the single best control case — 2,630 reviews, mean 4.266, staying healthy through E4 (4.002, 7.49%) while the US sits at 2.560 / 42.63%; Mexico the same (E4 4.274 / 5.71%) — language-neutral evidence that something about how the product is sold in these markets is materially different",
  "same product, different sales funnel by market", "praise", "n=5,360 (12.33%), mean 4.285; br E4 4.002 / 7.49%; mx E4 4.274 / 5.71%", "research", "very strong", "yes", [])
c(149, "§8.5 Continental Europe — a middle case now converging (verbatim era table): France held out longest (E3 4.384, highest era-market figure of any large market) and still fell; Netherlands E4 2.170 / 41.00%", "market",
  "Continental Europe converges late: France 3.870/3.48% → 4.281/1.83% → 4.384/2.96% → 3.118/22.83%; Germany 3.215/9.23% → 4.200/2.36% → 4.031/5.76% → 2.810/30.60%; Netherlands 3.018/5.36% → 3.677/8.60% → 3.927/7.32% → 2.170/41.00% — France held out longest and best (E3 4.384, the highest era-market figure of any large market) and still fell; the billing change reached non-English markets later and hit them less hard, but it reached them",
  "billing change rolled out to non-English markets later", "churn", table("## 8.5 Continental Europe — a middle case that is now converging"), "research", "very strong", "yes", [])
c(150, "§8.5 Germany — design praise at 19.61%, nearly 3× the corpus rate and highest of any large market, alongside scam vocabulary at 10.97%: the clearest two-population split", "market",
  "Germany is a distinctive sub-case: design/art praise runs at 19.61% — nearly three times the corpus rate (6.83%) and the highest of any large market — while scam vocabulary runs at 10.97%; German reviewers write about the app's craft more than anyone and the German corpus is the clearest example of the two-population split",
  "n/a", "mixed", "n=1,504; design 19.61% vs 6.83%; scam 10.97%; mean 3.610", "none", "meaningful", "app-specific", [])
c(151, "§8.6 China mainland — the market this method cannot read: mean 3.431, 28.6% 1★; only 15.3% Latin-detectable; what must not be said is that China has no billing problem; same caution for Russia (63.2%), Korea (59.0%), Japan (78.6%, mean 3.043, 40% 1★ on n=70)", "data-caveat",
  "China mainland (1,250, eighth-largest storefront): mean 3.431, 28.6% 1★ — worse than the corpus on both — with a computed bill_core of 0.24% that is not a finding because only 15.3% of reviews contain Latin-script words; China is dissatisfied above the corpus average and the report cannot say why; what must not be said is that China has no billing problem; the same caution applies to Russia (63.2% Latin-detectable), Korea (59.0%), Japan (78.6% — rating profile notably poor, mean 3.043, 40.0% 1★, n=70, limited evidence) and Thailand (98.6%)",
  "n/a", "complaint", "cn 3.431 / 28.6% 1★ / 15.3% readable; jp 3.043 / 40.0% 1★ (n=70)", "research", "measurement gap", "app-specific", [])
c(152, "§8.7 The small-market tail — 94 storefronts, 1,256 reviews (2.89%), mean 3.980, 19.6% 1★, better than the corpus [limited evidence]", "market",
  "The 94 sub-50 storefronts (1,256 reviews, 2.89%) are in aggregate better than the corpus — mean 3.980, 19.6% 1★; largest: Taiwan 49, Uruguay 46, Croatia 44, Lithuania 44, Kuwait 40, Bulgaria 39, Korea 39, Slovakia 38, Guatemala 35, Kazakhstan 34; no individual claims made",
  "n/a", "mixed", "n=1,256 (2.89%), mean 3.980, 19.6% 1★", "none", "limited evidence", "app-specific", [])
c(153, "§8.8 What genuinely varies by country (verbatim table) — billing rate, mean rating, design-praise rate (partly classifier artefact), language requests (vn, uz, ru, br, it) vary; praise vocabulary, forced-water complaint (6 languages) and clutter complaint do not", "market",
  "Varies by country: billing-dispute rate (2.35% Saudi Arabia → 26.39% Finland), mean rating (2.361 Finland → 4.593 Ecuador/Nigeria), design-praise rate (0.68% Brazil → 19.61% Germany, partly a classifier-coverage artefact), language requests (Vietnam, Uzbekistan, Russia, Brazil, Italy); does not vary: the praise vocabulary (small steps, coaching, art, 'life-changing' in every language), the forced-water complaint (English, Spanish, German, French, Portuguese, Arabic) and the clutter complaint wherever the classifier can read",
  "n/a", "mixed", table("## 8.8 What genuinely varies by country"), "none", "corpus-level fact", "yes", [])

with open("Tools/prd_ledger/24/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
