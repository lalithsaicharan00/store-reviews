import { HttpError, randomToken, sha256Hex } from "./http";
import { type Person, cleanName, emailHint } from "./identity";
import { type PlayCheck, paidFor } from "./play";

/*
 * The account's rules (Current Work 110, Figma 1476:2), the same as the app's stand-in (`StandInAccountServer`), on D1.
 * Every call is safe to repeat: a retry after a lost answer changes nothing twice. Each change that touches more than
 * one row runs as one D1 batch (a transaction), and a place in a family is taken only by claiming its open invite, of
 * which a family has at most one: so a family never grows past six, whatever arrives at once.
 */

export const FAMILY_SIZE = 6;
export const INVITE_MS = 7 * 24 * 60 * 60 * 1000;
export const DAY_MS = 24 * 60 * 60 * 1000;
export const INVITE_LINK = "https://oftenenough.com/join/";

export type PlusKind = "NONE" | "PLUS" | "FAMILY_OWNER" | "FAMILY_MEMBER";

export interface AccountView {
  id: string;
  plus: PlusKind;
  family: {
    owner: string;
    people: { id: string; name: string; owner: boolean; you: boolean; joinedDay: number | null }[];
    /** The open invite: only its owner sees it. */
    invite: { token: string; link: string; endsDay: number } | null;
  } | null;
}

export type InviteLook = { state: "open" | "ended" | "used" | "cancelled" | "full"; owner: string };

interface AccountRow { id: string; provider: string; subject: string; name: string }

/** How we learned Google voided a purchase: its notification, the Voided Purchases API, or a check that said cancelled. */
export type VoidSource = "notification" | "voided_api" | "check";

const day = (ms: number) => Math.floor(ms / DAY_MS);

export class Accounts {
  constructor(private readonly db: D1Database, private readonly now: () => number = Date.now) {}

  // ---------------------------------------------------------------- Who

  async find(person: Person): Promise<AccountRow | null> {
    return this.db.prepare("SELECT id, provider, subject, name FROM accounts WHERE provider = ? AND subject = ?")
      .bind(person.provider, person.subject).first<AccountRow>();
  }

  async byId(id: string): Promise<AccountRow | null> {
    return this.db.prepare("SELECT id, provider, subject, name FROM accounts WHERE id = ?").bind(id).first<AccountRow>();
  }

  /** Makes the account, or finds the one this Google or Apple account already has (two at once still make one). */
  async create(person: Person, appName: string | null): Promise<AccountRow> {
    const now = this.now();
    await this.db.prepare(
      "INSERT INTO accounts (id, provider, subject, name, email_hint, created_at, seen_at) VALUES (?, ?, ?, ?, ?, ?, ?) ON CONFLICT (provider, subject) DO NOTHING",
    ).bind(crypto.randomUUID(), person.provider, person.subject, cleanName(person.givenName, appName), emailHint(person.email), now, now).run();
    const row = await this.find(person);
    if (!row) throw new HttpError(500, "server_error", "The account couldn't be made. Please try again.");
    return row;
  }

  /** On every sign-in: the latest hint (an email can change) and when it was last used. */
  async touch(id: string, person: Person) {
    await this.db.prepare("UPDATE accounts SET email_hint = COALESCE(?, email_hint), seen_at = ? WHERE id = ?")
      .bind(emailHint(person.email), this.now(), id).run();
  }

  // ---------------------------------------------------------------- Sessions (a signed-in device)

  async newSession(accountId: string): Promise<string> {
    const token = randomToken(32);
    const now = this.now();
    await this.db.prepare("INSERT INTO sessions (token_hash, account_id, created_at, used_at) VALUES (?, ?, ?, ?)")
      .bind(await sha256Hex(token), accountId, now, now).run();
    return token;
  }

