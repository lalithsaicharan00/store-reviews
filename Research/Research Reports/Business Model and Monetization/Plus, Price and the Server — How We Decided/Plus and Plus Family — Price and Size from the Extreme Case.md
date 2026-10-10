# Plus and Plus Family — Price and Size from the Extreme Case

Written by Claude (Claude Code), 10 October 2026, for Current Work 80; second pass the same day after the user's
review. The user's asks: work out what Plus should cost from its overall value in dollars (Apple's cut, tax, servers,
fixed costs, profit), **treating every user, free and Plus, as an extreme power user** for 10, 15 years or more, with
free users' costs paid out of Plus; then Plus Family the same way; then how many people Plus Family holds. Second
pass: "be very realistic … not the happy path": include **inflation**, **regional and student prices** and real
(never fake) discounts, and stay **profitable with a good margin on every sale**, never selling at break-even. Look
again at the earlier price research: we provide cross-device sync, which several apps priced like us don't.

## 0. Decided by the user, 10 Oct 2026

| | Decision |
|---|---|
| Plus | **One-time. The list price is never below $24.99**; raise it if the evidence leaves room (this report recommends **$29.99**, §6) |
| The lowest price anywhere | **Never below $19.99**, whatever the region, student price or sale; this report sets the working floor at **$20.99** (§7) |
| Plus Family | **$59.99** one-time, **5 people** (the buyer + 4) |
| Free users | **Must be cheap by design** (§5): the prices hold only if free accounts cost almost nothing |
| Every sale | Profitable with a good margin, never at break-even; discounts are real, never a raised price shown crossed out |

Still open: the Plus list price ($24.99 or $29.99), the student price and how students are verified (§7).

## 1. The answer

- **With the server as built, $24.99 loses money in the realistic-pessimistic case** (§4): an extreme Plus user's
  15 years plus its share of free accounts, with inflation and Apple at 30%, costs about $23 against $15.27 kept.
  No price people accept fixes that; the server must.
- **With the changes in §5, one Plus sale costs about $8.74** in that case, and every price from $24.99 up is
  profitable: **43% margin at $24.99, 52% at $29.99** (Apple 30%), 53% and 61% at Apple's 15%.
- **$29.99 is the highest price the reviews support** (§6), and our Plus has what makes people pay: sync across
  devices. It leaves room for a **30% student or regional discount ($20.99)** that still keeps about a third of
  every sale as margin.
- **Plus Family at $59.99 for 5** keeps 42% (Apple 30%) and 53% (15%). Discounts on it stay small (§7).
- **What no price can survive** is the stress case (§4): 40 free accounts per buyer, a fifth of them extreme for 20
  years. That risk is handled by §5's free-account design and the cost alerts, not by the price.

## 2. The assumptions

**Every user extreme.** A Plus user: 60 habits, about 70 logs a day (25,000 records a year), 3 devices, the app open
about 5 hours a day, for 15 or 20 years, every record kept. A free account: about 27 logs a day (10,000 a year), one
device. For comparison, reviewers track a median of 5 habits, most often 3; 1 in 50 track 50–300.

| | Pessimistic (the working case) | Stress |
|---|---|---|
| Years each account lives | 15 (20 shown too) | 20 |
| Inflation of server prices | **3% a year** (cloud prices have mostly fallen; we assume they rise) | 5% |
| Apple's cut | **30%** (15% shown too: the Small Business Program, under US$1 million a year) | 30% |
| Sales tax / VAT inside the price | 10% average (20% for an EU-only check) | 20% |
| Refunds | 3% | 3% |
| Free accounts per Plus sale | **20** (5% of people buy) | 40 |
| …of which stay extreme for the whole time | **10%**; the rest go quiet after a year and are archived (§5) | 20% |
| Support, per sale (our estimate) | $1.50 | $3.00 |
| Fixed costs (Workers plan, Apple Developer Program, domains: about $200 a year) | $0.25 a sale | $0.25 |

Server prices: Cloudflare's as read 11 Oct 2026, none of the plan's included amounts counted. Measured inputs: 1,390
bytes stored and 5 rows written per new record (dev, 10 Oct), nightly copy about 89 bytes a record. No paid
advertising is assumed; if we buy installs, their cost comes out of the margin.

## 3. What one sale leaves us

