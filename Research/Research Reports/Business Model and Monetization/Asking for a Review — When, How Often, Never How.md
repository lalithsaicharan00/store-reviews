# Asking for a Review — When, How Often, Never How

Written by Claude (Claude Code), 30 September 2026. When and how the iOS app asks for an App Store review. Ledger card [C094](<../Feature Ledger.md#c094>) (ask for reviews well: 53 apps, 160 cards, Certain), with [C054](<../Feature Ledger.md#c054>) (never trade a review for premium), [C076](<../Feature Ledger.md#c076>) (never seed the rating), [C093](<../Feature Ledger.md#c093>) (no nagging) and [C264](<../Feature Ledger.md#c264>) (never add a tap to logging).

## Answer

1. **Only Apple's own request** (`requestReview`). It respects the person's choice in iOS Settings and shows at most three times a year. No "Do you like the app?" question first, no custom screen, and never a reward.
2. **Only after a week of real use:** the first habit made at least 7 days ago, something logged on at least 7 different days, and at least 10 things logged.
3. **Only at a natural pause: the tap that finishes today.** It waits 2 seconds, so the "All done" line is seen first, and not while a routine or a note is open. Never at launch, during setup, on an ordinary check-off, or after an error.
4. **Rarely:** at most once per app version, and 120 days apart.
5. **Rate Habits in Settings → Help**, for anyone who wants to, any time. It opens the App Store's Write a Review, and appears once the app has its App Store ID.

## What the reviews say

The ledger card already holds the hand-read evidence from 53 apps' reports: one-star "nag" reviews, first-day prompts turning a rating into a first-impression score, onboarding prompts pushing contentless 5★ reviews from 7% to 33% of an app's corpus, rewards for reviews, and a manipulative decline button. A fresh keyword scan of habit and routine trackers' reviews (1,238,784 reviews; `Research/Temp/stats/review_prompt/`) finds the same, samples read by hand; counts are floors.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Prompts that nag or repeat | 237 | 42 | 2.78 |
| Asked too early (first minutes, setup, "haven't used it") | 159 | 47 | 2.47 |
| Forced before the app can be used | 68 | 28 | 2.74 |

- **Too early turns into a low rating.** Users show: "I've only tried the app for 5 minutes, but every other time I marked a habit as complete the app popped up a window asking me to rate it" (everyday, 3★, `10053587799`); "A little presumptuous of them to ask for a rating when I just started using the app" (Me+, 5★, `2773e4c5-1ee2-49ce-9d2c-5456061dc50a`).
- **Forcing one gets one star.** Users show: "was forced to review before I could move forward. Gave 1 star because I haven't used the app yet" (Habit Tracker, 1★, `12173581097`).
- **Nagging costs stars from people who like the app.** Users show: "Great app, works as advertised … Only reason for 1-star review is nagging popups asking user to rate the app" (Productive, 1★, `1292613058`); "I'm rating this app so they stop asking me to rate it" (Fabulous, 2★, `50bd7da9-95de-4bc0-b296-0a8ad64aa359`).
- **Trading for a review reads as a scam.** Users show: "Asking for a 5 star rating in exchange of a discount is considered to be scam" (Rise, 1★, `4283369a-22bf-4d6b-8548-669fd9075ddb`).
- **Not asking is noticed too.** Users show: "Ad free, cost free, never been nagged for a rating. Yet here I am" (Loop, 5★, `7bb13d7e-f80f-4a87-93b9-2622880f1063`).

## Reasoned from first principles

- **A review should describe the app, not the first minute of it.** A week of use and ten logs means the person has seen reminders, streaks and a missed day, so a review can tell other people something true, and the rating stays a useful signal for the team (C094: first-day prompts hide real trends).
- **Finishing the day is the pause.** The person has just done everything they meant to; nothing is waiting for their next tap, so the request doesn't block logging (C264). A check-off in the middle of the day is the moment users show is worst.
- **No question of our own first.** Asking "Enjoying Habits?" and sending only the happy ones to the store is review gating; Apple's guidelines forbid custom review prompts, and it biases the rating.
- **Our own limits under Apple's.** Apple caps the request at three a year; once a version and 120 days apart keeps it well under that, so people who ignore it aren't asked again soon.

## Not built yet

- The App Store ID for Rate Habits (set `AppInfo.appStoreID` once the app is listed).
- A "Send Feedback" route for problems, waiting for a support address (`AppInfo.supportEmail`).

## Limits

Keyword counts are floors. Whether iOS shows the request is up to iOS; it can't be tested in this cloud session.
