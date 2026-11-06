# Plus on iPhone — One Large Button, Restore Purchases and the App Store's Sheet

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screen R: Plus (Figma "IOS app",
[Plus page 1204:175](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=1204-175), page "plus"
1166:15123).

## What people come to this page to do

They meet it when they reach a Plus feature (a 6th habit, a checklist, Remind me again, Year in Pixels) or open Plus
from the menu. They want to know what they'd get, what it costs and whether it's a subscription, then buy it or go
back. Someone who bought Plus before (a new iPhone, a reinstall) wants it back. Reasoned from first principles, with
the earlier work in [Plus, Price and the Server](<Plus, Price and the Server — How We Decided/README.md>): one price,
said plainly, one way to buy, and an obvious way to restore.

## What was wrong (the user's points, 6 Nov)

- **No Restore Purchases.** App Review requires a way to restore non-consumable purchases (App Store Review
  Guidelines 3.1.1), and it's how someone on a new iPhone gets Plus back (D16: Plus stays with the store that sold
  it).
- **The button:** Get Plus · $29.99 was a Regular (34) capsule squeezed into a 58-point bar, its word cramped against
  the home indicator's area.
- **Android words:** "Plus stays with your Google Play account", "Backup to Google Drive".
- Sentence-case titles and rows.

## What iOS does

- **The App Store takes the payment in its own sheet** (StoreKit's purchase confirmation with Face ID or the side
  button); the app shows only the button that starts it. The price comes from StoreKit (`Product.displayPrice`),
  in the person's currency.
- **Restore Purchases** is a plain button near the purchase button (StoreKit's own `StoreView` shows it with
  `.storeButton(.visible, for: .restorePurchases)`; it calls `AppStore.sync()`).
- A one-time purchase needs no subscription terms; saying "no subscription" in the footer is enough.
- Family Sharing stays off for Plus (D16).

## What changed

**Plus page, all 10 variants:** Get Plus · $29.99 is a **Large Prominent button** (50) across the bottom bar, with a
**Restore Purchases** Small Borderless button under it, centred, above the home indicator's area; the bar grows to
100 and the content above it fits. The footer says "One payment of $29.99, no subscription. Plus stays with your
Apple Account and comes back on any iPhone signed in to it."; Always free says "Backup to iCloud". Titles and rows in
Title Case (**Add a 6th Habit**, **Checklists Come with Plus**, **Remind Me Again with Plus**; **Unlimited Habits**,
**Today and This Week Widgets**, **Checklist Habits**, **Remind Me Again**, **Support Me as a Developer**), 55 texts.
The five copies on the create new page follow; their captions say the App Store's own sheet takes the payment
(screen P).

## Left for the user

1. **Restore Purchases under the button** (chosen, as StoreKit's own store view) or in the menu variant only.
2. **The price in the button** ("Get Plus · $29.99"). StoreKit's own product view shows the price alone on the button;
   ours keeps the word.
3. **A page for someone who has Plus** (the menu variant after buying): not drawn yet.
