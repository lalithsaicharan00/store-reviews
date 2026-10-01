import path from "node:path";
import { cloudflareTest, readD1Migrations } from "@cloudflare/vitest-plugin";
import { defineConfig } from "vitest/config";

export default defineConfig({
  plugins: [
    cloudflareTest(async () => ({
      wrangler: { configPath: "./wrangler.jsonc" },
      miniflare: {
        // Test-only values. Real secrets are set with `wrangler secret put` and never stored in the repo.
        bindings: {
          TOKEN_KEY: "test-token-key-0123456789abcdef0123456789",
          TEST_LOGIN_SECRET: "test-login-secret-0123456789abcdef01234",
          GOOGLE_AUDIENCES: "test-google-client.apps.googleusercontent.com",
          TEST_MIGRATIONS: await readD1Migrations(path.join(__dirname, "migrations")),
        },
      },
    })),
  ],
  test: { setupFiles: ["./test/apply-migrations.ts"] },
});
