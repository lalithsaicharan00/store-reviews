package app.habits.core

/**
 * Raw DEFLATE (RFC 1951), in common Kotlin so every platform makes and reads the same automatic backup file (Current
 * Work 75, Free Plan Backups §7 step 2: a backup sent as you go must be small). Common Kotlin has no compressor, as it
 * has no SHA-256 ([Sha256]); both directions are checked against the JVM's zlib in the tests.
 *
 * - [compress]: one block with the fixed Huffman codes and LZ77 matches found through hash chains. Simple and quick;
 *   on a backup's JSON it comes within a few percent of zlib's default.
 * - [decompress]: every block type (stored, fixed, dynamic), so a file deflated by any tool reads too. It never makes
 *   more than [decompress]'s `size` bytes, and anything malformed is a [BackupProblem] `damaged`.
 */
internal object Deflate {
    private const val WINDOW = 32_768
    private const val MIN_MATCH = 3
    private const val MAX_MATCH = 258
    private const val HASH_BITS = 15
    private const val MAX_CHAIN = 128

    private val LENGTH_BASE = intArrayOf(3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258)
    private val LENGTH_EXTRA = intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0)
    private val DIST_BASE = intArrayOf(1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577)
    private val DIST_EXTRA = intArrayOf(0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13)
    /** Order of the code-length code lengths in a dynamic block's header. */
    private val ORDER = intArrayOf(16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15)

    // MARK: Compressing

    private class BitWriter(capacity: Int) {
        private var buffer = ByteArray(maxOf(64, capacity))
        private var size = 0
        private var bits = 0L
        private var count = 0

        /** [n] bits of [value], least significant first. */
        fun write(value: Int, n: Int) {
            bits = bits or ((value.toLong() and ((1L shl n) - 1)) shl count)
            count += n
            while (count >= 8) {
                put(bits.toInt())
                bits = bits ushr 8
                count -= 8
            }
        }

        /** A Huffman code, which DEFLATE stores most significant bit first. */
        fun code(code: Int, length: Int) {
            var reversed = 0
            for (i in 0 until length) reversed = reversed or (((code ushr i) and 1) shl (length - 1 - i))
            write(reversed, length)
        }

        private fun put(b: Int) {
            if (size == buffer.size) buffer = buffer.copyOf(buffer.size * 2)
            buffer[size++] = b.toByte()
        }

        fun finish(): ByteArray {
            if (count > 0) put(bits.toInt())
            bits = 0; count = 0
            return buffer.copyOf(size)
        }
    }

    private fun literal(w: BitWriter, symbol: Int) = when {
        symbol < 144 -> w.code(0x30 + symbol, 8)
        symbol < 256 -> w.code(0x190 + symbol - 144, 9)
        symbol < 280 -> w.code(symbol - 256, 7)
        else -> w.code(0xC0 + symbol - 280, 8)
    }

    private fun match(w: BitWriter, length: Int, distance: Int) {
        var l = LENGTH_BASE.size - 1
        while (LENGTH_BASE[l] > length) l--
        literal(w, 257 + l)
        if (LENGTH_EXTRA[l] > 0) w.write(length - LENGTH_BASE[l], LENGTH_EXTRA[l])
        var d = DIST_BASE.size - 1
        while (DIST_BASE[d] > distance) d--
        w.code(d, 5)
        if (DIST_EXTRA[d] > 0) w.write(distance - DIST_BASE[d], DIST_EXTRA[d])
    }

    fun compress(data: ByteArray): ByteArray {
        val w = BitWriter(data.size / 3)
        w.write(1, 1) // the last block
        w.write(1, 2) // fixed Huffman codes
        val head = IntArray(1 shl HASH_BITS) { -1 }
        val prev = IntArray(WINDOW)
        fun hash(i: Int) = (((data[i].toInt() and 0xff) shl 10) xor ((data[i + 1].toInt() and 0xff) shl 5) xor (data[i + 2].toInt() and 0xff)) and ((1 shl HASH_BITS) - 1)
        fun insert(i: Int) {
            if (i + MIN_MATCH > data.size) return
            val h = hash(i)
            prev[i and (WINDOW - 1)] = head[h]
            head[h] = i
        }
        var i = 0
        while (i < data.size) {
            var bestLength = 0
            var bestDistance = 0
            if (i + MIN_MATCH <= data.size) {
                var candidate = head[hash(i)]
                var chain = MAX_CHAIN
                val limit = minOf(MAX_MATCH, data.size - i)
                while (candidate >= 0 && i - candidate <= WINDOW && chain-- > 0) {
                    if (data[candidate + bestLength] == data[i + bestLength] || bestLength == 0) {
                        var n = 0
                        while (n < limit && data[candidate + n] == data[i + n]) n++
                        if (n > bestLength) {
                            bestLength = n; bestDistance = i - candidate
                            if (n == limit) break
                        }
                    }
                    val next = prev[candidate and (WINDOW - 1)]
                    if (next >= candidate) break
                    candidate = next
                }
            }
            if (bestLength >= MIN_MATCH) {
                match(w, bestLength, bestDistance)
                for (k in 0 until bestLength) insert(i + k)
                i += bestLength
            } else {
                literal(w, data[i].toInt() and 0xff)
                insert(i)
                i++
            }
        }
        literal(w, 256)
        return w.finish()
    }

    // MARK: Decompressing

    private class Huffman(lengths: IntArray, offset: Int, n: Int) {
        val counts = IntArray(16)
        val symbols = IntArray(n)

        init {
            for (s in 0 until n) counts[lengths[offset + s]]++
            counts[0] = 0
            var left = 1
            for (len in 1..15) {
                left = (left shl 1) - counts[len]
                if (left < 0) throw BackupProblem(BackupProblem.DAMAGED) // over-subscribed
            }
            val offs = IntArray(16)
            for (len in 1 until 15) offs[len + 1] = offs[len] + counts[len]
            for (s in 0 until n) if (lengths[offset + s] != 0) symbols[offs[lengths[offset + s]]++] = s
        }
    }

    private class Reader(val input: ByteArray, val size: Int) {
        var pos = 0
        var bits = 0
        var count = 0
        val out = ByteArray(size)
        var outPos = 0

        fun bit(): Int {
            if (count == 0) {
                if (pos >= input.size) throw BackupProblem(BackupProblem.DAMAGED)
                bits = input[pos++].toInt() and 0xff
                count = 8
            }
            val b = bits and 1
            bits = bits ushr 1
            count--
            return b
        }

        fun bits(n: Int): Int {
            var v = 0
            for (i in 0 until n) v = v or (bit() shl i)
            return v
        }

        fun decode(h: Huffman): Int {
            var code = 0
            var first = 0
            var index = 0
            for (len in 1..15) {
                code = code or bit()
                val count = h.counts[len]
                if (code - count < first) return h.symbols[index + (code - first)]
                index += count
                first += count
                first = first shl 1
                code = code shl 1
            }
            throw BackupProblem(BackupProblem.DAMAGED)
        }

        fun emit(b: Byte) {
            if (outPos >= size) throw BackupProblem(BackupProblem.DAMAGED)
            out[outPos++] = b
        }
    }

    private val fixedLengths: Huffman by lazy {
        val l = IntArray(288) { s -> when { s < 144 -> 8; s < 256 -> 9; s < 280 -> 7; else -> 8 } }
        Huffman(l, 0, 288)
    }
    private val fixedDistances: Huffman by lazy { Huffman(IntArray(30) { 5 }, 0, 30) }

    /** Inflates [data] into exactly [size] bytes; any other outcome is `damaged`. */
    fun decompress(data: ByteArray, size: Int): ByteArray {
        if (size < 0) throw BackupProblem(BackupProblem.DAMAGED)
        val r = Reader(data, size)
        do {
            val last = r.bit()
            when (r.bits(2)) {
                0 -> {
                    r.count = 0
                    if (r.pos + 4 > data.size) throw BackupProblem(BackupProblem.DAMAGED)
                    val len = (data[r.pos].toInt() and 0xff) or ((data[r.pos + 1].toInt() and 0xff) shl 8)
                    val nlen = (data[r.pos + 2].toInt() and 0xff) or ((data[r.pos + 3].toInt() and 0xff) shl 8)
                    if (len != (nlen.inv() and 0xffff)) throw BackupProblem(BackupProblem.DAMAGED)
                    r.pos += 4
                    if (r.pos + len > data.size) throw BackupProblem(BackupProblem.DAMAGED)
                    for (k in 0 until len) r.emit(data[r.pos + k])
                    r.pos += len
                }
                1 -> codes(r, fixedLengths, fixedDistances)
                2 -> {
                    val nlen = r.bits(5) + 257
                    val ndist = r.bits(5) + 1
                    val ncode = r.bits(4) + 4
                    if (nlen > 286 || ndist > 30) throw BackupProblem(BackupProblem.DAMAGED)
                    val lengths = IntArray(320)
                    for (k in 0 until ncode) lengths[ORDER[k]] = r.bits(3)
                    val lencode = Huffman(lengths, 0, 19)
                    var index = 0
                    val all = IntArray(nlen + ndist)
                    while (index < nlen + ndist) {
                        val symbol = r.decode(lencode)
                        if (symbol < 16) {
                            all[index++] = symbol
                        } else {
                            var len = 0
                            val repeat = when (symbol) {
                                16 -> { if (index == 0) throw BackupProblem(BackupProblem.DAMAGED); len = all[index - 1]; 3 + r.bits(2) }
                                17 -> 3 + r.bits(3)
                                else -> 11 + r.bits(7)
                            }
                            if (index + repeat > nlen + ndist) throw BackupProblem(BackupProblem.DAMAGED)
                            repeat(repeat) { all[index++] = len }
                        }
                    }
                    if (all[256] == 0) throw BackupProblem(BackupProblem.DAMAGED)
                    codes(r, Huffman(all, 0, nlen), Huffman(all, nlen, ndist))
                }
                else -> throw BackupProblem(BackupProblem.DAMAGED)
            }
        } while (last == 0)
        if (r.outPos != size) throw BackupProblem(BackupProblem.DAMAGED)
        return r.out
    }

    private fun codes(r: Reader, lengths: Huffman, distances: Huffman) {
        while (true) {
            val symbol = r.decode(lengths)
            when {
                symbol < 256 -> r.emit(symbol.toByte())
                symbol == 256 -> return
                else -> {
                    val l = symbol - 257
                    if (l >= 29) throw BackupProblem(BackupProblem.DAMAGED)
                    val length = LENGTH_BASE[l] + r.bits(LENGTH_EXTRA[l])
                    val d = r.decode(distances)
                    if (d >= 30) throw BackupProblem(BackupProblem.DAMAGED)
                    val distance = DIST_BASE[d] + r.bits(DIST_EXTRA[d])
                    if (distance > r.outPos) throw BackupProblem(BackupProblem.DAMAGED)
                    for (k in 0 until length) r.emit(r.out[r.outPos - distance])
                }
            }
        }
    }
}
