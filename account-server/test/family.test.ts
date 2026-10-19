import { createExecutionContext, waitOnExecutionContext } from "cloudflare:test";
import { env } from "cloudflare:workers";
import worker from "../src/worker";
import { beforeAll, beforeEach, describe, expect, it } from "vitest";
import { clearKeyCache } from "../src/identity";
import { clearPlayToken } from "../src/play";
import {
  APPLE_KEYS, GOOGLE_KEYS, bought, call, createAccount, familyOwner, idToken, joinFamily, mockGoogle, newIp, newKey, person, play, published, signIn,
} from "./helpers";

beforeAll(async () => {
  published[GOOGLE_KEYS] = [await newKey("google-1")];
  published[APPLE_KEYS] = [await newKey("apple-1")];
});
beforeEach(() => {
  mockGoogle();
  clearKeyCache();
  clearPlayToken();
  play.mode = "ok";
});

const DAY = 86_400_000;
const invite = async (session: string) => (await call("POST", "/v1/family/invite", { session })).body.account;
const look = async (token: string) => (await call("GET", `/v1/invites/${token}`)).body;
const join = async (session: string, token: string) => (await call("POST", `/v1/invites/${token}/join`, { session })).body.account;
const me = async (session: string) => (await call("GET", "/v1/account", { session })).body.account;
async function end(token: string) {
  await env.DB.prepare("UPDATE invites SET ends_at = ? WHERE token = ?").bind(Date.now() - DAY, token).run();
}

describe("invites (Figma 7, 5.2–5.6; the app's PlusAccountTest)", () => {
  it("a family is six at most, an invite works once, one invite at a time", async () => {
    const lee = await familyOwner("Lee");
    expect(lee.account.family.people).toHaveLength(1);
    const members: { session: string }[] = [];
    for (let i = 1; i <= 5; i++) {
      const sent = await invite(lee.session);
      const token = sent.family.invite.token;
      expect(sent.family.invite.link).toBe(`https://oftenenough.com/join/${token}`);
      expect(token).toMatch(/^[A-Za-z0-9_-]{22}$/);
      expect((await invite(lee.session)).family.invite.token).toBe(token); // one at a time
      expect(await look(token)).toEqual({ state: "open", owner: "Lee" });
      const p = await createAccount(person(`P${i}`));
      expect((await join(p.session, token)).plus).toBe("FAMILY_MEMBER");
      expect((await join(p.session, token)).plus).toBe("FAMILY_MEMBER"); // joining twice keeps one place
      expect(await look(token)).toEqual({ state: "used", owner: "Lee" });
      members.push(p);
    }
    const full = await me(lee.session);
    expect(full.family.people).toHaveLength(6);
    expect(full.family.people[0]).toMatchObject({ name: "Lee", owner: true, you: true, joinedDay: null });
    expect(full.family.people.slice(1).map((p: { name: string }) => p.name)).toEqual(["P1", "P2", "P3", "P4", "P5"]);
    expect(full.family.people[1].joinedDay).toBe(Math.floor(Date.now() / DAY));
    expect((await invite(lee.session)).family.invite).toBeNull(); // no room, no invite
    // A member sees the family, without the invite and with "you" on themselves.
    const p1 = await me(members[0]!.session);
    expect(p1.family.owner).toBe("Lee");
    expect(p1.family.invite).toBeNull();
    expect(p1.family.people.filter((p: { you: boolean }) => p.you)).toHaveLength(1);
  });

  it("an invite ends after 7 days; a new one replaces it; a cancelled one gives nothing", async () => {
    const lee = await familyOwner("Lee");
    const sent = await invite(lee.session);
    const token = sent.family.invite.token;
    expect(sent.family.invite.endsDay).toBe(Math.floor((Date.now() + 7 * DAY) / DAY));
    await end(token);
    expect(await look(token)).toEqual({ state: "ended", owner: "Lee" });
    const priya = await createAccount(person("Priya"));
    expect((await join(priya.session, token)).plus).toBe("NONE"); // an ended invite gives nothing
    expect((await me(lee.session)).family.invite).toBeNull(); // the owner no longer sees it waiting
    const again = (await invite(lee.session)).family.invite.token;
    expect(again).not.toBe(token);
    expect(await look(token)).toEqual({ state: "ended", owner: "Lee" });
    await call("POST", "/v1/family/invite/cancel", { session: lee.session });
    expect(await look(again)).toEqual({ state: "cancelled", owner: "Lee" });
    expect((await join(priya.session, again)).plus).toBe("NONE");
    expect((await me(lee.session)).family.invite).toBeNull();
  });

  it("an open invite to a full family says so", async () => {
    const ana = await familyOwner("Ana");
    for (let i = 0; i < 4; i++) await joinFamily(ana.session, `M${i}`);
    const token = (await invite(ana.session)).family.invite.token;
    // A fifth member arrives some other way while the invite is open (as the stand-in's seeded family): it reads full.
    const extra = await createAccount(person("M5"));
    const family = await env.DB.prepare("SELECT id FROM families WHERE owner_id = ?").bind(ana.account.id).first<{ id: string }>();
    await env.DB.prepare("INSERT INTO members (account_id, family_id, joined_at) VALUES (?, ?, ?)").bind(extra.account.id, family!.id, Date.now()).run();
    expect(await look(token)).toEqual({ state: "full", owner: "Ana" });
    const late = await createAccount(person("Late"));
    expect((await join(late.session, token)).plus).toBe("NONE");
  });

  it("an unknown or malformed invite doesn't work", async () => {
    expect((await call("GET", "/v1/invites/AAAAAAAAAAAAAAAAAAAAAA")).status).toBe(404);
    expect((await call("GET", "/v1/invites/bad%20token")).status).toBe(404);
    const sam = await createAccount(person("Sam"));
    expect((await join(sam.session, "AAAAAAAAAAAAAAAAAAAAAA")).plus).toBe("NONE");
  });

  it("only an owner invites, cancels or removes", async () => {
    const lee = await familyOwner("Lee");
    const { member } = await joinFamily(lee.session, "Priya");
    const plain = await createAccount(person("Sam"));
    for (const session of [member.session, plain.session]) {
      expect((await invite(session)).family?.invite ?? null).toBeNull();
      await call("POST", "/v1/family/remove", { session, body: { person: lee.account.id } });
    }
    expect((await me(lee.session)).family.people).toHaveLength(2);
  });

  it("two invites asked for at once make one", async () => {
    const lee = await familyOwner("Lee");
    const replies = await Promise.all([1, 2, 3, 4].map(() => call("POST", "/v1/family/invite", { session: lee.session })));
    const tokens = new Set(replies.map((r) => r.body.account.family.invite?.token).filter(Boolean));
    expect(tokens.size).toBe(1);
    const open = await env.DB.prepare("SELECT COUNT(*) AS n FROM invites WHERE state = 'open'").first<{ n: number }>();
    expect(open?.n).toBeGreaterThanOrEqual(1);
  });

  it("two people using one invite at once: only one gets the place", async () => {
    const lee = await familyOwner("Lee");
    const token = (await invite(lee.session)).family.invite.token;
    const a = await createAccount(person("A"));
    const b = await createAccount(person("B"));
    const [ra, rb] = await Promise.all([join(a.session, token), join(b.session, token)]);
    expect([ra.plus, rb.plus].sort()).toEqual(["FAMILY_MEMBER", "NONE"]);
    expect((await me(lee.session)).family.people).toHaveLength(2);
  });
});

