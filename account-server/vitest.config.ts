import { cloudflareTest } from "@cloudflare/vitest-plugin";
import { defineConfig } from "vitest/config";

// The tests run the real Worker in the Workers runtime (Miniflare): the move relay and its Durable Objects.
export default defineConfig({
  plugins: [cloudflareTest(async () => ({ wrangler: { configPath: "./wrangler.jsonc" } }))],
});
