import { X509Certificate } from "node:crypto";
import { type JWTPayload, compactVerify, decodeProtectedHeader, importJWK } from "jose";
import { HttpError } from "./http";

/**
 * Checks data Apple signed for us: a StoreKit 2 transaction, or an App Store Server Notification (Architecture 02
 * §3.11). Apple signs it as a JWS whose header carries the certificate chain (leaf, intermediate, root). It's genuine
 * when:
 *  - the root is one we trust: Apple Root CA - G3, pinned here (tests and the dev server may add their own);
 *  - each certificate is signed by the next, and was valid when Apple signed the data;
 *  - the intermediate and leaf carry Apple's markers for this job (OIDs 1.2.840.113635.100.6.2.1 and .6.11.1);
 *  - the JWS signature checks out with the leaf's key.
 * No call to Apple is needed.
 */

/** Apple Root CA - G3 (https://www.apple.com/certificateauthority/), SHA-256 63:34:3A:BF:…:91:79, valid to 2039. */
export const APPLE_ROOT_CA_G3 = `-----BEGIN CERTIFICATE-----
MIICQzCCAcmgAwIBAgIILcX8iNLFS5UwCgYIKoZIzj0EAwMwZzEbMBkGA1UEAwwS
QXBwbGUgUm9vdCBDQSAtIEczMSYwJAYDVQQLDB1BcHBsZSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTETMBEGA1UECgwKQXBwbGUgSW5jLjELMAkGA1UEBhMCVVMwHhcN
MTQwNDMwMTgxOTA2WhcNMzkwNDMwMTgxOTA2WjBnMRswGQYDVQQDDBJBcHBsZSBS
b290IENBIC0gRzMxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9y
aXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzB2MBAGByqGSM49
AgEGBSuBBAAiA2IABJjpLz1AcqTtkyJygRMc3RCV8cWjTnHcFBbZDuWmBSp3ZHtf
TjjTuxxEtX/1H7YyYl3J6YRbTzBPEVoA/VhYDKX1DyxNB0cTddqXl5dvMVztK517
IDvYuVTZXpmkOlEKMaNCMEAwHQYDVR0OBBYEFLuw3qFYM4iapIqZ3r6966/ayySr
MA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMAoGCCqGSM49BAMDA2gA
MGUCMQCD6cHEFl4aXTQY2e3v9GwOAEZLuN+yRhHFD/3meoyhpmvOwgPUnPWTxnS4
at+qIxUCMG1mihDK1A3UT82NQz60imOlM27jbdoXt2QfyFMm+YhidDkLF1vLUagM
6BgD56KyKA==
-----END CERTIFICATE-----`;

// DER encodings of Apple's marker OIDs.
const INTERMEDIATE_OID = Uint8Array.from([0x06, 0x0a, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x63, 0x64, 0x06, 0x02, 0x01]);
const LEAF_OID = Uint8Array.from([0x06, 0x0a, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x63, 0x64, 0x06, 0x0b, 0x01]);

export async function verifyAppleSigned(jws: string, trustedRoots: string[], now = Date.now()): Promise<JWTPayload & Record<string, unknown>> {
  let chain: X509Certificate[];
  try {
    const header = decodeProtectedHeader(jws);
    if (header.alg !== "ES256" || !Array.isArray(header.x5c) || header.x5c.length !== 3) throw new Error("bad header");
    chain = header.x5c.map((der) => new X509Certificate(Uint8Array.from(atob(der), (c) => c.charCodeAt(0))));
  } catch {
    throw notApple();
  }
  const [leaf, intermediate, root] = chain as [X509Certificate, X509Certificate, X509Certificate];
  const trusted = trustedRoots.map((pem) => new X509Certificate(pem).fingerprint256);
  if (!trusted.includes(root.fingerprint256)) throw notApple();
  if (!intermediate.verify(root.publicKey) || !leaf.verify(intermediate.publicKey)) throw notApple();
  if (!contains(intermediate.raw, INTERMEDIATE_OID) || !contains(leaf.raw, LEAF_OID)) throw notApple();

  let payload: JWTPayload & Record<string, unknown>;
  try {
    const key = await importJWK(leaf.publicKey.export({ format: "jwk" }) as Record<string, unknown>, "ES256");
    const result = await compactVerify(jws, key, { algorithms: ["ES256"] });
    payload = JSON.parse(new TextDecoder().decode(result.payload));
  } catch {
    throw notApple();
  }
  // Certificates are checked at the moment Apple signed (so an old purchase stays valid after the leaf expires),
  // and that moment can't be in the future.
  const signedAt = typeof payload.signedDate === "number" ? payload.signedDate : now;
  if (signedAt > now + 5 * 60 * 1000) throw notApple();
  for (const cert of chain) {
    if (signedAt < Date.parse(cert.validFrom) || signedAt > Date.parse(cert.validTo)) throw notApple();
  }
  return payload;
}

function contains(haystack: Uint8Array, needle: Uint8Array): boolean {
  outer: for (let i = 0; i + needle.length <= haystack.length; i++) {
    for (let j = 0; j < needle.length; j++) if (haystack[i + j] !== needle[j]) continue outer;
    return true;
  }
  return false;
}

function notApple() {
  return new HttpError(400, "not_verified", "This purchase couldn't be verified with Apple.");
}