  /** The account a session token belongs to, or null (signed out, deleted, or unused for 400 days). */
  async sessionAccount(token: string): Promise<string | null> {
    const hash = await sha256Hex(token);
    const row = await this.db.prepare("SELECT account_id, used_at FROM sessions WHERE token_hash = ?").bind(hash).first<{ account_id: string; used_at: number }>();
    if (!row) return null;
    const now = this.now();
    if (now - row.used_at > 400 * DAY_MS) {
      await this.db.prepare("DELETE FROM sessions WHERE token_hash = ?").bind(hash).run();
      return null;
    }
    // At most one write a day per device.
    if (now - row.used_at > DAY_MS) await this.db.prepare("UPDATE sessions SET used_at = ? WHERE token_hash = ?").bind(now, hash).run();
    return row.account_id;
  }

  async endSession(token: string) {
    await this.db.prepare("DELETE FROM sessions WHERE token_hash = ?").bind(await sha256Hex(token)).run();
  }

  // ---------------------------------------------------------------- What the app sees

  async view(accountId: string): Promise<AccountView | null> {
    const me = await this.byId(accountId);
    if (!me) return null;
    const now = this.now();
    const [owned, membership, purchases] = await Promise.all([
      this.db.prepare("SELECT id FROM families WHERE owner_id = ?").bind(accountId).first<{ id: string }>(),
      this.db.prepare("SELECT family_id, joined_at FROM members WHERE account_id = ?").bind(accountId).first<{ family_id: string; joined_at: number }>(),
      this.db.prepare("SELECT product FROM purchases WHERE account_id = ? AND active = 1").bind(accountId).all<{ product: string }>(),
    ]);
    const ownPlus = paidFor(purchases.results.map((p) => p.product)).plus;
    const plus: PlusKind = owned ? "FAMILY_OWNER" : ownPlus ? "PLUS" : membership ? "FAMILY_MEMBER" : "NONE";
    const familyId = owned?.id ?? membership?.family_id ?? null;
    if (!familyId) return { id: accountId, plus, family: null };

    const family = await this.db.prepare("SELECT f.id, f.owner_id, a.name AS owner_name FROM families f JOIN accounts a ON a.id = f.owner_id WHERE f.id = ?")
      .bind(familyId).first<{ id: string; owner_id: string; owner_name: string }>();
    if (!family) return { id: accountId, plus, family: null };
    const members = await this.db.prepare(
      "SELECT m.account_id, m.joined_at, a.name FROM members m JOIN accounts a ON a.id = m.account_id WHERE m.family_id = ? ORDER BY m.joined_at, m.account_id",
    ).bind(familyId).all<{ account_id: string; joined_at: number; name: string }>();
    const invite = owned
      ? await this.db.prepare("SELECT token, ends_at FROM invites WHERE family_id = ? AND state = 'open' AND ends_at >= ?").bind(familyId, now)
        .first<{ token: string; ends_at: number }>()
      : null;
    return {
      id: accountId,
      plus,
      family: {
        owner: family.owner_name,
        people: [
          { id: family.owner_id, name: family.owner_name, owner: true, you: family.owner_id === accountId, joinedDay: null },
          ...members.results.map((m) => ({ id: m.account_id, name: m.name, owner: false, you: m.account_id === accountId, joinedDay: day(m.joined_at) })),
        ],
        invite: invite ? { token: invite.token, link: INVITE_LINK + invite.token, endsDay: day(invite.ends_at) } : null,
      },
    };
  }

  // ---------------------------------------------------------------- Purchases

  /** Who already holds this purchase, if anyone, and when it was last checked. */
  async purchaseHolder(token: string): Promise<{ account_id: string; active: number; checked_at: number; product: string } | null> {
    return this.db.prepare("SELECT account_id, active, checked_at, product FROM purchases WHERE token_hash = ?")
      .bind(await sha256Hex(token)).first();
  }