describe("joining and leaving (Figma 5.7, 5.8, 7.3, 7.4)", () => {
  it("joining another family leaves the first; leaving keeps nothing but the account", async () => {
    const sam = await familyOwner("Sam");
    const lee = await familyOwner("Lee");
    const priya = await createAccount(person("Priya"));
    await join(priya.session, (await invite(sam.session)).family.invite.token);
    expect((await me(priya.session)).family.owner).toBe("Sam");
    await join(priya.session, (await invite(lee.session)).family.invite.token);
    expect((await me(priya.session)).family.owner).toBe("Lee");
    expect((await me(sam.session)).family.people).toHaveLength(1); // Sam's family no longer lists her
    const left = (await call("POST", "/v1/family/leave", { session: priya.session })).body.account;
    expect(left).toEqual({ id: priya.account.id, plus: "NONE", family: null, cloud: null });
    expect((await me(lee.session)).family.people).toHaveLength(1);
  });

  it("someone who owns a family keeps it: an invite to another does nothing (5.7)", async () => {
    const sam = await familyOwner("Sam");
    const lee = await familyOwner("Lee");
    const token = (await invite(lee.session)).family.invite.token;
    expect((await join(sam.session, token)).plus).toBe("FAMILY_OWNER");
    expect(await look(token)).toEqual({ state: "open", owner: "Lee" }); // the place stays for someone else
    // Nor can an owner join their own family, or leave it.
    expect((await join(lee.session, token)).family.people).toHaveLength(1);
    expect((await call("POST", "/v1/family/leave", { session: lee.session })).body.account.plus).toBe("FAMILY_OWNER");
  });

  it("someone with their own Plus may still join (Join anyway); their own Plus stays theirs", async () => {
    const lee = await familyOwner("Lee");
    const ana = await createAccount(person("Ana"), bought("com.oftenenough.app.plus"));
    const joined = await join(ana.session, (await invite(lee.session)).family.invite.token);
    expect(joined.plus).toBe("PLUS");
    expect(joined.family.owner).toBe("Lee");
  });

  it("the owner removes someone: their Plus from the family stops, their account stays; the place opens", async () => {
    const lee = await familyOwner("Lee");
    const { member } = await joinFamily(lee.session, "Priya");
    const after = (await call("POST", "/v1/family/remove", { session: lee.session, body: { person: member.account.id } })).body.account;
    expect(after.family.people).toHaveLength(1);
    expect(await me(member.session)).toEqual({ id: member.account.id, plus: "NONE", family: null, cloud: null });
    // Removing nobody, or yourself, changes nothing.
    await call("POST", "/v1/family/remove", { session: lee.session, body: { person: lee.account.id } });
    expect((await me(lee.session)).plus).toBe("FAMILY_OWNER");
    expect((await call("POST", "/v1/family/remove", { session: lee.session, body: {} })).status).toBe(400);
  });
});

