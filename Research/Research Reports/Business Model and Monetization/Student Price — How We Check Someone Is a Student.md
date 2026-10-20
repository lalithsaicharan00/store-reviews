# Student Price — How We Check Someone Is a Student

Written by Claude (Claude Code), 20 October 2026, at the user's request: "how we are going to verify whether an email
is a college email or not … if we can't verify properly, then every custom [email] will become like a college email …
we can't use SheerID … if it is free, we will use it … think about how can we verify robustly so that only students
get discount"; then "how do we handle students who don't have a college email or their email is not in the list?"

Current Work 147. This is the plan for the build. The designs are in Figma, Plus & Account row 11
(`1476:2`). They were drawn before this note, and the changes they need are listed at the end. **Nothing here is
built yet.** It's done when the complete purchase flow is built (the user: "we will implement this when we are
implementing the complete working of this").

## 1. Paid services: not used

| Service | What it costs us | Why not |
|---|---|---|
| **SheerID** | No free plan or free tier. Pricing is a private quote; Vendr's buyer data puts the median contract at about **$70,800 a year** ([Vendr](https://www.vendr.com/buyer-guides/sheerid); [Capterra](https://www.capterra.com/p/147803/SheerID/): "free version not included") | Students verify for free, but the app pays. Far more than a $12.49 one-time discount could ever return |
| **UNiDAYS, Student Beans** | A commission on every sale through them; rates aren't published ([how UNiDAYS earns](https://productmint.com/?p=7915)) | Marketplaces that also list our discount in their own apps. Not free, and not what we want |

## 2. The free way: four checks together

This is the method JetBrains uses to give students free licences.

1. **The address must be on a list of universities.** JetBrains keeps **swot** ([github.com/JetBrains/swot](https://github.com/JetBrains/swot),
   MIT licence; a fork of the list GitHub Education first built). Each school's domain is a file, and a domain covers
   its subdomains. A separate `abused.txt` lists domains abused in the past; we reject those too. `@gmail.com` or a
   made-up domain fails at once. Our account Worker bundles the list and updates it from the repository.
   [Hipo's university-domains-list](https://github.com/Hipo/university-domains-list) can be a second source
   (check its licence before using it).
2. **Proving the address is theirs.** We send a 6-digit code to the address, and the person types it back (Figma
   11.2). Only someone who can open that school inbox passes.
3. **Once per person.** Our server keeps a **one-way fingerprint** of the address (a salted hash), never the address,
   so one school email can't unlock the price twice. Google Play's discount offer also limits it to one purchase per
   Google Play account.
4. **The purchase must match a real check.** After the right code, our server gives the app a one-time student ticket.
   The app passes it to Google Play with the purchase (`BillingFlowParams.setObfuscatedAccountId`). When our server
   confirms the purchase, a student-priced purchase must carry a valid ticket. This stops a modified app from buying at
   the student price without the check.

The iPhone does the same later with Apple's offer codes. The iPhone is frozen until Android is finished.

## 3. What this can't stop

- **Graduates who keep their school inbox.** Many universities let former students keep their address. Paid services
  have the same gap unless they check enrolment records. Since Plus is a one-time purchase, the worst case is one
  graduate paying $12.49 once.
- **Schools that aren't on the list.** swot covers colleges and universities with at least one long-term IT-related
  course, not primary or secondary schools. Some real colleges are missing until someone asks (section 4).
- **Students whose college gives them no email.** This is common in some countries (section 4).

## 4. Students the email check doesn't cover

### A school email, but the school isn't on the list: add the school

- The screen says *We don't have your school yet* with **Ask us to add it**. The person doesn't type anything else;
  we already have the address.
- We check **once per school** that the domain belongs to a real college: its official website, or an education
  registry. It takes a few minutes. We add it to our list and send it to swot as a pull request, so it helps everyone.
- We email that school address: *Your school is added. Continue.* The link goes back to the code step. Because it goes
  to the school inbox, it also proves the address is theirs.
- After the first student, everyone from that school passes automatically.

### No school email at all: no student price, said kindly and plainly

We don't check student ID cards by hand:

- **Easy to fake.** A convincing student card takes minutes to make, so it lets more people cheat than the email check.
- **Privacy.** It means storing ID photos with names, faces, dates of birth and ID numbers on a server we promise holds
  almost nothing (Rulebook D16). That's a serious data-protection duty for a $12.49 discount.
- **Cost.** Every card needs a person to look at it, reply and handle disputes. That costs more than the discount.
- **Unfair in its own way.** Cards differ by country and school, so a reviewer would be guessing.

The screen says: *The student price needs an email address from your school. If you don't have one, Plus is $24.99,
and you can still get all your money back within 30 days.* The 30-day refund and the Free plan mean nobody pays
without trying it first.

**Later, only if there's demand:** count how often people tap "no school email" in each country. If one country stands
out, look at a student-card check service for it, such as ISIC's, but only if it's free or cheap. Nothing manual until
then.

## 5. What changes in the designs (Figma, Plus & Account row 11)

- **11.1:** "Only school addresses. Used once, never kept." isn't quite true, because we keep the fingerprint. It
  becomes something like *Only school addresses. We keep only a scrambled fingerprint, so it works once.*
- **11.3 splits into two cases:** *That isn't a school address* (Gmail and the like), and *We don't have your school
  yet*, with **Ask us to add it**.
- **New 11.3.1:** *Thanks. We'll email priya@college.edu when your school is added.*
- **New 11.3.2:** *No school email?*, with the plain answer from section 4 and Get Plus at $24.99.

## 6. Still the user's decisions (Current Work 147)

How much the student price is (the designs assume half price, $12.49), and whether it's Just you only or Family too.
Whether hardship or low-income discounts join the same page (Feature Ledger C025 covers both).