  /**
   * Records what Google said about a purchase this account sent. Bought: the account has it (and Plus Family makes the
   * buyer a family of their own, leaving one they were in). Refunded: it no longer counts, and a family it paid for ends.
   * A purchase another account holds is left with that account. A purchase Google has voided never counts again, whatever
   * a later check says (`voided_purchases`).
   */
  async recordPurchase(accountId: string, product: string, token: string, check: PlayCheck): Promise<"added" | "in_use" | "not_bought"> {
    const hash = await sha256Hex(token);
    const holder = await this.purchaseHolder(token);
    if (holder && holder.account_id !== accountId) return "in_use";
    const now = this.now();
    if (check.state === "purchased" && !(await this.isVoided(hash))) {
      await this.db.prepare(
        "INSERT INTO purchases (token_hash, token, account_id, store, product, order_id, active, test, checked_at) VALUES (?, ?, ?, 'google', ?, ?, 1, ?, ?) "
        + "ON CONFLICT (token_hash) DO UPDATE SET active = 1, order_id = excluded.order_id, test = excluded.test, checked_at = excluded.checked_at WHERE purchases.account_id = excluded.account_id",
      ).bind(hash, token, accountId, product, check.orderId, check.test ? 1 : 0, now).run();
      if ((await this.paid(accountId)).family) await this.ownFamily(accountId);
      return "added";
    }
    if (holder && check.state === "cancelled") await this.markRefunded(hash, accountId, "check");
    return "not_bought";
  }

  /** Purchases on this account not checked with Google for a day: refunds reach the account without the app asking. */
  async stalePurchases(accountId: string): Promise<{ token: string; product: string }[]> {
    const rows = await this.db.prepare("SELECT token, product FROM purchases WHERE account_id = ? AND active = 1 AND checked_at < ?")
      .bind(accountId, this.now() - DAY_MS).all<{ token: string; product: string }>();
    return rows.results;
  }

  /**
   * The result of checking a purchase again: refunded or revoked (Google says cancelled) stops it; anything else only
   * notes the check. A purchase is never taken away because Google couldn't be asked or didn't recognise the token.
   */
  async recheck(accountId: string, token: string, check: PlayCheck) {
    const hash = await sha256Hex(token);
    if (check.state === "cancelled") await this.markRefunded(hash, accountId, "check");
    else await this.db.prepare("UPDATE purchases SET checked_at = ? WHERE token_hash = ?").bind(this.now(), hash).run();
  }

  /**
   * Google says this purchase was voided (refunded, revoked or charged back), through a Real-time developer notification
   * or the Voided Purchases API. It's remembered for good, and the account holding it, if any, loses what it paid for at
   * once (a family it paid for ends, exactly as on any refund). Safe to repeat. Returns whether an account held it.
   */
  async voidPurchase(token: string, source: VoidSource): Promise<boolean> {
    const hash = await sha256Hex(token);
    const holder = await this.db.prepare("SELECT account_id FROM purchases WHERE token_hash = ?").bind(hash).first<{ account_id: string }>();
    if (!holder) {
      await this.rememberVoid(hash, source).run();
      return false;
    }
    await this.markRefunded(hash, holder.account_id, source);
    return true;
  }

  /**
   * A page of voids at once (the Voided Purchases API, up to 1,000), within the free plan's 1,000 database calls a run:
   * which of them an account still holds is read 90 at a time, every one is remembered in one batch, and only the held
   * ones (few) are ended one by one, at most [maxHeld]. Safe to repeat: a held purchase ended here is no longer active,
   * so a run that stopped at [maxHeld] carries on where it left off. Returns how many it ended and whether that was all.
   */
  async voidMany(tokens: string[], source: VoidSource, maxHeld: number): Promise<{ held: number; done: boolean }> {
    const hashes = [...new Set(await Promise.all(tokens.map((t) => sha256Hex(t))))];
    const held: { token_hash: string; account_id: string }[] = [];
    for (let i = 0; i < hashes.length; i += 90) {
      const chunk = hashes.slice(i, i + 90);
      const rows = await this.db.prepare(`SELECT token_hash, account_id FROM purchases WHERE active = 1 AND token_hash IN (${chunk.map(() => "?").join(", ")})`)
        .bind(...chunk).all<{ token_hash: string; account_id: string }>();
      held.push(...rows.results);
    }
    const now = this.now();
    const inserts = [];
    for (let i = 0; i < hashes.length; i += 30) {
      const chunk = hashes.slice(i, i + 30);
      inserts.push(this.db.prepare(`INSERT INTO voided_purchases (token_hash, voided_at, source) VALUES ${chunk.map(() => "(?, ?, ?)").join(", ")} ON CONFLICT (token_hash) DO NOTHING`)
        .bind(...chunk.flatMap((h) => [h, now, source])));
    }
    if (inserts.length > 0) await this.db.batch(inserts);
    const ending = held.slice(0, maxHeld);
    for (const h of ending) await this.markRefunded(h.token_hash, h.account_id, source);
    return { held: ending.length, done: ending.length === held.length };
  }

