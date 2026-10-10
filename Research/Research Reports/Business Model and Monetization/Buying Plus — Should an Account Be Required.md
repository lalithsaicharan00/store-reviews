# Buying Plus — Should an Account Be Required?

Written by Claude (Claude Code), 10 October 2026, for Current Work 80 (Product Roadmap 64). The user, the same day:
"people should be able to buy Plus from the App Store … it should verify it in the Cloudflare server and store it
against the user once they buy it … it should mandatorily link the user account … without an account they can't buy
Plus. Let's do some research: should we make the account mandatory or not? … entitlement issues and all of these, we
have to take care."

**Evidence.** Users show: a fresh scan of all 1,487,223 reviews for an account and a purchase in the same passage
(1,736 candidates); the **342** where an account was demanded or wanted around a purchase were **read one by one** and
coded ([`Research/Temp/plus-purchase/`](../../Temp/plus-purchase/): `scan.py`, `forced.json`, `codes.py`); the other
1,394 (mostly lost purchases and subscription complaints) were not read again here, because the earlier billing study
already coded 477 such reviews ([Architecture 02 §2](<../../../Architecture/02. Billing and Entitlements.md>)). Platform
rules: Apple's App Review Guidelines (fetched today) and App Review's own rejection wording quoted in Apple's developer
forums. Earlier work this builds on, not repeated: [Plus Scope and Account at Purchase](<Plus Scope and Account at Purchase.md>)
(27 Sep) and Architecture 02.

---

## 1. The answer

**Don't require an account before buying Plus. Make the account the normal path, record every purchase on our server,
and require the account only for the parts of Plus that really are account-based.** The user's goal (Plus can never be
lost, and it lives on the server against the person) is met without making the account a wall, which App Review is
likely to reject and which turns a sign-in failure into a payer locked out.

| | Required account (the assumption) | Recommended |
|---|---|---|
| Buying | Sign in first, then the store sheet | The store sheet at once; signed-in people buy straight into their account |
| After buying, signed out | — | "Plus is yours · one last step: keep it with your account" (Continue with Apple / Google), with **Not now** |
| Where Plus lives | The account | **The App Store purchase itself** (always) **and** the account (whenever there is one) |
| App Review 5.1.1(v) | Likely rejection (§2) | Allowed |
| A sign-in that fails | The payer can't use what they bought (§3) | Plus works on the device regardless; only sync waits |

## 2. What Apple allows

- **Guideline 5.1.1(v), as it reads today:** "If your app doesn't include significant account-based features, let
  people use it without a login. … Apps may not require users to enter personal information to function, except when
  directly relevant to the core functionality of the app or required by law." ([App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/))
- **How App Review applies it to purchases** (its rejection notes, quoted by developers): "Apps cannot require user
  registration prior to allowing access to app content and features that are not associated specifically to the
  user. User registration that requires the sharing of personal information must be optional or tied to
  account-specific functionality", and the fix it asks for: "Revise your app to not require users to register before
  purchasing in-app purchase products that are not account based. Explain that registering enables access to the
  purchased content on their other iOS devices, with a way to register later." ([forum 731471](https://developer.apple.com/forums/thread/731471),
  [forum 724336](https://developer.apple.com/forums/thread/724336)). A tour app that argued its purchases "needed
  account recovery and cross-device access" was still rejected ([forum 688899](https://developer.apple.com/forums/thread/688899)).
- **Why this applies to Plus:** Plus includes unlimited habits, the Apple Watch app and the iPad layout. None of those
  needs an account, so Plus as a whole isn't "account-based". Sync across devices, Android later and Plus Family are
  account-based, and those may require the account (App Review: "requesting that users register to track purchases
  … is acceptable", but not before reaching what isn't account-based).
- **Restore stays required whatever we do** (3.1.1: "a restore mechanism for any restorable in-app purchases"); an
  App Review reply notes it's the last resort when someone forgets their app account or is on another Apple ID.

So a required account is not impossible (Plus Family will require one, as Architecture 02 §3.6 already says), but for
Plus itself it puts the launch at the mercy of a reviewer's reading, with Apple's own wording against it.

## 3. What users show

From the 342 hand-read reviews (habit and routine apps unless said; ★ is the mean rating):

| Theme | Reviews | Mean ★ | Apps |
|---|---|---|---|
| **Paid, but the login the paid features hang on failed** (can't sign in, logged out daily, premium gone on a new phone, asked to pay again) | **46** | **1.96** | 15 |
| An account demanded before trying or buying | 37 | 1.62 | 15 (8 from built-in apps) |
| Praise for needing no account | 24 | 4.83 | 17 |
| Wants an account so a purchase survives a new device | 7 | 2.71 | 6 |
| An account that kept a purchase or data across phones, praised | 3 | 5.00 | 3 |
| Web subscriptions that need a website login to cancel | 57 | 1.09 | 3 |

- **The biggest signal is the first row.** When an app makes paid features depend on its login, every login failure
  becomes "I paid and can't use it": "I paid for the annual but it won’t let me sign in. To use the premium I have to
  sign in but every time I try the app gets jammed" (Fabulous, 1★, `7252285462`); "Paid for a full subscription then
  got a new phone and it won't let me login to my paid account" (Habit Tracker, Play, 1★,
  `0b7589bf-550e-404b-b4cb-f303ca1623ab`); "App requires me to hit Sign In with Apple button each launch", from someone
  who bought lifetime premium (Habitify, `8052654243`). A required account adds this failure to every purchase.
- **Forced accounts are disliked** (1.62★) and their absence is praised (4.83★), as the 27 Sep study found at larger
  scale (forced sign-up 86 reviews, 1.42★; no-account praise 151, 4.85★).
- **But some people do want an account so Plus survives:** "if u asking for purchase primuin, u have to add the user
  account too!" (Rise, 4★, `6cd0f901-3053-4966-a5df-9eb39fef71df`); "because you don't have to register your email when
  you purchase, I am not able to even sign in anymore" on a second device (Habit Tracker, Play, 1★,
  `da5964e9-f0d4-4cd9-b9ce-824f6a362d74`). These are about **reaching another device**, which our
  account (sync) solves, and the App Store's own restore solves on the same Apple ID.

**Reading:** people want Plus never to be lost, and never to be blocked by a login. Both point the same way: the App
Store purchase is the floor that always works, and the account is the layer that carries it further.

## 4. What changed since the 27 Sep decision

The 27 Sep plan (Architecture 02 §3.2: buy first, then "one last step" with a Not now link) still holds, with two
changes:

1. **Free accounts now exist** (Current Work 78, 11 Oct: a free account syncs one device). Many people who buy Plus
   will already be signed in, so their purchase goes straight to their account with nothing extra to do.
2. **The server is ready for most of it**: `POST /v1/purchases/verify` checks Apple's signature, refuses a purchase
   made for a different account (`appAccountToken`), records it once (`purchase` table), and the App Store Server
   Notifications hook removes Plus on a refund or revocation. What's missing is in §6.

## 5. Every entitlement case, and what should happen

"Plus" below means the device's own check of the App Store (`Transaction.currentEntitlements`, StoreKit 2) **or** the
account's record on our server. Either one grants it; only a confirmed refund or revocation removes it (Architecture 02
rule 4, "never downgrade on doubt").

