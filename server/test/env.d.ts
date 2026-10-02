declare namespace Cloudflare {
  interface Env {
    TEST_MIGRATIONS: import("cloudflare:test").D1Migration[];
    APPLE_SIGNIN_TEST_PUBLIC_KEY: string;
  }
  interface GlobalProps {
    mainModule: typeof import("../src/worker");
    durableNamespaces: "Account";
  }
}
