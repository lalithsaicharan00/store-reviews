# Terms Page — What It Must Say

Written by Claude (Claude Code), 4 November 2026, at the user's request: Terms comes next after Support, because Google's consent screen already links to `/terms`.

## The answer

**One page at `/terms`, shaped like Privacy: four plain questions at the top, then 15 short sections in plain English.** It replaces the live page, which still describes the old app.

The page's real job is to answer the fears people have about paying for an app, and to set honest limits on reminders and health. A lawyer should read it before launch.

## What people want to see here (W6)

A machine scan of 372,850 English reviews of habit trackers. **These are keyword counts, not hand-coded, and they are noisy:** "lifetime subscription" is often praise, or a wish for one. Use them as a ranking only.

| Worry | Mentions (4–5★ / 3★ / 1–2★) | Share of reviews | 1–2★ |
|---|---|---|---|
| Lifetime or one-time purchase talked about | 385 / 79 / 444 | 0.24% | 48% |
| App abandoned or shut down | 207 / 98 / 345 | 0.17% | 53% |
| Terms or fine print mentioned | 17 / 4 / 192 | 0.06% | 90% |
| Free feature moved behind a paywall | 44 / 37 / 194 | 0.07% | 70% |

Twenty-eight samples were read by hand: 20 lower-rated one-time-purchase reviews and 8 about terms.

- **Users show terms are used against them.** Almost every mention is about charges or refunds, with support pointing at the small print to refuse. So our page never hides anything that matters about money. It says it first, in plain words.
- **Users show anger at paying once and being asked again:** features taken from people who had paid, or a lifetime purchase followed by a yearly charge. So the page promises what's true of Plus: one payment, nothing to renew, never turned into a subscription.
- **Users show anger when free things become paid.** Our own rule already answers it: nothing free at launch ever moves into Plus ([Implementation — Up Next](<../../../Implementation — Up Next.md>)). The page says so.

The four questions at the top come from those worries, plus health. The layout is reasoned from first principles, the same as Privacy: anyone who wants only the short version has it in ten seconds.

Very few reviews talk about a missed medicine reminder (only 4 keyword matches). The reminder and health sections are there because the app really does track medicine and quitting, and phones really do delay reminders (the Rulebook's Infinix findings, 4 Nov 2026). That's reasoned from first principles.

## What the stores and Google ask for

- **Google Play:** no terms page is required that this research could find. Its own terms apply to the copy people get from it.
- **Google's consent screen:** a terms link is optional in the documentation found, and must sit on an authorised domain. Ours is already listed, so the page must exist. [Google's account-linking docs](https://developers.google.com/identity/account-linking/oauth-linking?oauth=code)
- **Apple:** an app with no custom licence gets [Apple's standard licence](https://www.apple.com/legal/internet-services/itunes/dev/stdeula/) automatically ([App Store Connect help](https://developer.apple.com/help/app-store-connect/manage-app-information/provide-a-custom-license-agreement)). **We keep the standard one:** a custom licence would have to meet Apple's Minimum Terms, which weren't read here. Neither Apple page says whether a separate terms page may sit beside the standard licence, so ours says Apple's comes first on iPhone.

## What the page says

Facts are from the Android code and the Rulebook (D10, D15, D16, A73), and match the approved Privacy and Support pages.

| Question at the top | Answer |
|---|---|
| What do I pay? | Nothing for free; Plus is one payment |
| Can you take Plus away? | No, unless the store refunds it |
| Who owns my habits? | You do |
| Can I rely on it for my health? | It isn't medical advice, and a phone can delay a reminder |

The sections: who the terms cover, using the app, the free plan and Plus, paying and refunds, your habits and your backups, reminders and alarms, health, Google Play and the App Store, how the app is provided, limits on our responsibility, your rights under the law, if the app changes or stops, stopping, changes to these terms, contact.

**Left out on purpose:**

- **The price of Plus,** which the site never prints.
- **Which country's law and courts apply.** That's a legal choice for the user and a lawyer. The page says instead that people keep the rights their own country's law gives them.
- **A ban on bots or copying the website.** The site wants search and AI tools to read it.

**Update, 4 Nov 2026:** the Refunds and Delete your data pages were dropped, so Terms links to Support for both.

## Open

- **Three promises bind the user, so they're worth a careful read:** what's free stays free; Plus never becomes a subscription; Plus is moved by hand between iPhone and Android.
- **A lawyer hasn't read this.** The limits on responsibility in particular depend on each country's law.
- **Apple's Minimum Terms** weren't read, because we use the standard licence. Read them if we ever write our own.
- **"Stays on your phone if we stop"** is true of Android. Check it when the iPhone app is rebuilt.

## Sources

- Reviews: `Research/Temp/website-terms/` (not in git; the scan is run from `Research/`)
- [Apple: Provide a custom license agreement](https://developer.apple.com/help/app-store-connect/manage-app-information/provide-a-custom-license-agreement) · [Apple's standard licence](https://www.apple.com/legal/internet-services/itunes/dev/stdeula/)
- [Google Account Linking with OAuth](https://developers.google.com/identity/account-linking/oauth-linking?oauth=code) (this doc covers account linking; a general rule for other apps wasn't found)
- Earlier: [Website Reset](<Website Reset — Pages, SEO and AI Search — 4 November 2026.md>) · [Privacy Page](<Privacy Page — What It Must Say — 4 November 2026.md>) · [Support Page](<Support Page — What People Need Help With — 4 November 2026.md>)
