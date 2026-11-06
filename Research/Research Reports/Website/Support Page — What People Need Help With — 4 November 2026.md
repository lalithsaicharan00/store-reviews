# Support Page — What People Need Help With

Written by Claude (Claude Code), 4 November 2026, at the user's request: the Support page comes straight after Privacy, because Apple requires a Support URL with real contact details.

## The answer

**One page at `/support`: a real email address first, then 17 short answers in five groups.** Apple wants an easy way to contact the developer, and that matters more here than any list of questions.

The email is **support@oftenenough.com**, through Cloudflare Email Routing (set up by the user, 4 Nov 2026).

## What users show

A machine scan of 372,850 English reviews of habit trackers. **These are keyword counts, not hand-coded, and they are noisy.** Use them as a ranking only. Refund and no-reply counts mostly come from subscription apps, which we aren't.

| Problem | Mentions (4–5★ / 3★ / 1–2★) | Share of reviews | 1–2★ |
|---|---|---|---|
| Refund | 169 / 130 / 5,241 | 1.49% | 94% |
| Contact, or no reply | 804 / 270 / 4,310 | 1.44% | 80% |
| How do I, can't find it | 1,764 / 597 / 2,084 | 1.19% | 46% |
| Reminders not arriving | 846 / 392 / 973 | 0.59% | 44% |
| Backup or new phone | 883 / 261 / 831 | 0.53% | 42% |
| Crash | 507 / 292 / 1,133 | 0.52% | 58% |
| Widget problems | 537 / 197 / 294 | 0.28% | 28% |
| Purchase not restored | 115 / 56 / 526 | 0.19% | 75% |

Twenty-eight samples were read by hand, seven from each of four groups.

- **Users show silence hurts as much as the bug:** "Wrote them an email for an issue & 5 days later I still haven't heard". The no-reply reviews are angry about being ignored, often after paying. So contact comes first on the page, and the card says a person reads every email.
- **Users show a paid plan lost on a new phone is a sharp complaint:** "I bought a new phone and it won't let me restore my purchase". So Plus has its own group, with the plain rule that it stays with the store account.
- **Users show reminders that fail break trust in the app.** That question leads the page.

## What the page says

Every step was read from the Android code, using the app's own names: Keep reminders coming, Backup & Sync, Restore from a backup, Undo last restore, New day starts at, Contact us.

| Group | Questions |
|---|---|
| Reminders | Why is my reminder late or missing? |
| Widgets | How do I add a widget? Why has my widget stopped updating? |
| Backup and your data | Back up, a new phone, iPhone and Android, the wrong backup, why a restore asks for Plus, deleting |
| Plus and payments | I paid but don't have Plus, charged again, refund, moving Plus between stores |
| Using the app | Undo a log, skip a day, pause a habit, staying up past midnight |

This holds the question-and-answer text the homepage left out ([Private and Backed Up](<Private and Backed Up — What the Homepage Still Missed — 4 November 2026.md>)). The layout is reasoned from first principles.

**Left out on purpose:** a reply time. We can't promise one yet, and a broken promise is worse than none.

**Update, 4 Nov 2026:** the Refunds and Delete your data pages were dropped, so Support now holds both answers itself. The refund answer adds that Google Play can send people to us: [Google's help](https://support.google.com/googleplay/answer/15574908) directs in-app purchase problems to the developer.

## Open

- **"A person reads every email" is a promise.** It's true while the user answers their own mail.
- **Moving Plus between iPhone and Android by hand** (D16) needs a way to do it before launch.
- **iPhone steps** come from the Rulebook, because the iPhone app is frozen during the Android work. Check them when it's rebuilt.

## Sources

- Reviews: `Research/Temp/website-support/` (not in git; the scan is run from `Research/`)
- [Website Reset](<Website Reset — Pages, SEO and AI Search — 4 November 2026.md>) §3 for Apple's Support URL
