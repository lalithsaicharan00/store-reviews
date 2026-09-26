import json, re
R = 16
rep = open("App Store Reports/16. Atoms - from Atomic Habits - The official Atomic Habits app (REPORT).md").read().split("\n")
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

# ---- PART 4 ----
c(40, "§4.1 5★ table (verbatim); 4★ table (verbatim); 3★ table (verbatim); 2★ table (verbatim); 1★ table (verbatim)", "data-caveat",
  "Per-band theme tables for all five bands",
  "n/a", "mixed", "5★: " + table("### 5★ — n = 581") + " ;; 4★: " + table("### 4★ — n = 102") + " ;; 3★: " + table("### 3★ — n = 135") + " ;; 2★: " + table("### 2★ — n = 142") + " ;; 1★: " + table("### 1★ — n = 208"), "none", "verbatim", "app-specific", [])
c(41, "§4.1 5★ — brand trust is doing 42% of the work; a 5★ here is not evidence of a healthy product", "insight",
  "The 5★ recipe is 'I love Atomic Habits, this is the official app, it's beautiful and simple, and it works' — brand trust is doing 42% of the work; a 5★ here is not evidence of a healthy product: 29 five-star reviews still object to the price, 13 still hit the Pro cap, and 9 believe the app is free ('I can't believe all of it's been free?' — a user who has not yet reached day 28)",
  "brand-led", "praise", "5★ n=581; brand halo 242 (41.7% of 5★); simplicity 150 (25.8%); price objection 29; Pro cap 13; believes free 9", "none", "band analysis", "app-specific",
  ["13019922003"])
c(42, "§4.1 4★ — the smallest band, and it is a pricing band; 3★ — almost entirely money; 2★; 1★ — more than seven in ten are a packaging decision", "insight",
  "The 4★ band is not 'one missing feature' but 'I would give five but for the price' ('Love this atomic app - but too rich for my budget'); 3★ is a price band not a quality band (only 15% about the app working badly); 2★ is 72.5% price; more than seven in ten 1★ reviews are a packaging decision, not a product defect",
  "n/a", "1★-burst", "4★ price 31 (30.4%); 3★ price 76 (56.3%), broken 20 of 135 (14.8%); 2★ price 103 (72.5%); 1★ price 153 (73.6%), cash-grab 50 (24.0%), freeze 15 (7.2%), design praise inside 1★ 26 (12.5%)", "product-rule", "band analysis", "yes",
  ["10988655507"])
c(43, "§4.2 Themes that appear on both sides of the rating line table (verbatim)", "contradiction",
  "Both-sides themes: design praise (complimented on the way out), the habit constraint (loved at 3–6, hated at 1), price (a loud paying-willing minority), the brand (earns and destroys reviews), Mindset content (praised when free, resented when paywalled)",
  "n/a", "mixed", table("## 4.2 Themes that appear on both sides"), "none", "verbatim", "yes", [])

with open("Tools/prd_ledger/16/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
