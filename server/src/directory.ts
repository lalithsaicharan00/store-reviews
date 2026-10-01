import type { VerifiedKey } from "./providers";

/** The D1 directory: sign-in key → account (Architecture 06 §3). Nothing else about a person is stored here. */

export type Jurisdiction = "default" | "eu";

export interface AccountRef {
  accountId: string;
  jurisdiction: Jurisdiction;
}

export async function findAccount(db: D1Database, provider: string, subject: string): Promise<AccountRef | null> {
  const row = await db
    .prepare(
      `SELECT a.id AS accountId, a.jurisdiction AS jurisdiction FROM account_key k JOIN account a ON a.id = k.account_id
       WHERE k.provider = ? AND k.subject = ?`,
    )
    .bind(provider, subject)
    .first<AccountRef>();
  return row ?? null;
}

/**
 * Creates an account opened by `key`. If the same key is being used to create an account at the same moment
 * (a double tap, two devices), only one account is made and both get it.
 */
export async function createAccount(db: D1Database, key: VerifiedKey, jurisdiction: Jurisdiction, now = Date.now()): Promise<AccountRef> {
  const accountId = crypto.randomUUID();
  try {
    // A batch is one transaction: the account never exists without its key.
    await db.batch([
      db.prepare("INSERT INTO account (id, created_at, jurisdiction) VALUES (?, ?, ?)").bind(accountId, now, jurisdiction),
      db.prepare("INSERT INTO account_key (provider, subject, account_id, created_at) VALUES (?, ?, ?, ?)").bind(key.provider, key.subject, accountId, now),
    ]);
    return { accountId, jurisdiction };
  } catch (error) {
    const existing = await findAccount(db, key.provider, key.subject);
    if (existing) return existing;
    throw error;
  }
}

export type LinkResult = "linked" | "already_linked" | "used_by_another_account" | "provider_already_linked";

/** Adds a second way to sign in. One key per provider per account, and a key can only ever open one account. */
export async function linkKey(db: D1Database, accountId: string, key: VerifiedKey, now = Date.now()): Promise<LinkResult> {
  const owner = await findAccount(db, key.provider, key.subject);
  if (owner) return owner.accountId === accountId ? "already_linked" : "used_by_another_account";
  const sameProvider = await db
    .prepare("SELECT 1 FROM account_key WHERE account_id = ? AND provider = ?")
    .bind(accountId, key.provider)
    .first();
  if (sameProvider) return "provider_already_linked";
  try {
    await db
      .prepare("INSERT INTO account_key (provider, subject, account_id, created_at) VALUES (?, ?, ?, ?)")
      .bind(key.provider, key.subject, accountId, now)
      .run();
    return "linked";
  } catch {
    const raced = await findAccount(db, key.provider, key.subject);
    return raced?.accountId === accountId ? "already_linked" : "used_by_another_account";
  }
}

export type UnlinkResult = { removed: true; subject: string } | { removed: false; reason: "last_key" | "not_linked" };

/** Removes a way to sign in. The last one can never be removed, or the account could never be opened again. */
export async function unlinkKey(db: D1Database, accountId: string, provider: string): Promise<UnlinkResult> {
  const key = await db
    .prepare("SELECT subject FROM account_key WHERE account_id = ? AND provider = ?")
    .bind(accountId, provider)
    .first<{ subject: string }>();
  if (!key) return { removed: false, reason: "not_linked" };
  // One statement, so two removals at once can't both pass the "more than one key" check.
  const result = await db
    .prepare(
      `DELETE FROM account_key WHERE account_id = ?1 AND provider = ?2
       AND (SELECT count(*) FROM account_key WHERE account_id = ?1) > 1`,
    )
    .bind(accountId, provider)
    .run();
  return result.meta.changes === 1 ? { removed: true, subject: key.subject } : { removed: false, reason: "last_key" };
}

export async function jurisdictionOf(db: D1Database, accountId: string): Promise<Jurisdiction | null> {
  const row = await db.prepare("SELECT jurisdiction FROM account WHERE id = ?").bind(accountId).first<{ jurisdiction: Jurisdiction }>();
  return row?.jurisdiction ?? null;
}

/** Removes the account from the directory, so no key can open it again. Safe to repeat. */
export async function deleteAccount(db: D1Database, accountId: string): Promise<void> {
  await db.batch([
    db.prepare("DELETE FROM account_key WHERE account_id = ?").bind(accountId),
    db.prepare("DELETE FROM account WHERE id = ?").bind(accountId),
  ]);
}

/** EU and EEA storefronts keep their data in the EU (Architecture 09). Accepts ISO 3166 alpha-2 or alpha-3 codes. */
const EEA = new Set([
  "AT", "AUT", "BE", "BEL", "BG", "BGR", "HR", "HRV", "CY", "CYP", "CZ", "CZE", "DK", "DNK", "EE", "EST", "FI", "FIN",
  "FR", "FRA", "DE", "DEU", "GR", "GRC", "HU", "HUN", "IE", "IRL", "IT", "ITA", "LV", "LVA", "LT", "LTU", "LU", "LUX",
  "MT", "MLT", "NL", "NLD", "PL", "POL", "PT", "PRT", "RO", "ROU", "SK", "SVK", "SI", "SVN", "ES", "ESP", "SE", "SWE",
  "IS", "ISL", "LI", "LIE", "NO", "NOR",
]);

export function jurisdictionFor(country: unknown): Jurisdiction {
  return typeof country === "string" && EEA.has(country.toUpperCase()) ? "eu" : "default";
}
