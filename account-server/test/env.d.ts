declare namespace Cloudflare {
  interface Env {
    TEST_MIGRATIONS: import("cloudflare:test").D1Migration[];
    PLAY_TEST_PUBLIC_KEY: string;
    WRANGLER_CONFIG: string;
  }
  interface GlobalProps {
    mainModule: typeof import("../src/worker");
  }
}
