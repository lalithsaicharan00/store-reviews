// Makes the Worker's signing key for keyless Google sign-in (Workload Identity Federation; src/play.ts) and puts it
// straight into Cloudflare as the secret GOOGLE_WIF_SIGNING_KEY: the private key is never written to disk, printed or
// kept anywhere else (D11). Its public half goes into google/jwks.json, the file uploaded to the pool's provider in
// Google Cloud Console (public: safe to keep in the repository).
//
//   node scripts/make-wif-key.mjs dev          (key ID account-dev-<n>)
//   node scripts/make-wif-key.mjs production   (key ID account-production-<n>)
//
// A new key replaces the environment's old one: set its ID as GOOGLE_WIF_KEY_ID in wrangler.jsonc, upload the new
// jwks.json, deploy. Google accepts up to 8 uploaded keys, and an upload replaces them all.
import { execFileSync } from "node:child_process";
import { createPublicKey, generateKeyPairSync } from "node:crypto";
import { existsSync, readFileSync, writeFileSync } from "node:fs";

const envName = process.argv[2];
if (envName !== "dev" && envName !== "production") throw new Error("Usage: node scripts/make-wif-key.mjs dev|production");
const config = readFileSync("wrangler.jsonc", "utf8");
const ids = [...config.matchAll(/"GOOGLE_WIF_KEY_ID": "([^"]+)"/g)].map((m) => m[1]);
const keyId = ids.find((id) => id.startsWith(`account-${envName}-`));
if (!keyId) throw new Error(`No GOOGLE_WIF_KEY_ID for ${envName} in wrangler.jsonc`);

const { privateKey } = generateKeyPairSync("rsa", { modulusLength: 2048 });
const pem = privateKey.export({ type: "pkcs8", format: "pem" });
const jwk = createPublicKey(privateKey).export({ format: "jwk" });

const args = ["wrangler", "secret", "put", "GOOGLE_WIF_SIGNING_KEY", ...(envName === "production" ? ["--env", "production"] : [])];
execFileSync("npx", args, { input: pem, stdio: ["pipe", "inherit", "inherit"], shell: process.platform === "win32" });

const file = "google/jwks.json";
const jwks = existsSync(file) ? JSON.parse(readFileSync(file, "utf8")) : { keys: [] };
jwks.keys = jwks.keys.filter((k) => !k.kid.startsWith(`account-${envName}-`));
jwks.keys.push({ kty: "RSA", alg: "RS256", use: "sig", kid: keyId, n: jwk.n, e: jwk.e });
jwks.keys.sort((a, b) => a.kid.localeCompare(b.kid));
writeFileSync(file, JSON.stringify(jwks, null, 2) + "\n");
console.log(`${keyId}: the private key is in Cloudflare (${envName}); its public key is in ${file}, ready to upload.`);