| Case | What happens |
|---|---|
| Buys while signed in | `appAccountToken` = the account; verified and recorded on the account; every device signed in to it gets Plus |
| Buys while signed out | Plus at once on the device (StoreKit); then "Keep Plus with your account" (Continue with Apple / Google · Not now). Signing in later sends the purchase to the server and records it |
| Reinstall, or a new iPhone on the same Apple ID | StoreKit says Plus on first launch, with nothing to press; signing in also brings it from the account |
| iPad or a second iPhone on the same Apple ID | Plus from StoreKit; sync needs the account (the iPad asks to sign in to bring the habits) |
| Another device on a **different** Apple ID | Plus only through the account (sign in) |
| Offline, or our server down | StoreKit's last answer and the cached account entitlement stand; Plus is never removed for not reaching us |
| Refund or revocation | Apple's notification removes Plus from the account; StoreKit removes it on the device; **no data is ever touched**, and the account goes back to free (one syncing device) |
| A refund reversed | Plus returns (`REFUND_REVERSED`, already handled) |
| Ask to Buy, or purchases off (Screen Time) | "Waiting for approval" / "Purchases are turned off on this device"; nothing granted until it's paid |
| Buys Plus twice (two Apple IDs) | The server sees two purchases on one account; support can refund one |
| A purchase made for account A, sent while signed in to B | Refused (409, already built): "This purchase was made for a different account"; support moves it |
| One purchase, two accounts | Refused (`purchase_linked_elsewhere`, already built); support moves it |
| Signs out | Plus stays on the device while StoreKit says so (it's the Apple ID's purchase); the account keeps its record |
| Deletes the account | The account's record goes with it; the App Store purchase still unlocks Plus on that Apple ID |
| Family Sharing | Off for Plus (Architecture 02 §3.6); Plus Family is our own invite, and needs an account |
| Restore Purchases | Visible in ≡ › Plus; shows a real result ("Plus found, bought 12 Mar"), never a fake "restored" |
| Already owns Plus and taps Get Plus | Shows "You have Plus", never the store sheet |
| Dev builds | Every account is Plus on dev (item 68): turned off before any real purchase is tested |

## 6. What has to be built

1. **App Store Connect:** the Plus product (non-consumable, Family Sharing off), its price and regional prices (the
   price is still open, Architecture Backlog); a StoreKit configuration file for tests; sandbox testers.
2. **The app:** StoreKit 2 purchase from the Plus screen (`appAccountToken` = the account when signed in);
   `Transaction.updates` from launch; `currentEntitlements` on every launch; `finish()` after the server has it (or at
   once when signed out); Restore; the after-purchase "keep it with your account" step; plain-word errors
   (Architecture 02 §3.9); `isPlus` from StoreKit **or** the account.
3. **The server:** accept a purchase sent by a device that signs in later (it's recorded when they sign in, as today);
   point App Store Server Notifications V2 at `/v1/hooks/apple` in App Store Connect (production and sandbox); revert
   `EVERYONE_PLUS` (item 68) before testing real purchases.
4. **Tests:** StoreKit Testing in Xcode for every row of §5 (purchase, pending, failed, refund, revoke, restore,
   offline); server tests for the routes; then a sandbox purchase on the iPhone (U9).

## 7. For the user to decide

1. **Optional account with a strong "keep it with your account" step (recommended),** or **a required account** before
   buying (App Review risk, §2; payers locked out by sign-in failures, §3).
2. The Plus price and regional prices (open since 27 Sep).

## Sources

- Apple, [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) 3.1.1, 3.1.3(b), 5.1.1(v)
  (fetched 10 Oct 2026).
- App Review rejection wording quoted by developers: [forum 731471](https://developer.apple.com/forums/thread/731471),
  [forum 724336](https://developer.apple.com/forums/thread/724336), [forum 688899](https://developer.apple.com/forums/thread/688899),
  [forum 690348](https://developer.apple.com/forums/thread/690348) (restore).
- Reviews: `Research/Temp/plus-purchase/forced.json` (342 read), codes in `codes.py`; the quotes above are from that
  file and were checked against it.
