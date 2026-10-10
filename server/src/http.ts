/** Responses and request parsing shared by every route. Errors are JSON: `{ "error": code, "message": text }`. */

export class HttpError extends Error {
  constructor(
    readonly status: number,
    readonly code: string,
    message: string,
    /** More fields for the reply, beside `error` and `message` (e.g. which device is signed in). */
    readonly extra: Record<string, unknown> = {},
  ) {
    super(message);
  }
}

export function json(body: unknown, status = 200, headers: HeadersInit = {}): Response {
  return Response.json(body, { status, headers: { "cache-control": "no-store", ...headers } });
}

export function errorResponse(error: HttpError): Response {
  return json({ ...error.extra, error: error.code, message: error.message }, error.status, error.status === 429 ? { "retry-after": "60" } : {});
}

/** Request bodies here are small (tokens, device details); anything bigger is refused before it's read. */
export async function readJson<T>(request: Request, maxBytes = 16 * 1024): Promise<T> {
  const declared = Number(request.headers.get("content-length") ?? "0");
  if (declared > maxBytes) throw new HttpError(413, "too_large", "The request body is too large.");
  const text = await request.text();
  if (text.length > maxBytes) throw new HttpError(413, "too_large", "The request body is too large.");
  try {
    return JSON.parse(text) as T;
  } catch {
    throw new HttpError(400, "bad_json", "The request body isn't valid JSON.");
  }
}

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export function isUuid(value: unknown): value is string {
  return typeof value === "string" && UUID.test(value);
}

export function requireString(value: unknown, field: string, maxLength = 4096): string {
  if (typeof value !== "string" || value.length === 0 || value.length > maxLength) {
    throw new HttpError(400, "bad_request", `"${field}" is missing or invalid.`);
  }
  return value;
}
