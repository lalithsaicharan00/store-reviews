# Build the Plus Screens (prompt for a cloud session)

Written by Claude (Claude Code), 10 October 2026, at the user's request, for a cloud session to pick up and finish.

> **When the work is done and merged, delete this whole folder** (`iOS/Docs/Plus Screens — Build Prompt (Delete When
> Done)/`, the prompt and its images) in your last commit. It is a one-time hand-off, not a document to keep.

## 1. The job

Build the **Plus screens** of the iPhone app: every place someone meets Plus, the Plus page, buying, owning Plus,
Plus Family, restoring, and Plus ending. The pictures in [`images/`](images/) show each screen. Make them real,
working SwiftUI screens with **StoreKit 2** purchases, test them lightly, fix real bugs, and merge into `main`.

**Only the screens and the purchase.** Leave the server, accounts, sign-in and sync exactly as they are today. The
user has decided that the app will drop the server and sync through iCloud (Rulebook D16), but that is **later, separate
work**. Don't start it, don't remove anything for it, and don't wire CloudKit.

## 2. Read first

1. `RULEBOOK.md`, all of it (it says why). Especially S (speed), U1/U2 (native, monochrome chrome), U3 (no shame
   words), U6, U9, T1–T3, T7, T9, T10, T14, T15, T17, W1, W3.
2. `iOS/Design Rules — Don't Regress.md` (rules agents broke before).
3. The decisions behind these screens: `Research/Research Reports/Business Model and Monetization/Plus, Price and the
   Server — How We Decided/README.md` (read the "Where things stand" table; the reports are optional).
4. `iOS/Docs/Checklists/Current Work Checklist.md`, item 80 (Buying Plus) and its sub-points: tick what you finish.

You can't open Figma; everything you need is in this file and `images/`.

## 3. The design is a mockup, not the final look

The pictures are **mockups**. Follow what each screen says and does, and its order of things, but make it **look
good: clean, calm and minimal**, the way a good native iPhone app looks:

- Native SwiftUI components, SF Symbols, system fonts, light and dark, Dynamic Type (U1). No custom chrome that iOS
  already has: sheets with a grabber, `xmark` close, native alerts, `List`/`Form` styles where they fit.
- Monochrome chrome (U2): ink-black filled main buttons (white in dark mode), secondary text in the system's
  secondary colour. Colour only on the person's own habit icons.
- One filled button per screen. Plenty of space. No badges, countdowns, "best value" tags, confetti or pressure.
- If a mockup looks crowded or off, improve it rather than copy it, and say what you changed in the commit.

## 4. Products and prices

`iOS/OftenEnough.storekit` already has the three products; update it to the decided prices:

| Product ID | What | Price | Family Sharing |
|---|---|---|---|
| `com.oftenenough.app.plus` | Plus, just you | **$24.99** | Off |
| `com.oftenenough.app.plusfamily` | Plus Family: you + up to 5 people in your Apple family | **$59.99** | **On** |
| `com.oftenenough.app.plusfamily.upgrade` | Plus → Plus Family, offered only to Plus owners | **$35.00** | **On** |

- All one-time (non-consumable). **Always show the App Store's own `displayPrice`**, never a hard-coded price.
- **Plus = the existing `store.isPlus` OR a StoreKit entitlement** (`Transaction.currentEntitlements` for any of the
  three products, not revoked). Keep the existing server/account path working; just add StoreKit beside it.
- Keep Debug's `store.isPlus = !arguments.contains("-free")` (AppModel): tests launch with `-free` to be free.
- Use: `Product.products(for:)`, `product.purchase()` (handle `.success` verified, `.pending` = Ask to Buy,
  `.userCancelled` = nothing shown), `Transaction.updates` from launch, `transaction.finish()`, `AppStore.sync()` for
  Restore Purchases, `transaction.ownershipType == .familyShared` for a family member, `revocationDate` for a refund,
  `AppStore.canMakePayments` for purchases turned off. Errors in plain words, never an error code.

## 5. The screens

The number before each picture's name is the order. Each line says what the screen is for and what must be true.