| Price | Apple 15%, 10% tax | Apple 30%, 10% tax | Apple 30%, 20% VAT |
|---|---|---|---|
| $20.99 | $15.58 | $12.83 | $11.40 |
| $24.99 | $18.54 | $15.27 | $13.57 |
| $29.99 | $22.25 | $18.33 | $16.29 |
| $59.99 (Family) | $44.52 | $36.66 | $32.59 |

## 4. What a sale costs, and the margin

| One Plus sale, pessimistic case, 15 years | Server as built (two small levers) | With every change in §5 |
|---|---|---|
| The extreme buyer | $13.30 | **$3.57** |
| 2 free accounts extreme for 15 years | $8.18 for all 20 | $2.41 |
| 18 free accounts archived after a year | (included above) | $1.00 |
| Support and fixed costs | $1.75 | $1.75 |
| **Total** | **$23.23** | **$8.74** |

**Margin** (what's left after every cost, as a share of what the sale leaves us), with every change in §5:

| Price | Apple 30%, 15 yrs | Apple 15%, 15 yrs | Apple 30%, 20 yrs | Apple 30%, EU VAT 20% |
|---|---|---|---|---|
| $20.99 | 32% | 44% | 7% | 23% |
| $24.99 | 43% | 53% | 22% | 36% |
| **$29.99** | **52%** | **61%** | **35%** | **46%** |
| $34.99 | 59% | 66% | 44% | 54% |
| Family (5) $49.99 | 31% | 43% | −2% | 22% |
| **Family (5) $59.99** | **42%** | **53%** | **15%** | **35%** |
| Family (5) $69.99 | 51% | 59% | 27% | 44% |

- **Stress case:** one Plus sale costs $29.70, mostly free accounts. No habit-app price covers it (a 30% margin would
  need $78). The protection is §5 and the alerts: if the free load ever approaches this, we see it within a day.
- **20 years:** history keeps growing, so the oldest accounts cost the most. $29.99 stays well in profit; $24.99 and
  the Family price get thin. That is also the argument for raising the price for *new* buyers over the years (§8).

## 5. What must be built for these prices to hold (the user: free must be cheap by design)

**Free accounts (required before launch):**

1. **One device, push only:** a free account sends when something changes and never polls (already the plan for
   free sync, Current Work 78).
2. **Archive quiet accounts:** after about 12 months with no sign-in, the account's data moves to cold storage (R2,
   compressed) and comes straight back when they sign in. Nothing is ever deleted (D1, D4). Cost: about $0.06 for a
   whole quiet account's life.
3. **7 daily copies,** the change log trimmed once the device has a change.

**Every account, Plus included (required for the margins above):**

4. **Sync by push for Plus too** (a hibernating WebSocket): requests follow changes (about 150 a day for an extreme
   account), not a 60-second timer on every device (about 900 a day).
5. **Only the last 2 years of history in the Durable Object;** older years compressed in R2, read when needed.
6. **3 rows written per record** (not 5), and the change log trimmed.
7. **Nightly copies as changes** (a monthly full copy plus daily changes), read only for what changed.
8. **The daily cost report and alerts** (Server Cost §4.5), and this model rerun whenever Cloudflare's prices change.

## 6. The Plus price: how high the evidence allows

Users show (earlier studies, their counts; Feature Ledger C064, C013; Business Model §2.2 and §4.3):

| Price seen | What reviewers did |
|---|---|
| Streaks $3.99 → $9.99 over 11 years | Objections stayed flat (1.75% → 2.21%); they're about value per feature, not the number |
| Awesome Habits lifetime $22.99 (2026) | **0% price objections**; at €28 in 2023, 4.2–4.6% |
| HabitKit about €35 lifetime | Objections rise: too much "for a utility" |
| About $40 lifetime (report 34) | Objections, but many at 4–5★: "great app, too expensive" |
| $49 lifetime | The highest figure US reviewers name |
| $99.99 lifetime (report 46) | Too high; reviewers' anchor was $30–70 |
| $79.99–149.99 lifetime | Rejected by people who accept the model |

- **Sync is what people pay for:** cloud sync and more devices is the strongest difference among buyers (lift ×9.8,
  C013), and payers cluster in multi-device and iPad use ([Plus Scope §2](<../Plus Scope and Account at Purchase.md>)).
  Our Plus is exactly that, kept on our own server.
