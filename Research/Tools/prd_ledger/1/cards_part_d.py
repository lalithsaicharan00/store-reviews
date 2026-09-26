import json
R = 1
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=None))

# ---- 6.1 US ----
c(117, "§6.1 table", "market", "US roadmap themes above 3%: simple UI 32.2%, reminders 9.4%, competitor named 9.0%, streaks 7.2%, ADHD 7.1%, widget 6.9%, crashes 5.6%, customisation 4.7%, confirmed purchase 4.1%, fitness/health 4.0%, price fair 3.2%",
  "n/a", "mixed", "US n=5,436, mean 4.27, 9.4% 1★; full table in §6.1", "do", "high-priority", "yes", [],
  side="'everything above 3% is a roadmap item for the US'")
c(118, "§6.1 table row fitness", "audience", "Fitness / weight / health tracking is a 'very strong' US use case",
  "n/a", "praise", "215 US (3.96%) VERY STRONG", "do", "very strong (US)", "yes", [])
c(119, "§6.1 table row focus timer", "feature", "A focus timer is a 'meaningful' US theme",
  "has a focus timer", "praise", "72 US (1.32%) MEANINGFUL", "undecided", "meaningful (US)", "yes", [])
c(120, "§6.1 'US is an ADHD product'", "audience", "The US is an ADHD product: 7.08% of US reviews mention ADHD, autism, executive dysfunction, depression, anxiety, OCD or brain fog, and they rate it 4.79",
  "titled as 'ADHD Planner'", "praise", "385 US reviews (7.08%) HIGH-PRIORITY, mean 4.79 — 'single best-fitting audience'", "do", "high-priority", "yes",
  ["14471682651","13606761481","12049623222","11311674388","11112049976","10970057468","10757452341","10636005774","10393613916","10296500513","10158656394","9989831299","9852989405","9668892809","9567634950","9329775634","8824929179","8366119419"],
  cond="also UK 5.5%, NL 5.7%, IE 7.7%, ZA 5.5% (§6.2–6.3) — an English-market pattern")
c(121, "§6.1 US notes bullet 1", "do", "US discovery is TikTok / YouTube / Instagram / Reddit and therapist recommendation",
  "n/a", "praise", "5 IDs; no count", "do", "qualitative", "yes", ["14092312477","12824807574","11364976648","10633557367","10081645485"],
  side="therapist recommendation ties to the ADHD audience")
c(122, "§6.1 US notes bullet 2", "positioning", "US users frame the app through 'Atomic Habits' and '75 Hard'",
  "n/a", "praise", "'heavy framing'; no count", "do", "qualitative", "yes", [])
c(123, "§6.1 US notes bullet 3", "insight", "In the US the lifetime option is a genuine competitive weapon because anti-subscription sentiment is strong",
  "lifetime SKU", "purchase-driver", "lifetime / not-a-subscription 134 US (2.47%) MEANINGFUL", "product-rule", "meaningful (US)", "yes", [])
c(124, "§6.1 US notes bullet 4", "market", "Localisation is a non-issue in the US (0.20%) — ignore it there",
  "English", "none", "0.20% of US", "none", "ignore (US)", "yes", [])

# ---- 6.2 rich markets ----
c(125, "§6.2 table + 'English-speaking' line", "market", "English-speaking rich markets (US/UK/CA/AU/NZ/IE) are near-identical: ADHD framing, widget, streaks, anti-subscription pricing; they need stability and the one-time price, not localisation",
  "n/a", "mixed", "US 4.27 / UK 4.30 / CA 4.29 / AU 4.29 / NZ 4.76 / IE 4.54; top signals ADHD, widget, crashes, price-fair, bought", "do", "high-priority", "yes", [])
c(126, "§6.2 table row NZ", "market", "New Zealand is the best-rated rich market (4.76, 1.1% 1★) with the highest price-fair and purchase signals",
  "n/a", "purchase-driver", "n=94, mean 4.76, 1★ 1.1%; price-fair 9.6%, bought 6.4%, widget 6.4%", "none", "small n", "yes", [])
c(127, "§6.2 'Western Europe' line", "market", "Western Europe (DE/FR/ES/IT/NL/PT): localisation is the biggest market-specific ask and a stated purchase blocker; also week-start Monday/Sunday setting, dd/mm date format, European DST bug, broken Mac/M1, 'too feminine' design",
  "English-only for most of its life", "blocked-conversion", "FR localisation 15.9%, ES 21.8%; FR mean 4.01, ES 3.98, NL 3.99 (lowest rich-market means)", "do", "high-priority", "yes", [],
  side="week-start and date-format settings are cheap localisation-adjacent fixes",
  cond="DST bug: Oct 27 missing / Mar 29 duplicated")
