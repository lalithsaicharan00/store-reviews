# Plus — One-Time or Subscription, and What Sync Costs Over the Years

Written by Claude (Claude Code), 10 October 2026, for Current Work 80. The user's question that day: Plus is a lifetime
purchase, but the server costs keep running. Should Plus become yearly or monthly? If the app becomes a hit, could the
server bills for many Plus users grow past what they paid, so we can't pay them? And what does "sync across devices"
cover: phone to phone, or phone, desktop and web?

**Evidence used.** No new review scan. Cost: Cloudflare's prices as read on 11 Oct 2026 and the measurements taken on
the dev server on 10 Oct ([Free Sync — One Device at a Time §2.1](<../../../../iOS/Docs/Specs/Free Sync — One Device at a Time/README.md>),
[Server Cost and Capacity](<../../../../Architecture/Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>)), run
through a small model ([`Research/Temp/plus-pricing/lifetime_cost.py`](../../../Temp/plus-pricing/lifetime_cost.py)).
Users: the earlier studies' coded reviews, quoted with their own counts, not recounted:
[Habit Tracker — Business Model, Free Baseline and Moat](<../Habit Tracker — Business Model, Free Baseline and Moat.md>)
§4–5, [Free Plan Design](<../Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>) §9 and
[Architecture 02](<../../../../Architecture/02. Billing and Entitlements.md>) §2.

## 1. The answer

**Keep Plus one-time.** Sync is cheap enough that one sale pays for a person's server costs for decades, even if they
use it heavily and keep every record for ever. Being one-time is also the main reason people buy, and apps that
switched to a subscription were punished hard. What a hit app needs is a **small reserve from each sale** and a few
**engineering levers that keep old accounts cheap**, not a subscription. A subscription makes sense only for something
whose cost or value really keeps arriving (the AI "Companion" the business-model report proposed), sold beside Plus,
never instead of it.

## 2. What one Plus user costs, year by year

Pessimistic on purpose: every user treated as a heavy user for requests (the app open about 60 syncs a device a day),
every record kept for ever, 90 nightly copies kept, and none of the Workers plan's included amounts counted.

| Plus user | Year 1 | Year 5 | Year 10 | Year 20 | Total over 10 years | Total over 20 years |
|---|---|---|---|---|---|---|
| Typical (about 1,000 records a year) | $0.06 | $0.08 | $0.10 | $0.15 | **$0.80** | **$2.05** |
| Heavy (about 3,000 records a year) | $0.08 | $0.13 | $0.20 | $0.33 | **$1.39** | **$4.12** |

**What one sale leaves us** at $14.99 (a placeholder price): **$12.74** after Apple's 15% (the Small Business Program,
under US$1 million a year), **$10.49** after 30% above that, a little less where the price includes VAT.

- A typical Plus user's 10 years of server cost is **about 6%** of one sale; a heavy user's 20 years about a third.
- **Measured inputs:** 1,390 bytes stored per new log and 5 rows written per new record (dev, 10 Oct); the nightly copy
  at about 89 bytes a record (the user's own account's snapshot, 9 Oct). Prices: Durable Object storage $0.20 per
  GB-month, R2 $0.015, rows written $1.00 per million.
- **What grows:** only storage, slowly, because history is kept. Requests depend on use, not on age.

### If the app becomes a hit

The bill grows with the number of Plus users, and so does the money, because every new Plus user pays once up front.

| Plus users | Their server cost a month (typical, year 10 of each account) | Money those sales brought in (at $12.74) |
|---|---|---|
| 10,000 | about $85 | about $127,000 |
| 100,000 | about $850 | about $1.27 million |
| 1,000,000 | about $8,500 | about $12.7 million |

**The only way to get into trouble** is to spend all of the up-front money and then keep paying for old accounts for
years with no new sales. A rule removes that: **keep about $2 of every sale in reserve.** That covers a typical user
for about 20 years and a heavy one for about 10, on today's prices, even if sales stopped completely.

## 3. Subscription or one-time: what users show

From the earlier studies (their counts, not recounted here):

- **One-time is the main reason people buy.** "Not a subscription" is the top purchase reason for 22.4% of one app's
  paid cohort; lifetime or one-time wording appears in 15.8% of reviews where people say they paid, 3.7 times the next
  reason ([Plus Scope §3](<../Plus Scope and Account at Purchase.md>)).
- **Switching to a subscription wrecked good apps:** Productive 4.75 → 2.37★; Habit — Daily Tracker 4.56 → 1.62★ in one
  release; Strides 2.21★ for nine months until it went back, then 4.62★ (Business Model §4.1).
- **People say why:** "Subscriptions make sense if there is running cost… this isn't the case"; "A tracker is not a
  service"; a yearly fee reads as a promise of constant new features, and the app is then judged by its update log
  (Business Model §5.1).
- **Billing pain that one-time can't have:** cancelled but still charged (26 reviews, 1.08★), can't find how to cancel
  (34, 1.59★), trials that bill (40, 1.10★) (Architecture 02 §2; Free Plan Design §9).
- **Taking back a lifetime purchase is the worst move of all:** lifetime revoked or turned into a subscription, 26
  reviews at 1.31★; Apple's guideline 3.1.2(a) also forbids taking away what people paid for. So the choice is made
  once, **before launch**: Plus sold as lifetime stays lifetime.

**Reasoned from first principles:** a yearly Plus would bring more money per person over time, but it would put Often
Enough in the group people leave ("a tracker is not a service"), add every subscription failure above, and solve a cost
problem we don't have.

## 4. What "sync across your devices" covers

**Every device the person signs in on, on any platform**, all against one account on our server:

| | Status |
|---|---|
| iPhone ⇄ iPhone, iPhone ⇄ iPad | Built (the iPad runs the iPhone app; its own layout is Roadmap 66) |
| Apple Watch | Later (Roadmap 65): through the iPhone app |
| Android phones and tablets | Later: the same server and the same sync rules (the shared core, Architecture 07) |
| The web, Mac, Windows | Later: the same account; the web page itself costs almost nothing to host (Cloudflare Pages) |

The server doesn't care what the device is: each one sends and receives the same small changes. More devices mean a
few more requests (the model assumes 1.5 devices a Plus user), not more storage: the history is stored once per
account.

## 5. Levers that keep old accounts cheap (none needed at launch)

1. **Trim the change log** once every device has received a change: most of the 1,390 bytes a log is that log; the
   record itself is a few hundred.
2. **Keep fewer nightly copies for older days** (for example 30 daily, then monthly), instead of 90 daily for ever.
3. **Replace the 60-second poll with a push** (a hibernating WebSocket) if active use grows a lot.
4. **The daily cost report and alerts** planned in Server Cost §4.5, so a surprise shows within a day.
5. **Prices change:** rerun the model whenever Cloudflare's prices change.

## 6. For the user to decide

1. ~~Keep Plus one-time (recommended) or make it yearly / monthly.~~ **Decided by the user, 10 Oct 2026: Plus stays
   one-time.**
2. The Plus price (the model used $14.99 as a placeholder).
3. Whether to set aside a reserve per sale (recommended: about $2).
