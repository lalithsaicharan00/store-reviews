import { DurableObject } from "cloudflare:workers";
import { HttpError, errorResponse, json } from "./http";

/*
 * Moving to a new phone with a code (Rulebook D15, Current Work 136). This Worker only passes messages between two
 * phones that are both online; it never sees the habits, the code or the key.
 *
 * The code is 6 digits: the first 2 are the **channel** (which old phone to reach; the only part the server knows),
 * the last 4 are made on the old phone and never leave it. Both phones run SPAKE2 (RFC 9382) on the whole code through
 * the relay and get the same strong key; everything after is encrypted with it. A wrong code can't be tested offline:
 * it shows only as confirmation messages that don't match, so each code allows **one guess**. The relay enforces it:
 * a channel takes one new phone, ever; when that phone leaves before the old phone says the codes matched, or the old
 * phone says they didn't, the code is over and the old phone makes a new one at once ("Someone typed a wrong code.
 * Here's a new one."). A code also ends after 10 minutes.
 *
 *   POST /v1/move/codes                         → { channel, move, token, expiresIn }   (the old phone)
 *   GET  /v1/move/send?move=…            (WebSocket, Authorization: Bearer <token>)    (the old phone)
 *   GET  /v1/move/receive?channel=NN     (WebSocket)                                   (the new phone)
 *
 * Over the sockets: JSON text frames between the phones ({"t":"pake"…}, {"t":"confirm"…}), passed through untouched,
 * then binary frames (encrypted, passed through untouched). The relay itself says {"t":"peer"} to the old phone when a
 * new phone joins, {"t":"used"} when that new phone left before pairing, and reads two of the old phone's: {"t":"wrong"}
 * (the codes didn't match: both are closed, 4001) and {"t":"paired"} (they did: the channel is free again for others,
 * and this move has 30 minutes to finish).
 *
 * Close codes: 4001 wrong code · 4002 the code was used by a phone that left · 4003 the other phone left · 4004 the
 * code expired · 4005 finished.
 */

export const CODE_SECONDS = 10 * 60;
const PAIRED_SECONDS = 30 * 60;
const CHANNELS = 100;
const CHANNEL = /^\d{2}$/;
const MOVE_ID = /^[a-f0-9]{32}$/;
const TOKEN = /^[A-Za-z0-9_-]{43}$/;

export const CLOSE = { WRONG: 4001, USED: 4002, PEER_LEFT: 4003, EXPIRED: 4004, FINISHED: 4005 } as const;

/** Which move each channel belongs to now: one object for the whole Worker, so two old phones never get one channel. */
export class MoveRegistry extends DurableObject<Env> {
  /** A free channel for a new move, or null when all 100 are taken (each is held at most 10 minutes). */
  async allocate(move: string): Promise<string | null> {
    const now = Date.now();
    const taken = new Set<string>();
    for (const [key, value] of await this.ctx.storage.list<{ move: string; until: number }>({ prefix: "c:" })) {
      if (value.until <= now) await this.ctx.storage.delete(key);
      else taken.add(key.slice(2));
    }
    const free = [...Array(CHANNELS).keys()].map((n) => n.toString().padStart(2, "0")).filter((c) => !taken.has(c));
    if (free.length === 0) return null;
    const channel = free[randomIndex(free.length)]!;
    await this.ctx.storage.put(`c:${channel}`, { move, until: now + CODE_SECONDS * 1000 });
    return channel;
  }

  async lookup(channel: string): Promise<string | null> {
    const entry = await this.ctx.storage.get<{ move: string; until: number }>(`c:${channel}`);
    return entry && entry.until > Date.now() ? entry.move : null;
  }

  /** Frees the channel if it still belongs to [move]. */
  async release(channel: string, move: string): Promise<void> {
    const entry = await this.ctx.storage.get<{ move: string }>(`c:${channel}`);
    if (entry?.move === move) await this.ctx.storage.delete(`c:${channel}`);
  }
}

type Phase = "waiting" | "joined" | "paired" | "ended";
interface MoveState { move: string; channel: string; tokenHash: string; phase: Phase }

