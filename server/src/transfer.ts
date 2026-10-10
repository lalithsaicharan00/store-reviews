import { HttpError, json } from "./http";

/**
 * Move to Another Device through the server (the user, 10 Oct 2026: "it should be server based … like WhatsApp",
 * mainly for people without an account). The old phone shows a code; the new phone types it; the data goes through
 * here, so the two phones can be anywhere, on any network, iPhone or Android.
 *
 * **The server never sees the data or the code.** Both phones stretch the code (PBKDF2-SHA256, 100,000 rounds, 64
 * bytes): the first 32 bytes are the AES-256-GCM key the old phone encrypts the file with, and the SHA-256 of the last
 * 32 is the transfer's ID, the only thing the server is given. Knowing the ID doesn't give the key, and finding the
 * code from either costs 100,000 rounds per guess. (Architecture 04, "Moving through the server".)
 *
 * - `PUT /v1/transfer/<id>`: the old phone's encrypted file (at most 25 MB). One at a time per ID.
 * - `GET /v1/transfer/<id>`: the new phone fetches it. 404 `no_transfer` when the code is wrong or has expired.
 * - `POST /v1/transfer/<id>/received`: the new phone has it, decrypted and checked: the file is deleted at once.
 * - `GET /v1/transfer/<id>/status`: the old phone asks whether it has arrived (`waiting`, `received`, `gone`).
 * - `DELETE /v1/transfer/<id>`: the old phone closed its screen: the file goes.
 *
 * A transfer lasts an hour at most (`TRANSFER_LIFETIME_MS`; older ones are refused and deleted by the daily cron),
 * and every route is limited per IP (`TRANSFER_LIMIT`), so typing codes at random finds nothing. No account needed;
 * the files go to the default backup bucket under `transfer/` (they're end-to-end encrypted and live minutes).
 * Cost: one upload and one download per move (R2 class A + B), well inside the plan's included amounts.
 */

export const MAX_TRANSFER_BYTES = 25 * 1024 * 1024;
export const TRANSFER_LIFETIME_MS = 60 * 60 * 1000;
const PREFIX = "transfer/";

function idOf(raw: string): string {
  const id = raw.toLowerCase();
  if (!/^[0-9a-f]{64}$/.test(id)) throw new HttpError(404, "no_transfer", "That code doesn't match.");
  return id;
}

const fileKey = (id: string) => `${PREFIX}${id}`;
const receivedKey = (id: string) => `${PREFIX}${id}.received`;

function expired(object: R2Object, now: number): boolean {
  const created = Number(object.customMetadata?.createdAt ?? "0") || object.uploaded.getTime();
  return now - created > TRANSFER_LIFETIME_MS;
}

/** `PUT /v1/transfer/<id>`: the body is the encrypted file. */
export async function putTransfer(request: Request, env: Env, rawId: string, now = Date.now()): Promise<Response> {
  const id = idOf(rawId);
  if (Number(request.headers.get("content-length") ?? "0") > MAX_TRANSFER_BYTES) throw tooLarge();
  const body = await request.arrayBuffer();
  if (body.byteLength > MAX_TRANSFER_BYTES) throw tooLarge();
  if (body.byteLength < 28) throw new HttpError(400, "bad_request", "The transfer is empty.");
  const existing = await env.BACKUPS.head(fileKey(id));
  if (existing && !expired(existing, now)) throw new HttpError(409, "transfer_exists", "This code is already in use. Show a new code.");
  await env.BACKUPS.delete(receivedKey(id));
  await env.BACKUPS.put(fileKey(id), body, {
    httpMetadata: { contentType: "application/octet-stream" },
    customMetadata: { createdAt: String(now) },
  });
  console.log(JSON.stringify({ event: "transfer_put", size: body.byteLength }));
  return json({ expiresAt: now + TRANSFER_LIFETIME_MS }, 201);
}

/** `GET /v1/transfer/<id>`: the encrypted file, if it's here and not expired. */
export async function getTransfer(env: Env, rawId: string, now = Date.now()): Promise<Response> {
  const id = idOf(rawId);
  const object = await env.BACKUPS.get(fileKey(id));
  if (!object || expired(object, now)) {
    if (object) await env.BACKUPS.delete(fileKey(id));
    throw new HttpError(404, "no_transfer", "That code doesn't match.");
  }
  return new Response(object.body, {
    headers: { "content-type": "application/octet-stream", "content-length": String(object.size), "cache-control": "no-store" },
  });
}

/** `POST /v1/transfer/<id>/received`: deletes the file and leaves a mark the old phone sees as "Sent". */
export async function receivedTransfer(env: Env, rawId: string, now = Date.now()): Promise<Response> {
  const id = idOf(rawId);
  const object = await env.BACKUPS.head(fileKey(id));
  if (!object) throw new HttpError(404, "no_transfer", "That code doesn't match.");
  await env.BACKUPS.put(receivedKey(id), new Uint8Array(0), { customMetadata: { createdAt: String(now) } });
  await env.BACKUPS.delete(fileKey(id));
  console.log(JSON.stringify({ event: "transfer_received", size: object.size }));
  return json({ received: true });
}

/** `GET /v1/transfer/<id>/status`: `waiting` (not fetched yet), `received`, or `gone` (expired or cancelled). */
export async function transferStatus(env: Env, rawId: string, now = Date.now()): Promise<Response> {
  const id = idOf(rawId);
  const received = await env.BACKUPS.head(receivedKey(id));
  if (received) return json({ state: "received" });
  const object = await env.BACKUPS.head(fileKey(id));
  return json({ state: object && !expired(object, now) ? "waiting" : "gone" });
}

/** `DELETE /v1/transfer/<id>`: the old phone left its screen. Safe to repeat. */
export async function cancelTransfer(env: Env, rawId: string): Promise<Response> {
  const id = idOf(rawId);
  await env.BACKUPS.delete([fileKey(id), receivedKey(id)]);
  return json({ cancelled: true });
}

/** The daily cron: anything older than its hour goes (cancelled screens that never said so, unfetched files). */
export async function pruneTransfers(env: Env, now = Date.now()): Promise<number> {
  let cursor: string | undefined;
  let deleted = 0;
  do {
    const page = await env.BACKUPS.list({ prefix: PREFIX, cursor, include: ["customMetadata"] });
    const old = page.objects.filter((o) => expired(o, now)).map((o) => o.key);
    if (old.length > 0) await env.BACKUPS.delete(old);
    deleted += old.length;
    cursor = page.truncated ? page.cursor : undefined;
  } while (cursor);
  return deleted;
}

function tooLarge() {
  return new HttpError(413, "too_large", `A transfer can be at most ${MAX_TRANSFER_BYTES / 1024 / 1024} MB.`);
}
