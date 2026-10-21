import { exports } from "cloudflare:workers";

let ipCounter = 0;
/** A fresh caller IP, so one test's calls don't use up another's rate limit. */
export function newIp() {
  return `test-ip-${++ipCounter}`;
}

export interface Reply { status: number; body: any; headers?: Headers }

/** One call to the Worker, as the app makes it. */
export async function call(method: string, path: string, opts: { body?: unknown; ip?: string } = {}): Promise<Reply> {
  const headers: Record<string, string> = { "cf-connecting-ip": opts.ip ?? newIp() };
  if (opts.body !== undefined) headers["content-type"] = "application/json";
  const response = await exports.default.fetch(new Request(`https://api.test${path}`, {
    method,
    headers,
    body: opts.body === undefined ? undefined : JSON.stringify(opts.body),
  }));
  const text = await response.text();
  return { status: response.status, body: text ? JSON.parse(text) : null, headers: response.headers };
}
