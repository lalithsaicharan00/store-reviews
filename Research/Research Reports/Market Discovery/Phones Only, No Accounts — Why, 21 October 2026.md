# Phones Only, No Accounts — Why

Written by Claude (Claude Code), 21 October 2026, at the user's request, over one session of questions. It records the
evidence behind the user's decisions that day (Rulebook D16, rewritten 21 Oct 2026):

- The first launch is **the iPhone and Android phones only**, released together: no iPad, tablet, Apple Watch, Wear OS
  or desktop app.
- We are a **generic tracker** (like HabitNow, HabitKit, Streaks), not a themed app.
- **The iPhone syncs through the person's own iCloud** (CloudKit); **Android backs up to their own Google Drive**.
- **There are no accounts and no Plus Family.** Plus stays with the store that sold it, and **support moves it by hand**
  when someone switches between iPhone and Android.

Evidence comes in three kinds, kept apart as W2 asks: store listings and charts fetched on 21 Oct 2026; review counts
from keyword screens (machine counts, labelled as such); and review sets read by hand (labelled "read"). The scratch files
are in `Research/Temp/buyers-why/`, `Temp/platforms/`, `Temp/plain-trackers/` and `Temp/sync-decision/` (not in git).
Revenue figures are the low-confidence estimates from Codex's revenue research of the same day.

## 1. Why single-platform trackers still sell

**HabitNow** is Android-only (5M+ installs, 4.7★ from 93.3K ratings, one-time Premium of about $5–12). **HabitKit** is an
iPhone app plus an Android app, with no iPad layout, no Watch app and no live sync. Its founder reports about $602,000
of revenue in 2025 and no paid ads.

From the reviews of people who say they paid (HabitKit: 209 candidates read by hand; HabitNow: 1,433 candidates, 510
read by hand, the rest counted by keyword):

| Reason given | HabitKit (97 clear buyers) | HabitNow (893 clear buyers, a lower bound) |
|---|---|---|
| The look, simplicity, "exactly what I wanted" | 34% | 16% |
| A one-time or lifetime price, not a subscription | 26% | 11% |
| Widgets | 21% | 7% |
| Hit the free habit limit | 19% | 5% |
| Cheap, fair, worth it | 16% | 13% |
| To support the developer | 7% | 6% |

When other devices come up among buyers, it's after the purchase: a new phone that lost the habits or the purchase, or a
move to the other platform.

## 2. How many complaints are about lost data

Read by hand: all 449 HabitNow and 66 HabitKit candidates from a multilingual keyword screen.

| | HabitNow (29,021 reviews) | HabitKit (2,993 reviews) |
|---|---|---|
| Lost their data (new phone, reinstall, bug, a backup that didn't run) | 22 (0.08%) | 12 (0.40%) |
| Changing a habit wiped its history | 7 (0.02%) | — |
| Lost everything moving to an iPhone | 8 (0.03%) | — |
| Premium didn't come back on a new phone | 19 (0.07%) | — |

These are minimums: reviews are mostly written in the first days, while loss happens at the next phone change. Every
loss here was on the phone's side; none came from sync, the cause of the large losses in the 1.5M-review data-safety
study.

## 3. Themed apps and generic trackers

The top earners (Finch, Me+, Life Reset, Dear Me, TeddyCare) sell an idea: a pet, a game, a cute self-care
companion. Their own reports show their tracking is not better ("just a checklist": Dear Me 7.7%, average 1.45★). Most
of them sell through ads and a quiz, then a paywall and a yearly subscription. Life Reset: 43.7% of its reviews attack
how it's sold, and Meta's Ad Library showed about 1,100 active ads. Finch is the exception: a product people
recommend, including therapists (381 reviews).

The **generic trackers** checked are outside the US top-grossing charts (21 Oct; Finch is #14 in Health & Fitness).
Streaks is #1 paid in Health & Fitness. Most grow without ads. Meta's Ad Library showed none for HabitNow, HabitKit,
Loop, Way of Life, Strides, HabitMinder or HabitBull, and two for Habitify; it can't show Apple Search Ads or Google's.
A sign-up quiz comes up in 0–0.3% of their reviews, against 1–2% for Me+ and Life Reset.

## 4. Which devices the top apps support

Sixteen apps from the two top-ten lists, by their App Store Compatibility and Play listings:

| | Apps |
|---|---|
| Both iPhone and Android | 14 (InnerGrow and Grit are Apple-only) |
| Phones only (no iPad layout, watch or desktop) | 6: Me+, Life Reset, HabitKit, TeddyCare, Dear Me, Habit Diary |
| An iPad layout | 9 |
| An Apple Watch app | 8 |
| A Wear OS app | 4 of 14 on Android |
| A real desktop or web app | 3: Habitify, HelloHabit, Habitica |

The largest earners have the fewest devices; breadth of devices doesn't follow revenue.

## 5. Sync or backup, and switching platforms

Keyword counts over 21 generic trackers (235,723 reviews):

| | Android reviews | iPhone reviews |
|---|---|---|
| Backup, a new phone, lost data | 0.87% | 0.47% |
| Sync between devices | 0.42% | 0.96% |

Android users ask for backup twice as often as sync (an earlier hand read: most Play reviews that name Google Drive ask
for "automatic backup, like WhatsApp"). iPhone users ask for sync because they own iPads and Watches.

**Switching between iPhone and Android:** read by hand, 72 of the 387 candidates had switched or were about to: 0.03%
of the reviews. Outside the reviews it's more common: about 12% of new US iPhone buyers come from Android (CIRP, March
2026 quarter). HabitKit's and Way of Life's developers move a purchase across platforms by hand, and people thank them
for it (`018127f4`, `bd23c101`, `8727faa7`). Productive refused a lifetime buyer and was punished for it (`3a374250`).

Apple's Move to iOS and Android's copy from an iPhone don't move other apps' data, and the two stores never share a
purchase, so no automatic switch exists without an account. What exists without one: restoring from Google Drive on
the iPhone, the move code (D15), a backup file, and support moving the purchase.

## 6. What the trackers do, and what they charge

Ten of fifteen generic trackers keep data in the person's own iCloud, Dropbox or Google Drive, or in a file. Five run
their own server (Habitify, everyday, Strides, HabitBull, Productive's web). The Apple-only apps that sync through iCloud
are mostly one-time purchases (Streaks $5.99, Habit Hub $4.99, InnerGrow $19.99 lifetime, HabitMinder $19.99). Apps with
their own server charge a subscription, or a lifetime of $50–150. Family plans are rare.

Our own server would be cheap: daily backups of 500,000 free and 50,000 Plus users on Cloudflare R2 cost about $80–100 a
month. The question was accounts and simplicity, not cost. A server needs an account for everyone who backs up, which
the user had ruled out for free users (16 Oct).

## 7. If other devices come later

The data model is already ready for sync: IDs made on the device, field-by-field stamps, delete markers and a queue that
empties only when confirmed (`SyncRules`). Sync can come back over any transport (iCloud, Drive or a server) without
moving data. iCloud sync sells as a one-time purchase on Apple devices, so a later Plus with devices needs no
subscription. The Watch is the likeliest first addition (8 of 16 top apps have one), then the iPad.