- **Reading:** the objection line sits around $30–35. **$29.99** is just under it, with sync to justify it; $34.99
  would add 7 points of margin and cross it.
- **Recommendation: $29.99** (the user's floor of $24.99 is the fallback). At $29.99 the 30% discount in §7 lands at
  $20.99, close to the $22.99 that drew no objections.

## 7. Discounts: real, never stacked, never below the floor

**The rule:** servers cost the same for a user in every country, so **no price anywhere goes below $20.99 in US
dollars, before that country's tax** (32% margin at Apple 30%, 44% at 15%). That's above the user's $19.99 line.

| Discount | Plus at $29.99 | Plus at $24.99 | How |
|---|---|---|---|
| Regional (purchasing power) | Up to **30% off** → $20.99 | Up to 16% off | Apple equalises prices from the base country by exchange rate; storefronts we set by hand keep their price, and we keep them up to date ([App Store Connect Help](https://developer.apple.com/help/app-store-connect/manage-app-pricing/set-a-price)) |
| Student | **30% off** → $20.99 | 16% off | A one-time-use **offer code** after the student is verified. Apple extended offer codes to one-time (non-consumable) purchases in 2025, iOS 16.3 and later ([Apple: implementing offer codes](https://developer.apple.com/documentation/storekit/implementing-offer-codes-in-your-app)). How to verify students is still open |
| A sale (New Year) | Up to 30% | Up to 16% | Honest dates, no countdowns; the list price is never raised beforehand |
| Plus Family | At most **$10 off** ($49.99, 31% margin) | — | Families already save; deeper cuts drop below 30% |

Discounts never stack: a student in a lower-priced country pays the lower of the two, never less than the floor.
One gap: the floor is a US-dollar figure, and exchange rates move. Check regional prices against it whenever Apple
re-equalises them.

## 8. Inflation over the years

- **A one-time sale is fixed in today's dollars, but its costs come later and rise.** The model charges every year's
  server cost at 3% (stress: 5%) inflation, so the margins above already allow for it.
- **The price can rise for new buyers, never for past ones** (Apple 3.1.2(a); taking back lifetime is the worst
  move, One-Time report §3). Streaks shows reviewers accept gradual rises. Review the price once a year against
  this model.
- **Keep about $2 of every sale in reserve** for the old accounts (One-Time report §2).

## 9. Plus Family: how many people (decided: 5)

Users show (18 hand-read reviews state how many people use one app or plan together; 76 candidates read):

| People together | Reviews |
|---|---|
| 2 (a couple, a friend) | 6 |
| **3 (a parent and two children, mostly)** | **9** |
| 4 | 2 |
| 5 (two parents and three children) | 1 |
| 6 or more | **0** |

- **The families people ask for are small:** "the value isn’t there subscribing for 3 individuals" (Finch, 5★,
  `14131330487`); "Two of the four of us have Plus" (Finch, 1★, `14243659017`); "I don't want to pay $88 per year for
  the 4 of us" (Routine Planner, Play, 4★, `e75d5c70-e005-467a-9dbc-f19feae7a5eb`); paying twice to share one list is
  "£30!" (Tasks, Play, 3★, `c8a0649e-204d-4e58-98fc-21862355ce85`). Nine reviews ask for a family plan or shared paid
  access (mean 3.56★).
- **One habit tracker sells a five-person lifetime plan;** its 11 reviews about it (mean 2.73★) are all about **not
  finding how to add people**, never about the number: "how I can add the other 4 members?" (Habit Tracker, 2★,
  `14295143605`). Our invite must be obvious right after buying.
- **Reasoned from first principles:** Apple's Family Sharing holds six, but no review describes a household that
  needs six, and every extra extreme person costs as much as a buyer. Five covers every household seen.

## 10. Evidence and files

Model: [`Research/Temp/plus-pricing/`](../../../Temp/plus-pricing): `extreme_price.py` (first pass), `pricing_v2.py`
(inflation, discounts, margin, server as built), `pricing_v3.py` (every change in §5), `family_table.py`. Family size:
`family_size_scan.py` (all 1,487,223 reviews; a head-count near a family or sharing word and a payment word),
`family_codes.py` (the 76 read by hand). Price evidence: the earlier studies' counts, not recounted.