c(128, "§6.2 'Japan' line", "market", "Japanese localisation shipped ~June 2026 after years as the #1 ask and immediately produced 5★ reviews praising both the localisation and the buy-once model — the clearest proof in the dataset that localisation converts",
  "shipped Japanese ~June 2026", "5★-burst", "JP n=132, mean 4.00, localisation 16.7% before shipping; 5 glowing IDs after", "do", "high-priority", "yes",
  ["9490334380","14239800706","14379368271","14376545696","14445698207","14437414708"],
  side="early translations had errors (iCloud sync labelled 障害者 / 'disabled person') — machine translation quality is visible to users")
c(129, "§6.2 'Korea' line", "market", "Korean is still unshipped and still requested — by patient 5★ reviewers",
  "no Korean", "blocked-conversion", "6 IDs, all 5★", "do", "weak", "yes", ["13999601567","13957001291","13260788938","12104042341","10742118809","10210224741"])
c(130, "§6.2 'Gulf' line", "market", "Arabic is a 12.2% in-market signal in Saudi Arabia (HIGH-PRIORITY), alongside missing Islamic icons and a Hijri-calendar request",
  "no Arabic; no Islamic icons; no Hijri calendar", "complaint", "SA n=131, localisation 12.2% HIGH-PRIORITY in-market; UAE 1★ rate 16.9%", "do", "high-priority (in-market)", "yes",
  ["13831858646","13708335665","13331431985","11788130875","11750488103","11452329638","11040206467","10894442514"])
c(131, "§6.2 table row Taiwan", "market", "Taiwan is the only rich market where shared habits is a top-3 signal",
  "n/a", "mixed", "TW n=274, shared habits 3.6%, reports 3.3%", "none", "small signal", "app-specific", [])

# ---- 6.3 high-volume markets ----
c(132, "§6.3 table + language table", "market", "Localisation in volume markets is the biggest single market-specific finding: Spanish 182 requests, Portuguese 162, French 48, Russian 44, Turkish 43, Japanese 22, Arabic 16, Ukrainian 12, Vietnamese 8, Korean 6",
  "shipped ES ~Aug 2024 (partial/reverted?), PT ~Sep–Oct 2025, JA ~Jun 2026, RU/UK ~mid-2026 with quality complaints; TR still unshipped Aug 2026", "blocked-conversion",
  "Chile 33.8% (highest in dataset), Brazil 20.0%, Argentina 17.6%, Peru 17.5%, Russia 16.1%, Colombia 15.7%, Turkey 14.5%, Mexico 12.2%, Ukraine 11.4%, Kazakhstan 10.5%; requests peaked at 8.06% of all non-CN reviews in 2025, fell to 3.02% in 2026 as languages shipped",
  "do", "high-priority", "yes",
  ["13184823707","12958742820","13510576895","12751833462","13201946828","14459701739","14511362211","11631593284"],
  side="markets with heavy localisation complaints (BR, MX, ES, FR, CL, CO) have the weakest purchase signal (0–1.3%)",
  cond="a shipped language visibly lowers the request rate the following year")
c(133, "§6.3 table row India", "market", "India shows billing complaints at 1.3% — a market-specific billing problem",
  "n/a", "complaint", "IN n=672, mean 4.54; billing 1.3%; purchase signal 3.1%", "must-never-break", "small signal", "yes", [])
c(134, "§6.3 table rows Philippines / Indonesia", "market", "The broken family plan shows up as a 3.3% signal in both the Philippines and Indonesia",
  "family plan via Apple Family Sharing", "complaint", "PH family plan 3.3% (purchase signal 3.8%); ID family plan 3.3% (purchase signal 0%)", "research", "small signal", "app-specific", [],
  side="family plans matter more where a single purchase is shared across a household")
c(135, "§6.3 table rows Malaysia / Romania", "market", "Malaysia and Romania have unusually high purchase signal (6.4%, 7.5%); Romania's widget signal is 15.1%",
  "n/a", "purchase-driver", "MY n=109, bought 6.4%; RO n=53, widget 15.1%, bought 7.5%", "none", "small n", "yes", [])
c(136, "§6.3 table row China", "market", "China has the lowest purchase signal of any major market (0.86%) despite 72% of reviews",
  "review campaign", "none", "CN n=40,991, mean 4.82, 1★ 1.1%; reports 1.9%, widget 0.9%; purchase 0.86%", "dont", "high-priority", "app-specific", [])

with open("Tools/prd_ledger/1/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
