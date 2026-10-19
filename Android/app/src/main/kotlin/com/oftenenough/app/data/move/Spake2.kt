package com.oftenenough.app.data.move

import java.math.BigInteger
import java.security.MessageDigest
import java.security.SecureRandom
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

// MOVE TO CORE: the move code's key agreement, so the iPhone runs the same one (Rulebook D15).

/**
 * SPAKE2, RFC 9382, ciphersuite SPAKE2-P256-SHA256-HKDF-HMAC (`Spake2Test` checks it against the RFC's own test
 * vectors). Two phones that know the same short code agree on a strong key through the relay; the relay passes the
 * messages but can't learn the key, and someone guessing the code gets **one** try per exchange: a wrong code shows
 * as confirmation messages that don't match, never as anything that can be tested offline (Rulebook D15).
 *
 * The new phone is A (it sends pA), the old phone B. Points are SEC1 uncompressed (65 bytes).
 */
class Spake2(
    private val role: Role,
    private val idA: ByteArray,
    private val idB: ByteArray,
    private val w: BigInteger,
    /** The secret scalar; only tests pass one (the RFC's x or y). */
    secret: BigInteger? = null,
) {
    enum class Role { A, B }

    private val scalar: BigInteger = secret ?: randomScalar()
    /** This side's message: pA = w·M + x·P (A) or pB = w·N + y·P (B). */
    val message: ByteArray = encode(add(mul(if (role == Role.A) M else N, w), mul(G, scalar)))

    /** What both sides know once the other's message arrived. [peerConfirmation] is checked with [confirms]. */
    class Keys(val ke: ByteArray, val myConfirmation: ByteArray, private val peerConfirmation: ByteArray, val transcript: ByteArray) {
        /** The other phone's confirmation, compared in constant time: false means it used another code. */
        fun confirms(theirs: ByteArray): Boolean = MessageDigest.isEqual(theirs, peerConfirmation)
    }

    /** The other side's message in, the keys out. Throws [IllegalArgumentException] for a message that isn't a point. */
    fun finish(peerMessage: ByteArray): Keys {
        val peer = decode(peerMessage)
        // K = h·x·(pB − w·N) for A, h·y·(pA − w·M) for B; h = 1 on P-256.
        val unmasked = add(peer, neg(mul(if (role == Role.A) N else M, w)))
        val k = mul(unmasked, scalar) ?: throw IllegalArgumentException("identity")
        val pA = if (role == Role.A) message else peerMessage
        val pB = if (role == Role.A) peerMessage else message
        val tt = transcript(idA, idB, pA, pB, encode(k), fixed(w))
        val hash = sha256(tt)
        val ke = hash.copyOfRange(0, 16)
        val ka = hash.copyOfRange(16, 32)
        val kc = hkdf(ka, ByteArray(0), "ConfirmationKeys".toByteArray(), 32)
        val cA = hmac(kc.copyOfRange(0, 16), tt)
        val cB = hmac(kc.copyOfRange(16, 32), tt)
        return if (role == Role.A) Keys(ke, cA, cB, tt) else Keys(ke, cB, cA, tt)
    }

    companion object {
        // First: decoding M and N below uses them. Never BigInteger.TWO: it's Java 9, missing on Android before 13.
        private val TWO = BigInteger.valueOf(2)
        private val THREE = BigInteger.valueOf(3)
        // P-256 (SEC 2): y² = x³ − 3x + b over p, generator G of prime order n, cofactor 1.
        val P = BigInteger("ffffffff00000001000000000000000000000000ffffffffffffffffffffffff", 16)
        private val B_COEF = BigInteger("5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b", 16)
        val ORDER = BigInteger("ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551", 16)
        private val G = Point(
            BigInteger("6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296", 16),
            BigInteger("4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5", 16),
        )
        // RFC 9382 §6, P-256's M and N (compressed).
        private val M = decode(hex("02886e2f97ace46e55ba9dd7242579f2993b64e16ef3dcab95afd497333d8fa12f"))
        private val N = decode(hex("03d8bbd6c639c62937b04d997f38c3770719c629d7014d49a24b4f98baa1292b49"))
        private val random = SecureRandom()

        /**
         * The password scalar w from the code: SHA-512 (64 bits more than n, as the RFC suggests) of a fixed label and the
         * code's ASCII digits, mod n. No memory-hard function: the code is only ever tested online, one try per exchange.
         */
        fun passwordScalar(code: String): BigInteger =
            BigInteger(1, MessageDigest.getInstance("SHA-512").digest("often-enough move v1 ".toByteArray() + code.toByteArray(Charsets.US_ASCII))).mod(ORDER)

        private fun randomScalar(): BigInteger {
            while (true) {
                val k = BigInteger(256, random)
                if (k.signum() > 0 && k < ORDER) return k
            }
        }

        // ---------------------------------------------------------------- The curve, affine, null = the point at infinity

        class Point(val x: BigInteger, val y: BigInteger)

        private fun neg(a: Point?): Point? = a?.let { Point(it.x, P.subtract(it.y).mod(P)) }

        private fun add(a: Point?, b: Point?): Point? {
            if (a == null) return b
            if (b == null) return a
            if (a.x == b.x) {
                if (a.y.add(b.y).mod(P).signum() == 0) return null
                return double(a)
            }
            val l = b.y.subtract(a.y).multiply(b.x.subtract(a.x).modInverse(P)).mod(P)
            val x = l.multiply(l).subtract(a.x).subtract(b.x).mod(P)
            return Point(x, l.multiply(a.x.subtract(x)).subtract(a.y).mod(P))
        }

        private fun double(a: Point): Point? {
            if (a.y.signum() == 0) return null
            val l = THREE.multiply(a.x.multiply(a.x)).subtract(THREE).multiply(TWO.multiply(a.y).modInverse(P)).mod(P)
            val x = l.multiply(l).subtract(TWO.multiply(a.x)).mod(P)
            return Point(x, l.multiply(a.x.subtract(x)).subtract(a.y).mod(P))
        }

        private fun mul(a: Point?, k: BigInteger): Point? {
            var result: Point? = null
            var addend = a
            var n = k.mod(ORDER)
            while (n.signum() > 0) {
                if (n.testBit(0)) result = add(result, addend)
                addend = addend?.let { double(it) }
                n = n.shiftRight(1)
            }
            return result
        }

        private fun onCurve(a: Point): Boolean =
            a.x < P && a.y < P && a.y.multiply(a.y).mod(P) == a.x.pow(3).subtract(THREE.multiply(a.x)).add(B_COEF).mod(P)

        private fun unsigned32(v: BigInteger): ByteArray {
            val b = v.toByteArray()
            return when {
                b.size == 32 -> b
                b.size > 32 -> b.copyOfRange(b.size - 32, b.size)
                else -> ByteArray(32 - b.size) + b
            }
        }

        fun encode(a: Point?): ByteArray {
            requireNotNull(a) { "identity" }
            return byteArrayOf(4) + unsigned32(a.x) + unsigned32(a.y)
        }

        /** SEC1, uncompressed or compressed; anything not on the curve is refused (an invalid-point attack). */
        fun decode(bytes: ByteArray): Point {
            val point = when {
                bytes.size == 65 && bytes[0] == 4.toByte() -> Point(BigInteger(1, bytes.copyOfRange(1, 33)), BigInteger(1, bytes.copyOfRange(33, 65)))
                bytes.size == 33 && (bytes[0] == 2.toByte() || bytes[0] == 3.toByte()) -> {
                    val x = BigInteger(1, bytes.copyOfRange(1, 33))
                    val rhs = x.pow(3).subtract(THREE.multiply(x)).add(B_COEF).mod(P)
                    var y = rhs.modPow(P.add(BigInteger.ONE).shiftRight(2), P)
                    if (y.testBit(0) != (bytes[0] == 3.toByte())) y = P.subtract(y)
                    Point(x, y)
                }
                else -> throw IllegalArgumentException("not a point")
            }
            require(onCurve(point)) { "not on the curve" }
            return point
        }

        // ---------------------------------------------------------------- The transcript and key schedule (RFC 9382 §3.3, §4)

        private fun len(b: ByteArray): ByteArray = ByteArray(8).also { out -> var n = b.size.toLong(); for (i in 0 until 8) { out[i] = (n and 0xff).toByte(); n = n shr 8 } }
        private fun fixed(w: BigInteger) = unsigned32(w)
        fun transcript(vararg parts: ByteArray): ByteArray = parts.fold(ByteArray(0)) { acc, p -> acc + len(p) + p }
        fun sha256(b: ByteArray): ByteArray = MessageDigest.getInstance("SHA-256").digest(b)
        fun hmac(key: ByteArray, data: ByteArray): ByteArray = Mac.getInstance("HmacSHA256").run { init(SecretKeySpec(key, "HmacSHA256")); doFinal(data) }

        /** HKDF-SHA256 (RFC 5869); an empty salt is a block of zeros. */
        fun hkdf(ikm: ByteArray, salt: ByteArray, info: ByteArray, length: Int): ByteArray {
            val prk = hmac(if (salt.isEmpty()) ByteArray(32) else salt, ikm)
            var t = ByteArray(0)
            var out = ByteArray(0)
            var i = 1
            while (out.size < length) {
                t = hmac(prk, t + info + byteArrayOf(i.toByte()))
                out += t
                i++
            }
            return out.copyOf(length)
        }

        fun hex(s: String): ByteArray = s.chunked(2).map { it.toInt(16).toByte() }.toByteArray()
    }
}
