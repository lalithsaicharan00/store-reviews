import { HttpError, errorResponse, json } from "./http";
import { moveRoute } from "./move";

export { MoveRegistry, MoveRelay } from "./move";

/*
 * The move relay's Worker (Rulebook D15, D16). Since 21 Oct 2026 there are no accounts (the user: phones only, Plus
 * moves between iPhone and Android by hand), so all this Worker does is pass two online phones' messages while one
 * moves its habits to the other with a code. It holds nothing about anyone. The account routes it used to serve
 * (sign-in, purchases, Plus Family, refunds, where the habits live) are in git history before 21 Oct 2026.
 *
 *   GET  /v1/health                                                                → { ok, environment }
 *   /v1/move/…                       moving to a new phone with a code, no account  (src/move.ts)
 */

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    try {
      return await route(request, env);
    } catch (error) {
      if (error instanceof HttpError) return errorResponse(error);
      // Never the request's body or tokens in a log (D11).
      console.error(`unexpected: ${error instanceof Error ? error.message : String(error)}`);
      return errorResponse(new HttpError(500, "server_error", "Something went wrong. Please try again."));
    }
  },
} satisfies ExportedHandler<Env>;

async function route(request: Request, env: Env): Promise<Response> {
  const url = new URL(request.url);
  const path = url.pathname.replace(/\/+$/, "");
  const ip = request.headers.get("cf-connecting-ip") ?? "unknown";

  if (path === "/v1/health" && request.method === "GET") return json({ ok: true, environment: env.ENVIRONMENT });

  const moved = await moveRoute(request, env, path, () => limit(env.MOVE_LIMIT, ip));
  if (moved) return moved;

  throw new HttpError(404, "not_found", "Not found.");
}

async function limit(binding: RateLimit | undefined, key: string) {
  if (!binding) return;
  const { success } = await binding.limit({ key });
  if (!success) throw new HttpError(429, "too_many", "Too many tries. Please wait a minute.");
}
