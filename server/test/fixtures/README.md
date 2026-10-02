Test-only certificates that imitate Apple's StoreKit signing chain: a root, an intermediate carrying OID
1.2.840.113635.100.6.2.1, and a leaf carrying OID 1.2.840.113635.100.6.11.1. They are **not Apple's**. Tests trust
the root through `APPLE_EXTRA_ROOTS`; production trusts Apple Root CA - G3 only. `test-leaf.pk8` signs test
transactions, so it is deliberately public and worthless outside these tests.

`apple-signin-test-key.p8` (with its public half, `apple-signin-test-key.pub.pem`) stands in for the Sign in with Apple
key: tests set it as `APPLE_SIGNIN_KEY` and check the client secrets it signs. Not Apple's, deliberately public.