  /** The account holding a purchase and its product, or null: what a one-time product's notification needs to check it. */
  async heldPurchase(token: string): Promise<{ accountId: string; product: string } | null> {
    const row = await this.purchaseHolder(token);
    return row ? { accountId: row.account_id, product: row.product } : null;
  }

  private async isVoided(hash: string): Promise<boolean> {
    return !!(await this.db.prepare("SELECT 1 AS x FROM voided_purchases WHERE token_hash = ?").bind(hash).first());
  }

  private rememberVoid(hash: string, source: VoidSource) {
    return this.db.prepare("INSERT INTO voided_purchases (token_hash, voided_at, source) VALUES (?, ?, ?) ON CONFLICT (token_hash) DO NOTHING")
      .bind(hash, this.now(), source);
  }

  /** A held purchase stops counting, for good: Google cancelled, refunded, revoked or charged it back. */
  private async markRefunded(hash: string, accountId: string, source: VoidSource) {
    await this.db.batch([
      this.rememberVoid(hash, source),
      this.db.prepare("UPDATE purchases SET active = 0, checked_at = ? WHERE token_hash = ? AND account_id = ?").bind(this.now(), hash, accountId),
    ]);
    if (!(await this.paid(accountId)).family) await this.endFamily(accountId);
  }

  // ---------------------------------------------------------------- Google Play's notifications, and the Worker's own state

  /** Whether this Pub/Sub message was handled already (Pub/Sub delivers at least once; Google: check `messageId`). */
  async notificationSeen(messageId: string): Promise<boolean> {
    return !!(await this.db.prepare("SELECT 1 AS x FROM play_notifications WHERE message_id = ?").bind(messageId).first());
  }

  /** Notes a Pub/Sub message as handled, once it fully is: one that failed is delivered again by Pub/Sub. */
  async notificationHandled(messageId: string) {
    await this.db.prepare("INSERT INTO play_notifications (message_id, received_at) VALUES (?, ?) ON CONFLICT (message_id) DO NOTHING")
      .bind(messageId, this.now()).run();
  }

  async state(key: string): Promise<string | null> {
    return (await this.db.prepare("SELECT value FROM worker_state WHERE key = ?").bind(key).first<{ value: string }>())?.value ?? null;
  }

  async setState(key: string, value: string) {
    await this.db.prepare("INSERT INTO worker_state (key, value) VALUES (?, ?) ON CONFLICT (key) DO UPDATE SET value = excluded.value").bind(key, value).run();
  }

  /** What this account's active purchases pay for (`paidFor`). */
  private async paid(accountId: string) {
    const rows = await this.db.prepare("SELECT product FROM purchases WHERE account_id = ? AND active = 1").bind(accountId).all<{ product: string }>();
    return paidFor(rows.results.map((r) => r.product));
  }

  private async ownFamily(accountId: string) {
    const owned = await this.db.prepare("SELECT id FROM families WHERE owner_id = ?").bind(accountId).first();
    if (owned) return;
    await this.db.batch([
      this.db.prepare("DELETE FROM members WHERE account_id = ?").bind(accountId),
      this.db.prepare("INSERT INTO families (id, owner_id, created_at) VALUES (?, ?, ?) ON CONFLICT (owner_id) DO NOTHING").bind(crypto.randomUUID(), accountId, this.now()),
    ]);
  }

