# The one email: purchase confirmation

**Accepted 26 Sep 2026; narrowed 27 Sep 2026.** Documentation only; not implemented.
- **We send exactly one kind of email:** the purchase confirmation, once, to a Plus or Plus Family buyer who has an account.
- **Removed on 27 Sep 2026:**
  - **Email sign-in (one-time codes).** Accounts are Plus-only, and Plus buyers sign in with Apple or Google ([Accounts §1](<01. Accounts and Identity.md>)).
  - **Every other message:** deletion emails, marketing, reminders, shutdown notices and family invites. The owner shares invites as a link, QR or code.
- **Provider: Resend** (decided 27 Sep 2026).

## 1. Who gets it, and when

- **Free users: never.** They have no account, and we don't have their address.
- **Plus buyers with an account:**
  - sent after our server verifies a **new completed purchase** and records its entitlement;
  - sent to the Apple or Google email on the account (an Apple private relay address works if our domain is registered with Apple's relay);
  - a pending, cancelled, failed or unverified purchase triggers nothing.
- **Plus buyers who tapped "Not now":** the email goes out when they sign in, if the purchase is under 30 days old.
- **Plus Family:** one email to the buyer, the same as Plus. Members who join get nothing by email; the app tells them.

## 2. The rules

- **Content:** the product, lifetime access, the purchase date and store, and where to view purchases or contact support. Use only verified purchase details; never invent a price, currency or invoice number.
- **The store's receipt stays separate.** Our email doesn't replace it.
- **At most once per purchase:** a unique key of store + purchase ID + message type. Restores, reinstalls, account linking, replayed store notifications and family joins never send another one.
- **Never blocks Plus:** email failure never delays or revokes anything. The delivery job is recorded with the purchase, so a crash can't lose it, and retries use the same job.
- **Before sending or retrying,** recheck the address, account deletion, suppression state and purchase status. Cancel the job after deletion or a confirmed refund.

See [Billing and Entitlements §3.2](<02. Billing and Entitlements.md>).

## 3. Sending provider can change

Keep one small **server-side email interface**, with provider adapters:

```text
verified purchase event
    → our template + delivery policy
    → email sender interface
    → Resend adapter (Cloudflare adapter later, if ever)
```

- Keep HTML/plain-text templates in our repository, with ordinary message fields (recipient, sender, subject, body). Avoid dependence on provider-hosted templates or marketing workflows.
- Keep API credentials in backend secrets, never in the apps or shared client KMP core. Apps call our purchase endpoints; they never call the email provider directly.
- Own the address, delivery-job state and blocked-recipient records in our backend. Normalize provider delivery/bounce/complaint events and verify their authenticity.
- Use our own verified sending domain. Preserve suppression records when changing providers; a migration must not restart sending to known invalid or complaining recipients.
- Select one provider initially. Multiple live providers and automatic failover are not required for launch.

**Cloudflare migration:** enable its sending service, onboard/verify our domain and its DNS records, implement the sending and delivery-event adapters, reconcile pending sends and suppression records, then test confirmations (including Apple relay addresses) before switching configuration. Keep the old provider available temporarily for rollback without sending each message twice. The same sender address can remain, subject to domain verification. Users, sessions and app releases do not need migration under this design.

This is a bounded backend integration and DNS change, not merely an API-key replacement. Provider logs and sending reputation do not automatically transfer; test delivery after the change.

## 4. Provider choice and cost

**Decided 27 Sep 2026: Resend.**
- **Why:** it has an official Cloudflare Workers example, and its free tier (3,000 a month, 100 a day) far exceeds one email per purchase.
- **If a launch day ever needs more than 100 sends,** jobs queue and go out the next day. The email never blocks Plus, so nothing breaks. Upgrading Resend's plan is a configuration change.
- **Set up:** verify our sending domain (SPF, DKIM), register it with Apple's Private Email Relay, keep the API key in Worker secrets, and test real delivery to Gmail, Outlook and an Apple relay address before launch.
- The other providers below stay as reference only.

Published allowances checked 26 Sep 2026 (for reference):

| Provider | Free allowance | Burst constraint / source |
|---|---|---|
| Resend | 3,000/month | 100/day; [pricing](https://resend.com/pricing), [Workers example](https://resend.com/docs/send-with-cloudflare-workers) |
| Brevo | 300/day | Unused daily allowance does not accumulate; [plans](https://help.brevo.com/hc/en-us/articles/208589409-About-Brevo-s-pricing-plans) |
| Mailjet | 6,000/month | 200/day; [pricing](https://www.mailjet.com/pricing/) |
| Mailtrap Email API/SMTP | 4,000/month | 150/day; [pricing](https://mailtrap.io/pricing/) |
| SendPulse transactional | 12,000/month | 400/day, 50/hour; [pricing](https://sendpulse.com/pricing/smtp), [limits](https://sendpulse.com/knowledge-base/smtp/limits) |

A free Cloudflare Worker can call an external email API, so the one email does not require Workers Paid. Cloudflare's own outbound Email Sending currently requires Workers Paid and is marked Beta. Recheck availability, quotas and pricing before setup or migration. One email per purchase keeps volume far below every free allowance, though a launch-day spike should still be checked against the daily limit. These are allowances, not guarantees of inbox delivery.

Sources: [Cloudflare Email Service](https://developers.cloudflare.com/email-service/), [pricing](https://developers.cloudflare.com/email-service/platform/pricing/), [domain configuration](https://developers.cloudflare.com/email-service/configuration/domains/), [suppression management](https://developers.cloudflare.com/email-service/configuration/suppressions/).

## 5. Implementation acceptance checks

- A verified paid purchase by a buyer with an account schedules one confirmation job. Pending or failed purchases, restores, account linking and repeated notifications don't.
- A buyer who taps "Not now" and signs in within 30 days gets one confirmation; after 30 days, none.
- Free users and "Not now" buyers who never sign in get no email, and nothing in the app waits on one.
- Delivery retries never block entitlements. Deletion, suppression and refund checks cancel ineligible jobs.
- Adapters obey the same sender contract. Test real delivery, DNS authentication and Apple relay compatibility before a production switch.
