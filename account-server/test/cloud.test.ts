import { env } from "cloudflare:workers";
import { beforeAll, beforeEach, describe, expect, it } from "vitest";
import { googleDriveKey } from "../src/accounts";
import { clearKeyCache } from "../src/identity";
import { APPLE_KEYS, GOOGLE_KEYS, call, createAccount, familyOwner, joinFamily, mockGoogle, newKey, person, published, signIn } from "./helpers";

beforeAll(async () => {
  published[GOOGLE_KEYS] = [await newKey("google-1")];
  published[APPLE_KEYS] = [await newKey("apple-1")];
});
beforeEach(() => {
  mockGoogle();
  clearKeyCache();
});

/** Where the habits live (Rulebook D16, Current Work 138): a cloud, its private ID, the device and when; never an email. */
describe("where the habits live", () => {
  it("is nothing until a device says, then every device signing in is told", async () => {
    const sam = person("Sam");
    const made = await createAccount(sam);
    expect(made.account.cloud).toBeNull();

    const key = await googleDriveKey(sam.subject);
    const saved = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "google_drive", key, device: "android" } });
    expect(saved.status).toBe(200);
    expect(saved.body.account.cloud).toEqual({ kind: "google_drive", key, device: "android", syncedAt: expect.any(Number), signInAccount: true });

    // A new phone: signing in brings the record with Plus.
    const again = await signIn(sam);
    expect(again.body.account.cloud.kind).toBe("google_drive");
    expect(again.body.account.cloud.signInAccount).toBe(true);
  });

  it("says when the habits are in a different Google account, without naming it", async () => {
    const sam = person("Sam");
    const made = await createAccount(sam);
    const other = await googleDriveKey("someone-else's-google-id");
    const saved = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "google_drive", key: other, device: "android" } });
    expect(saved.body.account.cloud).toMatchObject({ kind: "google_drive", key: other, signInAccount: false });
    expect(JSON.stringify(saved.body)).not.toContain("@");
  });

  it("an Apple sign-in is never the Google Drive's own account; iCloud is from an iPhone or iPad", async () => {
    const ana = person("Ana", "apple");
    const made = await createAccount(ana);
    const drive = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "google_drive", key: await googleDriveKey(ana.subject), device: "android" } });
    expect(drive.body.account.cloud.signInAccount).toBe(false);
    const icloud = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "icloud", key: "icloud:_0f3c9a1b2c3d4e5f60718293a4b5c6d7", device: "iphone" } });
    expect(icloud.body.account.cloud).toMatchObject({ kind: "icloud", device: "iphone", signInAccount: false });
  });

  it("the latest device wins, and null forgets it (the habits there were deleted)", async () => {
    const sam = person("Sam");
    const made = await createAccount(sam);
    const first = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "icloud", key: "icloud:_abc", device: "ipad" } });
    const second = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "google_drive", key: await googleDriveKey(sam.subject), device: "android" } });
    expect(second.body.account.cloud.kind).toBe("google_drive");
    expect(second.body.account.cloud.syncedAt).toBeGreaterThanOrEqual(first.body.account.cloud.syncedAt);
    // Repeating is harmless.
    const repeat = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "google_drive", key: await googleDriveKey(sam.subject), device: "android" } });
    expect(repeat.body.account.cloud.kind).toBe("google_drive");
    const cleared = await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: null } });
    expect(cleared.body.account.cloud).toBeNull();
    expect((await call("GET", "/v1/account", { session: made.session })).body.account.cloud).toBeNull();
  });

  it("refuses anything that isn't a cloud's own key, and needs a session", async () => {
    const made = await createAccount(person("Sam"));
    const tries = [
      { cloud: "dropbox", key: "gdrive:abc", device: "android" },
      { cloud: "google_drive", key: "icloud:abc", device: "android" },
      { cloud: "icloud", key: "gdrive:abc", device: "iphone" },
      { cloud: "google_drive", key: "gdrive:sam@gmail.com", device: "android" },
      { cloud: "google_drive", key: "gdrive:" + "a".repeat(200), device: "android" },
      { cloud: "google_drive", key: "gdrive:abc", device: "windows" },
      { cloud: "google_drive", device: "android" },
      {},
    ];
    for (const body of tries) {
      const r = await call("POST", "/v1/account/cloud", { session: made.session, body });
      expect(r.status, JSON.stringify(body)).toBe(400);
    }
    expect((await call("GET", "/v1/account", { session: made.session })).body.account.cloud).toBeNull();
    expect((await call("POST", "/v1/account/cloud", { body: { cloud: null } })).status).toBe(401);
  });

  it("only the account's own devices see it: never a family member, and it goes with the account", async () => {
    const owner = await familyOwner("Lee");
    await call("POST", "/v1/account/cloud", { session: owner.session, body: { cloud: "icloud", key: "icloud:_lee", device: "iphone" } });
    const { member } = await joinFamily(owner.session, "Priya");
    expect(member.account.cloud).toBeNull();
    expect(JSON.stringify(member.account)).not.toContain("icloud:_lee");
    const ownerView = (await call("GET", "/v1/account", { session: owner.session })).body.account;
    expect(ownerView.cloud.key).toBe("icloud:_lee");
    expect(JSON.stringify(ownerView.family)).not.toContain("icloud");

    // Deleting the account deletes the record with it (D16: Delete my account).
    const lee = await env.DB.prepare("SELECT provider, subject FROM accounts WHERE id = ?").bind(owner.account.id).first<{ provider: string; subject: string }>();
    expect(lee).not.toBeNull();
    await env.DB.prepare("DELETE FROM accounts WHERE id = ?").bind(owner.account.id).run();
    const left = await env.DB.prepare("SELECT COUNT(*) AS n FROM accounts WHERE cloud_key = 'icloud:_lee'").first<{ n: number }>();
    expect(left?.n).toBe(0);
  });

  it("keeps no email anywhere, whatever the devices send", async () => {
    const sam = { ...person("Sam"), email: "sam.cloud.example@gmail.com" };
    const made = await createAccount(sam);
    await call("POST", "/v1/account/cloud", { session: made.session, body: { cloud: "google_drive", key: await googleDriveKey(sam.subject), device: "android" } });
    const row = await env.DB.prepare("SELECT * FROM accounts WHERE id = ?").bind(made.account.id).first<Record<string, unknown>>();
    expect(JSON.stringify(row)).not.toContain("sam.cloud.example");
    expect(row?.cloud_key).toMatch(/^gdrive:[0-9a-f]{64}$/);
  });
});