  /**
   * The owner's family ends: everyone in it loses its Plus (they keep their accounts and habits); its invites stop and
   * read "cancelled". [forget]: the owner deleted their account, so the invites go too (they hold the owner's name), and
   * an old link then reads "This invite doesn't work".
   */
  private async endFamily(ownerId: string, forget = false) {
    const family = await this.db.prepare("SELECT id FROM families WHERE owner_id = ?").bind(ownerId).first<{ id: string }>();
    if (!family) return;
    await this.db.batch([
      forget
        ? this.db.prepare("DELETE FROM invites WHERE family_id = ?").bind(family.id)
        : this.db.prepare("UPDATE invites SET state = CASE state WHEN 'open' THEN 'cancelled' ELSE state END, family_id = NULL WHERE family_id = ?").bind(family.id),
      this.db.prepare("DELETE FROM families WHERE id = ?").bind(family.id), // members go with it (ON DELETE CASCADE)
    ]);
  }

  // ---------------------------------------------------------------- The family

  private async ownedFamily(accountId: string) {
    return this.db.prepare("SELECT f.id, a.name AS owner_name FROM families f JOIN accounts a ON a.id = f.owner_id WHERE f.owner_id = ?")
      .bind(accountId).first<{ id: string; owner_name: string }>();
  }

  private async memberCount(familyId: string): Promise<number> {
    return (await this.db.prepare("SELECT COUNT(*) AS n FROM members WHERE family_id = ?").bind(familyId).first<{ n: number }>())?.n ?? 0;
  }

  /** A new single-use invite while there's room; the waiting one again if there is one. */
  async invite(accountId: string) {
    const family = await this.ownedFamily(accountId);
    if (!family) return;
    const now = this.now();
    await this.db.prepare("UPDATE invites SET state = 'ended' WHERE family_id = ? AND state = 'open' AND ends_at < ?").bind(family.id, now).run();
    const open = await this.db.prepare("SELECT 1 AS x FROM invites WHERE family_id = ? AND state = 'open'").bind(family.id).first();
    if (open) return;
    if (1 + (await this.memberCount(family.id)) >= FAMILY_SIZE) return;
    try {
      await this.db.prepare("INSERT INTO invites (token, family_id, owner_name, created_at, ends_at, state) VALUES (?, ?, ?, ?, ?, 'open')")
        .bind(randomToken(16), family.id, family.owner_name, now, now + INVITE_MS).run();
    } catch (error) {
      // Two devices asked at once: the other one's invite is the one (one open invite per family).
      if (!String(error).includes("UNIQUE")) throw error;
    }
  }

  async cancelInvite(accountId: string) {
    const family = await this.ownedFamily(accountId);
    if (!family) return;
    await this.db.prepare("UPDATE invites SET state = 'cancelled' WHERE family_id = ? AND state = 'open'").bind(family.id).run();
  }

  /** The owner takes someone out: their Plus from the family stops; their account and habits stay. */
  async remove(accountId: string, personId: string) {
    const family = await this.ownedFamily(accountId);
    if (!family || personId === accountId) return;
    await this.db.prepare("DELETE FROM members WHERE account_id = ? AND family_id = ?").bind(personId, family.id).run();
  }

  async leave(accountId: string) {
    await this.db.prepare("DELETE FROM members WHERE account_id = ?").bind(accountId).run();
  }

  /** What an invite link says when it's opened (Figma 5.2–5.6). Null: not one of ours. */
  async lookInvite(token: string): Promise<InviteLook | null> {
    const invite = await this.db.prepare("SELECT family_id, owner_name, ends_at, state FROM invites WHERE token = ?")
      .bind(token).first<{ family_id: string | null; owner_name: string; ends_at: number; state: string }>();
    if (!invite) return null;
    const family = invite.family_id
      ? await this.db.prepare("SELECT f.id, a.name AS owner_name FROM families f JOIN accounts a ON a.id = f.owner_id WHERE f.id = ?")
        .bind(invite.family_id).first<{ id: string; owner_name: string }>()
      : null;
    const owner = family?.owner_name ?? invite.owner_name;
    if (!family || invite.state === "cancelled") return { state: "cancelled", owner };
    if (invite.state === "used") return { state: "used", owner };
    if (invite.state === "ended" || invite.ends_at < this.now()) return { state: "ended", owner };
    if (1 + (await this.memberCount(family.id)) >= FAMILY_SIZE) return { state: "full", owner };
    return { state: "open", owner };
  }

