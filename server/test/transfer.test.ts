import { env, exports } from "cloudflare:workers";
import { describe, expect, it } from "vitest";
import { MAX_TRANSFER_BYTES, TRANSFER_LIFETIME_MS, pruneTransfers, putTransfer } from "../src/transfer";

/**
 * Move to Another Device through the server (src/transfer.ts): an encrypted file in, out once, then gone. The server
 * only ever sees an ID and ciphertext; the phones derive both from the code (tested in the app's TransferCheck).
 */

const BASE = "https://api-dev.oftenenough.com";
const newId = () => [...crypto.getRandomValues(new Uint8Array(32))].map((b) => b.toString(16).padStart(2, "0")).join("");
const sealed = (text = `sealed ${crypto.randomUUID()}`) => new TextEncoder().encode(text.padEnd(64, "."));

async function request(method: string, path: string, body?: Uint8Array, ip?: string) {
  const headers: Record<string, string> = {};
  if (ip) headers["cf-connecting-ip"] = ip;
  return exports.default.fetch(`${BASE}${path}`, { method, headers, body });
}

async function status(id: string) {
  return ((await (await request("GET", `/v1/transfer/${id}/status`)).json()) as { state: string }).state;
}

describe("Move to Another Device through the server", () => {
  it("the old phone's file comes out once, byte for byte, and is deleted the moment the new phone has it", async () => {
    const id = newId();
    const bytes = sealed();
    const put = await request("PUT", `/v1/transfer/${id}`, bytes);
    expect(put.status).toBe(201);
    expect(((await put.json()) as { expiresAt: number }).expiresAt).toBeGreaterThan(Date.now());
    expect(await status(id)).toBe("waiting");
    const got = await request("GET", `/v1/transfer/${id}`);
    expect(got.status).toBe(200);
    expect(new Uint8Array(await got.arrayBuffer())).toEqual(bytes);
    expect((await request("POST", `/v1/transfer/${id}/received`)).status).toBe(200);
    expect(await status(id)).toBe("received");
    expect((await env.BACKUPS.head(`transfer/${id}`))).toBeNull();
    const again = await request("GET", `/v1/transfer/${id}`);
    expect(again.status).toBe(404);
    expect(((await again.json()) as { error: string }).error).toBe("no_transfer");
  });

  it("a wrong code finds nothing, and says so the same way as an expired one", async () => {
    for (const id of [newId(), "not-hex", "ab".repeat(31)]) {
      const response = await request("GET", `/v1/transfer/${id}`);
      expect(response.status).toBe(404);
      expect(((await response.json()) as { error: string }).error).toBe("no_transfer");
    }
  });

  it("lasts an hour: an older file is refused and deleted", async () => {
    const id = newId();
    await putTransfer(new Request(`${BASE}/v1/transfer/${id}`, { method: "PUT", body: sealed() }), env, id, Date.now() - TRANSFER_LIFETIME_MS - 1000);
    expect(await status(id)).toBe("gone");
    expect((await request("GET", `/v1/transfer/${id}`)).status).toBe(404);
    expect(await env.BACKUPS.head(`transfer/${id}`)).toBeNull();
  });

  it("the old phone leaving its screen deletes the file", async () => {
    const id = newId();
    await request("PUT", `/v1/transfer/${id}`, sealed());
    expect((await request("DELETE", `/v1/transfer/${id}`)).status).toBe(200);
    expect(await status(id)).toBe("gone");
    expect((await request("GET", `/v1/transfer/${id}`)).status).toBe(404);
  });

  it("one file per code: a second upload to a live code is refused", async () => {
    const id = newId();
    expect((await request("PUT", `/v1/transfer/${id}`, sealed("first"))).status).toBe(201);
    const second = await request("PUT", `/v1/transfer/${id}`, sealed("second"));
    expect(second.status).toBe(409);
    expect(new TextDecoder().decode(await (await request("GET", `/v1/transfer/${id}`)).arrayBuffer())).toMatch(/^first/);
  });

  it("refuses an empty file and one over 25 MB", async () => {
    expect((await request("PUT", `/v1/transfer/${newId()}`, new Uint8Array(0))).status).toBe(400);
    expect((await request("PUT", `/v1/transfer/${newId()}`, new Uint8Array(MAX_TRANSFER_BYTES + 1))).status).toBe(413);
  });

  it("is limited per IP, so typing codes at random finds nothing", async () => {
    const ip = `192.0.2.${Math.floor(Math.random() * 250)}`;
    let last: Response | undefined;
    for (let i = 0; i < 80; i++) {
      last = await request("GET", `/v1/transfer/${newId()}`, undefined, ip);
      if (last.status === 429) break;
    }
    expect(last!.status).toBe(429);
  });

  it("the daily clean-up removes what's older than its hour and keeps the rest", async () => {
    const old = newId();
    const fresh = newId();
    await putTransfer(new Request(`${BASE}/v1/transfer/${old}`, { method: "PUT", body: sealed() }), env, old, Date.now() - 2 * TRANSFER_LIFETIME_MS);
    await request("PUT", `/v1/transfer/${fresh}`, sealed());
    await pruneTransfers(env);
    expect(await env.BACKUPS.head(`transfer/${old}`)).toBeNull();
    expect(await env.BACKUPS.head(`transfer/${fresh}`)).not.toBeNull();
  });
});