**Flow 1 · Starting a 6th habit** (free plan holds 5 habits, `HabitStore.freeHabitLimit`)

- `01-before-the-limit.png`: New habit at 4 of 5: a quiet "4 of 5" count in secondary text. Never a banner or colour.
- `02-sixth-habit-sheet.png`: at 5 of 5, starting a habit opens this sheet straight away. Their own 5 habit icons and
  an empty 6th; **Plus and Plus Family side by side** (Plus chosen; the button follows the choice: "Get Plus · $24.99"
  / "Get Plus Family · $59.99"); a short "Both plans include" list (unlimited habits, iPad and Apple Watch, sync
  through your own iCloud); then **"Make room instead"** as a plain text button with a small note (archive or delete).
  **✕ is the only way out; there is no "Not now"** (the user's decision).
- `03-sixth-habit-sheet-from-an-idea.png`: the same sheet from an idea ("Add Drink water"); the idea's form is kept
  whatever they choose: saved after paying or making room; ✕ goes back to it.
- `04-sixth-habit-sheet-restoring.png`: the same sheet from restoring an archived habit ("Bring back Read"); its
  history is never touched; it comes back after paying or once room is made.
- `00-apples-purchase-sheet-illustration-only.png`: **Apple's own sheet. Don't build it**; StoreKit shows it. Cancel
  goes back with no message.
- `05-make-room.png`: "Make room instead": their habits, **Archive** as the plain, safe action on each row; Delete
  only in a ••• menu. Once one is archived, the new habit's form opens: no purchase, nothing lost. Reuse the app's
  existing archive if it has one.
- `06-make-room-delete-alert.png`: ••• › Delete asks first in a native alert that names the habit and offers
  "Archive Instead"; Delete in plain red text, never a red fill.
- `07-plus-is-yours.png`: after paying: "Plus is yours", one line on Plus being on their Apple Account, the line
  "Your habits stay on your devices and in your own iCloud. We never see them.", and Done, which returns to the 6th
  habit, now saved. (That privacy line becomes literally true with the later iCloud work; build it as designed.)

**Flow 2 · ≡ › Plus**

- `08-menu-plus-row-3-of-5.png`, `09-menu-plus-row-5-of-5.png`: the ≡ menu's Plus row shows the free count in plain
  secondary text ("3 of 5"); no dot, badge or colour as it fills. Someone with Plus sees no count; the row opens Your
  Plus (18). Leave the menu's other rows (including Account) as they are.
- `10-plus-page-plus-chosen.png`: the Plus page: "One payment, yours forever", the count, two choices (Plus chosen by
  default), the button names what it buys and its price, and a footer "One-time, no subscription · Restore
  Purchases" (Restore is always on the page, Apple 3.1.1).
- `11-plus-page-family-chosen.png`: the same with Plus Family chosen.
- `12-purchase-didnt-go-through.png`: a store or network error: a native alert in plain words.
- `13-plus-page-prices-didnt-load.png`: offline or the App Store not answering: no made-up price; Try Again.
- `14-plus-page-purchases-turned-off.png`: purchases off (Screen Time), known before tapping: the button is off and
  a line says why and who can change it.
- `15-plus-page-waiting-for-approval.png`: Ask to Buy (`.pending`): the page says it's waiting and can be closed;
  Plus unlocks on its own when approved (`Transaction.updates`).

**Flow 3 · A second device on the free plan**

- `16-second-device-sheet.png`: "Use your habits on this iPad?" **Order matters** (the user's decision): Plus first
  as a calm card with an outlined "See Plus" (opens the Plus page), the free "Move to this iPad" last with the only
  filled button. ✕ changes nothing. Build the sheet and its wording; keep whatever the app does today when the free
  account moves to another device (don't change sync).

**Flow 4 · Plus Family**

- `17-plus-family-is-yours.png`: after buying Plus Family: "Plus Family is yours", everyone in their Apple family
  gets Plus on their own devices through Apple's Family Sharing, with nothing to set up here; a small note that
  family members need Share Purchases on (Settings › your name › Family Sharing); Done. **No invites, codes or
  sign-in.**

**Flow 5 · Once Plus is yours**

- `18-your-plus-owner.png`: ≡ › Plus once Plus is owned (never "Get Plus" again): "Plus is yours", how it was bought,
  what's included, "Upgrade to Plus Family" with the upgrade price (Plus owners only), Restore Purchases, Contact Us.
- `19-restore-plus-found.png`: Restore found Plus: a real result naming what was found, never a fake "restored".
- `20-restore-nothing-found.png`: nothing found: a native alert explaining it may be on another Apple Account, with
  Contact Us and OK.
- `21-upgrade-to-plus-family.png`: the upgrade page: "You pay only the difference", the upgrade price, "You already
  have Plus", then Apple's sheet, then screen 17.

**Flow 6 · In someone's Apple family**

- `22-your-plus-family-member.png`: on a family member's device (`ownershipType == .familyShared`): "Plus is yours,
  shared by your Apple family", what's included; habits are their own; leaving the family is done in Settings. No
  Upgrade, no purchase buttons.

**Flow 7 · When Plus ends**

- `23-plus-ended-refund.png`: shown once, the next time the app opens after StoreKit removes Plus (a refund).
  Nothing is hidden or locked: all habits stay, even over 5; adding a 6th needs room or Plus again.
- `24-plus-ended-family-member.png`: a family member's Plus ended (left the family or sharing turned off): the same
  calm message; habits all stay.

**Flow 8 · A new device**

- `25-new-device-plus-already-here.png`: on a new iPhone or iPad with the same Apple Account, StoreKit already says
  Plus: "Plus is yours", nothing to press or sign in to.

**Not to build:** anything about signing in to keep Plus, accounts after buying, Plus Family invites, invite codes,
joining or leaving a family inside the app. Those were dropped with the server.

## 6. Test it, lightly

Thorough testing isn't needed; enough to know it works:

- **Builds and tests run on GitHub Actions only** (T1). You're on Linux: check your Swift with `swiftc -parse` first
  (T17), then let CI build. Follow T10 before any tagged push; use your own branch and, if needed, your own
  `-ci2` branches; never touch other agents' runs or branches.
- Add a small `PlusUITests` class (about 5–7 tests) using the StoreKit configuration file (StoreKit Testing): the
  6th-habit sheet at 5 of 5 shows both plans and no "Not now"; buying Plus reaches "Plus is yours" and the 6th habit
  is saved; Restore with nothing bought shows the "nothing found" alert; prices that fail to load show Try Again; Ask
  to Buy shows waiting. Launch with `-uitest -free` (D8).
- Run `SmallScreenUITests` on the iPhone SE (T15) for the 6th-habit sheet and the Plus page, adding a check if needed.
- Add a `PerfDriver` scenario for the Plus page (T4); a short speed run, not the whole suite.
- Update any existing UI test that taps a label you changed (T3).
- Run `iOS/Tools/perf/check_rules.sh` before every push.
- **If a test finds a real bug, fix it.** Never skip or loosen a test (T2).

## 7. Finish

1. Work on **a new branch of your own** (for example `plus-screens`), never directly on `main`.
2. When the tests above pass, **merge into `main`**. Merge once it's right; don't rush it, and don't merge failing
   work.
3. **Branches:** a cloud session can't delete branches. Once your branch and any `-ci` branches are merged, mark each
   one **"safe to delete"** in `iOS/Docs/Checklists/Merging the Branches.md` (W3), and say so in your summary.
4. Tick item 80's finished points in the Current Work Checklist, note what's built in `iOS/Docs/What's Built.md`,
   and add a short "Plus screens" section to `iOS/Design Rules — Don't Regress.md` with any rule you learned.
5. **Delete this folder** (`iOS/Docs/Plus Screens — Build Prompt (Delete When Done)/`) in the last commit.
6. The user checks the look on their iPhone afterwards (U9); say in your summary that this is still to do, and that
   the products must be created in App Store Connect before a real sandbox purchase.