  /**
   * Joins the family an open invite is for: claims the invite and takes the place in one transaction, leaving a family
   * the person was in. Nothing happens for an invite that's ended, used, cancelled or full, for the owner's own family,
   * or for someone who owns a family (Figma 5.7: an owner keeps theirs). Joining twice keeps the first place.
   */
  async join(accountId: string, token: string) {
    const invite = await this.db.prepare("SELECT family_id, ends_at, state FROM invites WHERE token = ?")
      .bind(token).first<{ family_id: string | null; ends_at: number; state: string }>();
    if (!invite?.family_id) return;
    const now = this.now();
    const membership = await this.db.prepare("SELECT family_id FROM members WHERE account_id = ?").bind(accountId).first<{ family_id: string }>();
    if (membership?.family_id === invite.family_id) return;
    if (await this.ownedFamily(accountId)) return;
    if (invite.state !== "open" || invite.ends_at < now) return;
    if (1 + (await this.memberCount(invite.family_id)) >= FAMILY_SIZE) return;
    const claimed = "EXISTS (SELECT 1 FROM invites WHERE token = ? AND state = 'used' AND used_by = ?)";
    await this.db.batch([
      this.db.prepare("UPDATE invites SET state = 'used', used_by = ? WHERE token = ? AND state = 'open' AND ends_at >= ?").bind(accountId, token, now),
      this.db.prepare(`DELETE FROM members WHERE account_id = ? AND ${claimed}`).bind(accountId, token, accountId),
      this.db.prepare(`INSERT INTO members (account_id, family_id, joined_at) SELECT ?, ?, ? WHERE ${claimed}`).bind(accountId, invite.family_id, now, token, accountId),
    ]);
  }

  // ---------------------------------------------------------------- Deleting

  /**
   * Deletes the account: its sessions, its purchase records (the purchases stay with Google, so signing in again brings
   * Plus back), its place in a family, and a family it owns (everyone in it loses Plus; nobody loses habits).
   */
  async delete(accountId: string) {
    await this.endFamily(accountId, true);
    await this.db.batch([
      this.db.prepare("UPDATE invites SET used_by = NULL WHERE used_by = ?").bind(accountId),
      this.db.prepare("DELETE FROM accounts WHERE id = ?").bind(accountId), // sessions, purchases, members: ON DELETE CASCADE
    ]);
  }

  /**
   * Daily: what's no longer needed goes. Invites 30 days after they ended (used, cancelled or not: a link that old reads
   * "doesn't work"), ended invites of families that ended, sessions unused for 400 days, and handled Pub/Sub message IDs
   * after 30 days (Pub/Sub keeps a message for 7 at most). Voided purchases stay: a void is final.
   */
  async tidy(): Promise<{ invites: number; sessions: number }> {
    const now = this.now();
    const [invites, orphans, sessions] = await this.db.batch([
      this.db.prepare("DELETE FROM invites WHERE ends_at < ?").bind(now - 30 * DAY_MS),
      this.db.prepare("DELETE FROM invites WHERE family_id IS NULL AND ends_at < ?").bind(now),
      this.db.prepare("DELETE FROM sessions WHERE used_at < ?").bind(now - 400 * DAY_MS),
      this.db.prepare("DELETE FROM play_notifications WHERE received_at < ?").bind(now - 30 * DAY_MS),
    ]);
    return { invites: (invites?.meta.changes ?? 0) + (orphans?.meta.changes ?? 0), sessions: sessions?.meta.changes ?? 0 };
  }
}