/** One move: the old phone's socket and, once, a new phone's; messages pass between them. Hibernates between messages. */
export class MoveRelay extends DurableObject<Env> {
  async start(move: string, channel: string, tokenHash: string): Promise<void> {
    await this.ctx.storage.put<MoveState>("state", { move, channel, tokenHash, phase: "waiting" });
    await this.ctx.storage.setAlarm(Date.now() + CODE_SECONDS * 1000);
  }

  override async fetch(request: Request): Promise<Response> {
    const state = await this.ctx.storage.get<MoveState>("state");
    const url = new URL(request.url);
    if (!state || state.phase === "ended") return closedSocket(CLOSE.EXPIRED, "This code has ended.");
    const pair = new WebSocketPair();
    const [client, server] = [pair[0], pair[1]];
    if (url.pathname.endsWith("/send")) {
      // An error answered here, not thrown: a throw inside a Durable Object reaches the Worker as a 500.
      if (!(await sameHash(bearer(request) ?? "", state.tokenHash))) return errorResponse(new HttpError(403, "not_yours", "This isn't your move."));
      // The old phone came back (the app was in the background): its newest socket is the one that counts.
      for (const old of this.ctx.getWebSockets("sender")) old.close(1000, "replaced");
      this.ctx.acceptWebSocket(server, ["sender"]);
      if (state.phase === "joined" || state.phase === "paired") server.send(JSON.stringify({ t: "peer" }));
    } else {
      // One new phone per code, ever: a second try at the same code is refused, whatever happened to the first.
      if (state.phase !== "waiting") return closedSocket(CLOSE.USED, "This code was already used.");
      state.phase = "joined";
      await this.ctx.storage.put("state", state);
      this.ctx.acceptWebSocket(server, ["receiver"]);
      for (const sender of this.ctx.getWebSockets("sender")) sender.send(JSON.stringify({ t: "peer" }));
    }
    return new Response(null, { status: 101, webSocket: client });
  }

  override async webSocketMessage(ws: WebSocket, message: string | ArrayBuffer): Promise<void> {
    const state = await this.ctx.storage.get<MoveState>("state");
    if (!state || state.phase === "ended") return ws.close(CLOSE.EXPIRED, "This code has ended.");
    const fromSender = this.ctx.getTags(ws).includes("sender");
    if (fromSender && typeof message === "string") {
      const kind = controlKind(message);
      if (kind === "wrong") return this.end(state, CLOSE.WRONG, "That code didn't work.");
      if (kind === "paired" && state.phase === "joined") {
        state.phase = "paired";
        await this.ctx.storage.put("state", state);
        await registry(this.env).release(state.channel, state.move);
        await this.ctx.storage.setAlarm(Date.now() + PAIRED_SECONDS * 1000);
      }
      if (kind === "finished") return this.end(state, CLOSE.FINISHED, "Finished.", message);
    }
    for (const other of this.ctx.getWebSockets(fromSender ? "receiver" : "sender")) other.send(message);
  }

  override async webSocketClose(ws: WebSocket, code: number): Promise<void> {
    const state = await this.ctx.storage.get<MoveState>("state");
    if (!state || state.phase === "ended") return;
    const fromSender = this.ctx.getTags(ws).includes("sender");
    if (!fromSender && state.phase === "joined") {
      // The new phone left before the codes matched: its one guess is used, so this code is over.
      for (const sender of this.ctx.getWebSockets("sender")) sender.send(JSON.stringify({ t: "used" }));
      return this.end(state, CLOSE.USED, "This code was used.");
    }
    if (!fromSender && state.phase === "paired") return this.end(state, CLOSE.PEER_LEFT, "The new phone left.");
    // The old phone's socket closed: while nobody has joined it may come back; once a move is under way, it's over.
    if (fromSender && code !== 1000 && state.phase !== "waiting") return this.end(state, CLOSE.PEER_LEFT, "The old phone left.");
  }

  override async webSocketError(ws: WebSocket): Promise<void> {
    await this.webSocketClose(ws, 1006);
  }

  override async alarm(): Promise<void> {
    const state = await this.ctx.storage.get<MoveState>("state");
    if (state && state.phase !== "ended") await this.end(state, CLOSE.EXPIRED, "This code has ended.");
  }

