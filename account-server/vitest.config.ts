import { generateKeyPairSync } from "node:crypto";
import { readFileSync } from "node:fs";
import path from "node:path";
import { cloudflareTest, readD1Migrations } from "@cloudflare/vitest-plugin";
import { defineConfig } from "vitest/config";

// A throwaway signing key for keyless Google sign-in (Workload Identity Federation): the Worker signs with it exactly as
// with the real one, and the Google stand-in checks its tokens with the public half.
const playKey = generateKeyPairSync("rsa", {
  modulusLength: 2048,
  privateKeyEncoding: { type: "pkcs8", format: "pem" },
  publicKeyEncoding: { type: "spki", format: "pem" },
});

// The tests run the real Worker in the Workers runtime (Miniflare) with a real D1; Google's and Apple's keys and the
// Play Developer API are stand-ins served through a mocked fetch (test/helpers.ts).
export default defineConfig({
  plugins: [
    cloudflareTest(async () => ({
      wrangler: { configPath: "./wrangler.jsonc" },
      miniflare: {
        bindings: {
          GOOGLE_AUDIENCES: "test-google-client.apps.googleusercontent.com",
          GOOGLE_WIF_SIGNING_KEY: playKey.privateKey,
          PLAY_TEST_PUBLIC_KEY: playKey.publicKey,
          TEST_SIGN_IN_SECRET: "test-sign-in-secret-0123456789abcdef0123",
          // Production's settings, for test/dev-and-production.test.ts to check.
          WRANGLER_CONFIG: readFileSync(path.join(import.meta.dirname, "wrangler.jsonc"), "utf8"),
          TEST_MIGRATIONS: await readD1Migrations(path.join(import.meta.dirname, "migrations")),
        },
      },
    })),
  ],
  test: { setupFiles: ["./test/apply-migrations.ts"] },
});