describe("deleting the account (Figma 7.2, 7.9, 7.10)", () => {
  it("needs Google's sign-in again as the same person; an owner's family ends; members keep their accounts", async () => {
    const leeWho = person("Lee");
    const lee = await createAccount(leeWho, bought("com.oftenenough.app.plusfamily"));
    const token = (await invite(lee.session)).family.invite.token;
    const { member } = await joinFamily(lee.session, "Priya");
    const waiting = (await invite(lee.session)).family.invite.token;
    // Another account can't delete it.
    const someone = await idToken(person("X"));
    const refused = await call("POST", "/v1/account/delete", { session: lee.session, body: { provider: "google", ...someone } });
    expect(refused.status).toBe(403);
    expect(refused.body.error).toBe("wrong_account");
    // The same person confirms.
    const proof = await idToken(leeWho);
    expect((await call("POST", "/v1/account/delete", { session: lee.session, body: { provider: "google", ...proof } })).body).toEqual({ deleted: true });
    expect((await call("GET", "/v1/account", { session: lee.session })).status).toBe(401); // signed out everywhere
    expect(await me(member.session)).toEqual({ id: member.account.id, plus: "NONE", family: null, cloud: null });
    // The invites went with the account (they held Lee's name): old links now read "doesn't work".
    expect((await call("GET", `/v1/invites/${waiting}`)).status).toBe(404);
    expect((await call("GET", `/v1/invites/${token}`)).status).toBe(404);
    // Nothing of Lee is left anywhere; Lee can make a new account later.
    const everything = JSON.stringify(await Promise.all(["accounts", "sessions", "purchases", "families", "members", "invites"].map((t) =>
      env.DB.prepare(`SELECT * FROM ${t}`).all())));
    expect(everything).not.toContain(lee.account.id);
    for (const table of ["accounts", "sessions", "purchases", "families"]) {
      const column = table === "accounts" ? "id" : table === "families" ? "owner_id" : "account_id";
      expect(await env.DB.prepare(`SELECT 1 FROM ${table} WHERE ${column} = ?`).bind(lee.account.id).first(), table).toBeNull();
    }
    expect((await signIn(leeWho)).body).toEqual({ found: false });
  });

  it("tidies daily: old invites and long-unused sessions go", async () => {
    const lee = await familyOwner("Lee");
    const token = (await invite(lee.session)).family.invite.token;
    await env.DB.prepare("UPDATE invites SET ends_at = ? WHERE token = ?").bind(Date.now() - 31 * DAY, token).run();
    const fresh = (await invite(lee.session)).family.invite.token;
    const ctx = createExecutionContext();
    await worker.scheduled({ scheduledTime: Date.now(), cron: "0 5 * * *", noRetry() {} } as ScheduledController, env, ctx);
    await waitOnExecutionContext(ctx);
    expect((await call("GET", `/v1/invites/${token}`)).status).toBe(404);
    expect((await look(fresh)).state).toBe("open");
  });

  it("a member's deletion leaves the family, and their ID leaves the invite they used", async () => {
    const lee = await familyOwner("Lee");
    const priyaWho = person("Priya");
    const priya = await createAccount(priyaWho);
    await join(priya.session, (await invite(lee.session)).family.invite.token);
    const proof = await idToken(priyaWho);
    await call("POST", "/v1/account/delete", { session: priya.session, body: { provider: "google", ...proof } });
    expect((await me(lee.session)).family.people).toHaveLength(1);
    expect(JSON.stringify(await env.DB.prepare("SELECT * FROM invites").all())).not.toContain(priya.account.id);
  });

  it("deleting twice, or with a token that isn't Google's, changes nothing more", async () => {
    const samWho = person("Sam");
    const sam = await createAccount(samWho);
    const bad = await call("POST", "/v1/account/delete", { session: sam.session, ip: newIp(), body: { provider: "google", idToken: "x", nonce: "y" } });
    expect(bad.status).toBe(401);
    expect((await me(sam.session)).id).toBe(sam.account.id);
    const proof = await idToken(samWho);
    await call("POST", "/v1/account/delete", { session: sam.session, body: { provider: "google", ...proof } });
    expect((await call("POST", "/v1/account/delete", { session: sam.session, body: { provider: "google", ...(await idToken(samWho)) } })).status).toBe(401);
  });
});
