// Secrets (`wrangler secret put`), which `wrangler types` can't see. Optional: until one is set, the call that needs it
// answers "not set up yet" (503) instead of the Worker failing to start.
declare namespace Cloudflare {
  interface Env {
    /** The Play service account's JSON key: checking Google Play purchases (src/play.ts). */
    GOOGLE_PLAY_SERVICE_ACCOUNT?: string;
    /** Dev only: the end-to-end tests' sign-in (src/worker.ts, testPerson). Never set on production. */
    TEST_SIGN_IN_SECRET?: string;
    /** Dev only ("true"): the debug app's stand-in purchases count as bought. Absent on production. */
    ACCEPT_STAND_IN_PURCHASES?: string;
  }
}
interface Env {
  GOOGLE_PLAY_SERVICE_ACCOUNT?: string;
  TEST_SIGN_IN_SECRET?: string;
  ACCEPT_STAND_IN_PURCHASES?: string;
}
