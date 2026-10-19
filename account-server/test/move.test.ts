import { exports } from "cloudflare:workers";
import { describe, expect, it } from "vitest";
import { CLOSE } from "../src/move";
import * as entry from "../src/worker";
import { call, newIp } from "./helpers";

/**
 * Moving to a new phone (src/move.ts, Rulebook D15): the relay passes two phones' messages and enforces one guess per
 * code. The phones' own SPAKE2 is tested in the Android app (Spake2Test); here the messages are opaque.
 */

interface Socket { ws: WebSocket; messages: (string | Uint8Array)[]; closed: Promise<{ code: number; reason: string }> }

async function open(path: string, ip = newIp(), token?: string): Promise<{ status: number; socket?: Socket; body?: any }> {
  const headers: Record<string, string> = { upgrade: "websocket", "cf-connecting-ip": ip };
  if (token) headers.authorization = `Bearer ${token}`;
  const response = await exports.default.fetch(new Request(`https://api.test${path}`, { headers }));
  if (response.status !== 101 || !response.webSocket) return { status: response.status, body: await response.json() };
  const ws = response.webSocket;
  const messages: (string | Uint8Array)[] = [];
  const closed = new Promise<{ code: number; reason: string }>((resolve) => ws.addEventListener("close", (e) => resolve({ code: e.code, reason: e.reason })));
  // A binary frame arrives as a Blob here (the socket's default): kept as its bytes, in order.
  let last = Promise.resolve();
  ws.addEventListener("message", (e) => {
    const data = e.data as string | Blob | ArrayBuffer;
    last = last.then(async () => { messages.push(typeof data === "string" ? data : new Uint8Array(data instanceof Blob ? await data.arrayBuffer() : data)); });
  });
  ws.accept();
  return { status: 101, socket: { ws, messages, closed } };
}

async function until(check: () => boolean, what: string) {
  for (let i = 0; i < 200; i++) {
    if (check()) return;
    await new Promise((r) => setTimeout(r, 10));
  }
  throw new Error(`waited for ${what}`);
}

async function newCode() {
  const reply = await call("POST", "/v1/move/codes");
  expect(reply.status).toBe(200);
  return reply.body as { channel: string; move: string; token: string; expiresIn: number };
}

async function sender(code: { move: string; token: string }) {
  const opened = await open(`/v1/move/send?move=${code.move}`, newIp(), code.token);
  expect(opened.status).toBe(101);
  return opened.socket!;
}

const texts = (s: Socket) => s.messages.filter((m): m is string => typeof m === "string");

describe("moving to a new phone", () => {
  it("exports only entry points from the Worker's module (anything else stops the runtime starting)", () => {
    for (const [name, value] of Object.entries(entry)) {
      if (name === "default") continue;
      expect(typeof value, name).toBe("function");
    }
  });

  it("gives a two-digit channel for ten minutes, and passes messages both ways, text and binary", async () => {
    const code = await newCode();
    expect(code.channel).toMatch(/^\d{2}$/);
    expect(code.expiresIn).toBe(600);
    const old = await sender(code);
    const joined = await open(`/v1/move/receive?channel=${code.channel}`);
    expect(joined.status).toBe(101);
    const fresh = joined.socket!;
    await until(() => texts(old).includes('{"t":"peer"}'), "the old phone told a phone joined");

    fresh.ws.send('{"t":"pake","m":"AAAA"}');
    await until(() => texts(old).includes('{"t":"pake","m":"AAAA"}'), "the new phone's message on the old phone");
    old.ws.send('{"t":"paired"}');
    await until(() => texts(fresh).includes('{"t":"paired"}'), "paired passed on");
    old.ws.send(new Uint8Array([1, 2, 3]).buffer);
    await until(() => fresh.messages.some((m) => typeof m !== "string" && m.join() === "1,2,3"), "binary passed on");
    old.ws.send('{"t":"finished"}');
    expect((await fresh.closed).code).toBe(CLOSE.FINISHED);
    expect(texts(fresh)).toContain('{"t":"finished"}');
  });

  it("frees the channel once the phones are paired, so another move can use it", async () => {
    const code = await newCode();
    const old = await sender(code);
    const fresh = (await open(`/v1/move/receive?channel=${code.channel}`)).socket!;
    await until(() => texts(old).includes('{"t":"peer"}'), "peer");
    old.ws.send('{"t":"paired"}');
    await until(() => texts(fresh).includes('{"t":"paired"}'), "paired");
    // The channel no longer reaches this move.
    const late = await open(`/v1/move/receive?channel=${code.channel}`);
    expect(late.status).toBe(404);
  });

  it("ends a code the old phone says didn't match, and the channel stops answering", async () => {
    const code = await newCode();
    const old = await sender(code);
    const fresh = (await open(`/v1/move/receive?channel=${code.channel}`)).socket!;
    await until(() => texts(old).includes('{"t":"peer"}'), "peer");
    old.ws.send('{"t":"wrong"}');
    expect((await fresh.closed).code).toBe(CLOSE.WRONG);
    expect((await old.closed).code).toBe(CLOSE.WRONG);
    expect((await open(`/v1/move/receive?channel=${code.channel}`)).status).toBe(404);
  });

  it("allows one guess: a new phone that leaves before pairing uses up the code, and the old phone hears at once", async () => {
    const code = await newCode();
    const old = await sender(code);
    const guesser = (await open(`/v1/move/receive?channel=${code.channel}`)).socket!;
    await until(() => texts(old).includes('{"t":"peer"}'), "peer");
    guesser.ws.close(1000, "bye");
    await until(() => texts(old).includes('{"t":"used"}'), "the old phone told the code was used");
    expect((await old.closed).code).toBe(CLOSE.USED);
    expect((await open(`/v1/move/receive?channel=${code.channel}`)).status).toBe(404);
  });

  it("never lets a second phone join the same code", async () => {
    const code = await newCode();
    await sender(code);
    expect((await open(`/v1/move/receive?channel=${code.channel}`)).status).toBe(101);
    const second = await open(`/v1/move/receive?channel=${code.channel}`);
    // Either the channel no longer answers or the relay closes it as used: never a second live join.
    if (second.status === 101) expect((await second.socket!.closed).code).toBe(CLOSE.USED);
    else expect(second.status).toBe(404);
  });

  it("refuses a channel nobody holds, a malformed one, the old phone's side without its token, and a plain request", async () => {
    expect((await open("/v1/move/receive?channel=7")).status).toBe(404);
    const code = await newCode();
    expect((await open(`/v1/move/send?move=${code.move}`, newIp(), "x".repeat(43))).status).toBe(403);
    expect((await open(`/v1/move/send?move=${code.move}`)).status).toBe(403);
    expect((await open(`/v1/move/send?move=nothex`, newIp(), code.token)).status).toBe(403);
    expect((await call("GET", `/v1/move/receive?channel=${code.channel}`)).status).toBe(426);
  });

  it("gives different channels to moves at the same time", async () => {
    const codes = await Promise.all([newCode(), newCode(), newCode(), newCode(), newCode()]);
    expect(new Set(codes.map((c) => c.channel)).size).toBe(5);
  });

  it("limits how many codes one address makes or tries", async () => {
    const ip = newIp();
    let limited = false;
    for (let i = 0; i < 25 && !limited; i++) {
      const reply = await call("POST", "/v1/move/codes", { ip });
      if (reply.status === 429) limited = true;
    }
    expect(limited).toBe(true);
  });
});
