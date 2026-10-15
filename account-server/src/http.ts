/** Replies and request parsing shared by every route. Errors are JSON: `{ "error": code, "message": text }`. */

export class HttpError extends Error {
  constructor(
    readonly status: number,
    readonly code: string,
    message: string,
  ) {
    super(message);
  }
}

export function json(body: unknown, status = 200): Response {
  return Response.json(body, { status, headers: { "cache-control": "no-store" } });
}

export function errorResponse(error: HttpError): Response {
  const headers: Record<string, string> = { "cache-control": "no-store" };
  if (error.status === 429) headers["retry-after"] = "60";
  // RFC 9110 asks for it on every 401, and Android's HttpURLConnection throws on a 401 without one.
  if (error.status === 401) headers["www-authenticate"] = 'Bearer realm="oftenenough"';
  return Response.json({ error: error.code, message: error.message }, { status: error.status, headers });
}

/** Request bodies here are small (an ID token, a purchase token); anything bigger is refused before it's read. */
export async function readJson(request: Request, maxBytes = 16 * 1024): Promise<Record<string, unknown>> {
  const declared = Number(request.headers.get("content-length") ?? "0");
  if (declared > maxBytes) throw new HttpError(413, "too_large", "The request body is too large.");
  const text = await request.text();
  if (text.length > maxBytes) throw new HttpError(413, "too_large", "The request body is too large.");
  let value: unknown;
  try {
    value = JSON.parse(text);
  } catch {
    throw new HttpError(400, "bad_json", "The request body isn't valid JSON.");
  }
  if (!value || typeof value !== "object" || Array.isArray(value)) throw new HttpError(400, "bad_json", "The request body must be a JSON object.");
  return value as Record<string, unknown>;
}

export function requireString(value: unknown, field: string, maxLength = 4096): string {
  if (typeof value !== "string" || value.length === 0 || value.length > maxLength) {
    throw new HttpError(400, "bad_request", `"${field}" is missing or invalid.`);
  }
  return value;
}

export function optionalString(value: unknown, field: string, maxLength = 4096): string | null {
  if (value === undefined || value === null || value === "") return null;
  return requireString(value, field, maxLength);
}

export async function sha256Hex(text: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

/** A random URL-safe token: [bytes] random bytes in base64url (16 bytes: 22 characters, 128 bits). */
export function randomToken(bytes: number): string {
  const raw = crypto.getRandomValues(new Uint8Array(bytes));
  let text = "";
  for (const b of raw) text += String.fromCharCode(b);
  return btoa(text).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}
