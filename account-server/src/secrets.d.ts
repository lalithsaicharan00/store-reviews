// Secrets (`wrangler secret put`), which `wrangler types` can't see. Optional: until one is set, the call that needs it
// answers "not set up yet" (503) instead of the Worker failing to start.
declare namespace Cloudflare {
  interface Env {
    /** The Worker's own signing key for Workload Identity Federation (src/play.ts): keyless Google Play checks. */
    GOOGLE_WIF_SIGNING_KEY?: string;
    /** Dev only: the end-to-end tests' sign-in (src/worker.ts, testPerson). Never set on production. */
    TEST_SIGN_IN_SECRET?: string;
    /** Dev only ("true"): the debug app's stand-in purchases count as bought. Absent on production. */
    ACCEPT_STAND_IN_PURCHASES?: string;
  }
}
interface Env {
  GOOGLE_WIF_SIGNING_KEY?: string;
  TEST_SIGN_IN_SECRET?: string;
  ACCEPT_STAND_IN_PURCHASES?: string;
}