  private async end(state: MoveState, code: number, reason: string, last?: string): Promise<void> {
    state.phase = "ended";
    await this.ctx.storage.put("state", state);
    await registry(this.env).release(state.channel, state.move);
    for (const ws of this.ctx.getWebSockets()) {
      try {
        if (last !== undefined && this.ctx.getTags(ws).includes("receiver")) ws.send(last);
        ws.close(code, reason);
      } catch {
        // Already closing.
      }
    }
    // Nothing of a move is kept once it's over.
    await this.ctx.storage.deleteAlarm();
    await this.ctx.storage.deleteAll();
  }
}

/** The routes under /v1/move (null: not one of them). [limit] counts per IP. */
export async function moveRoute(request: Request, env: Env, path: string, limit: () => Promise<void>): Promise<Response | null> {
  const url = new URL(request.url);
  if (path === "/v1/move/codes" && request.method === "POST") {
    await limit();
    const move = hex(16);
    const channel = await registry(env).allocate(move);
    if (!channel) throw new HttpError(503, "busy", "Too many phones are moving right now. Please try again in a minute.");
    const token = token43();
    await relay(env, move).start(move, channel, await sha256(token));
    return json({ channel, move, token, expiresIn: CODE_SECONDS });
  }
  if (path === "/v1/move/send" && request.method === "GET") {
    requireUpgrade(request);
    const move = url.searchParams.get("move") ?? "";
    // The token rides in a header, never the URL: request URLs are logged (D11).
    if (!MOVE_ID.test(move) || !TOKEN.test(bearer(request) ?? "")) throw new HttpError(403, "not_yours", "This isn't your move.");
    return relay(env, move).fetch(new Request("https://relay/send", request));
  }
  if (path === "/v1/move/receive" && request.method === "GET") {
    requireUpgrade(request);
    await limit();
    const channel = url.searchParams.get("channel") ?? "";
    const move = CHANNEL.test(channel) ? await registry(env).lookup(channel) : null;
    if (!move) throw new HttpError(404, "no_code", "That code didn't work.");
    return relay(env, move).fetch(new Request("https://relay/receive", request));
  }
  return null;
}

function registry(env: Env): DurableObjectStub<MoveRegistry> {
  return env.MOVE_REGISTRY.get(env.MOVE_REGISTRY.idFromName("registry"));
}

function relay(env: Env, move: string): DurableObjectStub<MoveRelay> {
  return env.MOVE_RELAY.get(env.MOVE_RELAY.idFromName(move));
}

function bearer(request: Request): string | null {
  const header = request.headers.get("authorization") ?? "";
  return header.startsWith("Bearer ") ? header.slice(7) : null;
}

function requireUpgrade(request: Request) {
  if (request.headers.get("upgrade")?.toLowerCase() !== "websocket") throw new HttpError(426, "websocket", "This needs a WebSocket.");
}

/** A socket that closes straight away with [code], so the phone reads why (an HTTP error before the upgrade can't say). */
function closedSocket(code: number, reason: string): Response {
  const pair = new WebSocketPair();
  pair[1].accept();
  pair[1].close(code, reason);
  return new Response(null, { status: 101, webSocket: pair[0] });
}

function controlKind(message: string): string | null {
  if (message.length > 200) return null;
  try {
    const value = JSON.parse(message) as { t?: unknown };
    return typeof value.t === "string" ? value.t : null;
  } catch {
    return null;
  }
}

function randomIndex(n: number): number {
  const bytes = new Uint32Array(1);
  crypto.getRandomValues(bytes);
  return bytes[0]! % n;
}

function hex(bytes: number): string {
  return [...crypto.getRandomValues(new Uint8Array(bytes))].map((b) => b.toString(16).padStart(2, "0")).join("");
}

function token43(): string {
  return btoa(String.fromCharCode(...crypto.getRandomValues(new Uint8Array(32)))).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

async function sha256(text: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

async function sameHash(token: string, hash: string): Promise<boolean> {
  const mine = await sha256(token);
  // Both are hex SHA-256: compare all 64 characters, whatever matches first.
  let diff = mine.length ^ hash.length;
  for (let i = 0; i < Math.min(mine.length, hash.length); i++) diff |= mine.charCodeAt(i) ^ hash.charCodeAt(i);
  return diff === 0;
}
