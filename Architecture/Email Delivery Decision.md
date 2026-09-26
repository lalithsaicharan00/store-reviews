# Email OTP and purchase confirmations

**Accepted 26 Sep 2026. Documentation only; not implemented.** Email OTP login and purchase confirmation emails are in launch scope. The sending provider is still pending. This decision supersedes the earlier Apple + Google-only launch and the assumption that email login requires a paid Cloudflare plan.

## 1. Email login means a one-time code

- Offer **Continue with email**, alongside Apple and Google. Explain: **“We’ll email you a sign-in code. No password needed.”**
- Enter email → request a 6-digit code → enter the code → our backend verifies it and issues our normal session. This is passwordless login, not email/password and not a forgot-password flow.
- An existing linked email key opens its account. A verified, unlinked address requires an explicit **Create account** or authenticated **Link sign-in method** action. Matching a contact email alone never merges accounts or grants access to an existing account.
- Email codes are requested on actual sign-in or linking, including after sign-out or session revocation; not on every app opening and not only on new devices. Normal session refresh needs no email.
- Guest use remains available. Sign-in needs connectivity; local habits remain usable during an email or backend outage.

**Backend rules:** generate codes using a cryptographically secure random source, bind each challenge to its address and purpose, give it a short expiry, enforce an attempt limit and consume it atomically once. Store a keyed digest rather than the plaintext code; do not log codes or include them in analytics. Enforce resend cooldowns and per-address/IP/global limits. A resend invalidates the previous code. Final expiry, cooldown and attempt-limit values are implementation settings to validate before launch.

Before verification, responses must not disclose whether an address has an account. A send failure or exhausted provider quota must not claim that the code was delivered. Never accept an expired code or deliver it later from a long-running retry queue. Monitor OTP delivery separately from routine confirmations.

The email provider sends messages only. It does not own our users, OTP validation, sessions or account linking. See [Accounts and Identity](<01. Accounts and Identity.md>).

## 2. Purchase confirmation

- After our server verifies a **new completed paid purchase** and records its entitlement, schedule a transactional confirmation to the buyer's verified contact email, if available. A pending, cancelled, failed or unverified purchase does not trigger one.
- Confirmation states the product, lifetime access where applicable, purchase date and store, plus where to view purchases or contact support. Use only verified purchase details; do not invent a price, currency or invoice number.
- This is our app's confirmation. The store remains responsible for its own receipt and billing records; our email does not replace that receipt.
- **No email or account requirement for buying.** A signed-out purchase still unlocks through the native store flow. If we have no verified address, skip our confirmation. Do not assume we receive the buyer's billing email from Apple or Google.
- Restoring, reinstalling, linking an old purchase, replayed store notifications and granting family access do not generate another “new purchase” email. Do not send retroactive confirmations merely because an address becomes available later.
- Email failure never delays or revokes Plus. Persist a retryable delivery job separately from sending, with a unique key based on store + purchase ID + message type. Record the job with the purchase/entitlement transaction so a crash cannot silently lose the confirmation.
- Retries and duplicate events use the same job. Use provider idempotency where available; reconcile an uncertain send result before retrying through another provider. Do not promise exactly-once inbox delivery across providers.
- Before dispatch/retry, recheck the address, account deletion, suppression state and purchase status. Cancel stale jobs after deletion or a confirmed refund/revocation.

See [Billing and Entitlements](<02. Billing and Entitlements.md>). These emails and OTP requests/resends consume the same sending allowance.

## 3. Sending provider can change

Keep one small **server-side email interface**, with provider adapters:

```text
OTP / verified purchase event
    → our template + delivery policy
    → email sender interface
    → Resend / Brevo / Cloudflare adapter
```

- Keep HTML/plain-text templates in our repository, with ordinary message fields (recipient, sender, subject, body). Avoid dependence on provider-hosted templates or marketing workflows.
- Keep API credentials in backend secrets, never in the apps or shared client KMP core. Apps call our auth/purchase endpoints; they never call the email provider directly.
- Own the verified contact address, challenge state, delivery-job state and blocked-recipient records in our backend. Normalize provider delivery/bounce/complaint events and verify their authenticity.
- Use our own verified sending domain. Preserve suppression records when changing providers; a migration must not restart sending to known invalid or complaining recipients.
- Select one provider initially. Multiple live providers and automatic failover are not required for launch.

**Cloudflare migration:** enable its sending service, onboard/verify our domain and its DNS records, implement the sending and delivery-event adapters, reconcile pending sends and suppression records, then test OTPs and confirmations (including Apple relay addresses) before switching configuration. Keep the old provider available temporarily for rollback without sending each message twice. The same sender address can remain, subject to domain verification. Users, sessions and app releases do not need migration under this design.

This is a bounded backend integration and DNS change, not merely an API-key replacement. Provider logs and sending reputation do not automatically transfer; test delivery after the change.

## 4. Provider choice and cost

**Not finalized:** Resend is the current implementation preference for our low expected volume and its official Cloudflare Workers example. Brevo offers more free daily headroom. Choose based on expected peak sends, onboarding and actual delivery tests, not only monthly allowance.

Official published allowances checked 26 Sep 2026:

| Provider | Free allowance | Burst constraint / source |
|---|---|---|
| Resend | 3,000/month | 100/day; [pricing](https://resend.com/pricing), [Workers example](https://resend.com/docs/send-with-cloudflare-workers) |
| Brevo | 300/day | Unused daily allowance does not accumulate; [plans](https://help.brevo.com/hc/en-us/articles/208589409-About-Brevo-s-pricing-plans) |
| Mailjet | 6,000/month | 200/day; [pricing](https://www.mailjet.com/pricing/) |
| Mailtrap Email API/SMTP | 4,000/month | 150/day; [pricing](https://mailtrap.io/pricing/) |
| SendPulse transactional | 12,000/month | 400/day, 50/hour; [pricing](https://sendpulse.com/pricing/smtp), [limits](https://sendpulse.com/knowledge-base/smtp/limits) |

A free Cloudflare Worker can call an external email API; **email login does not itself require Workers Paid**. Cloudflare's own outbound Email Sending currently requires Workers Paid and is marked Beta. Recheck availability, quotas and pricing before setup or migration. Low monthly volume does not guarantee enough daily/hourly quota for a launch spike. These are allowances, not guarantees of inbox delivery.

Sources: [Cloudflare Email Service](https://developers.cloudflare.com/email-service/), [pricing](https://developers.cloudflare.com/email-service/platform/pricing/), [domain configuration](https://developers.cloudflare.com/email-service/configuration/domains/), [suppression management](https://developers.cloudflare.com/email-service/configuration/suppressions/).

## 5. Implementation acceptance checks

- Correct OTP signs into the linked account; expired, reused, superseded or over-attempt codes fail. Contact-email matches cannot bypass account linking.
- Existing sessions refresh without emails; quota exhaustion and delivery failures leave local data usable and give an honest sign-in message.
- Verified paid purchase schedules one logical confirmation job; pending/failed purchases, restores and repeated notifications do not. Guest purchase without email still unlocks.
- Delivery retries do not block entitlements; deletion, suppression and refund checks cancel ineligible jobs.
- Both adapters obey the same sender contract; migration preserves templates, account/session behavior and suppression state. Test real delivery, DNS authentication and Apple relay compatibility before a production switch.
