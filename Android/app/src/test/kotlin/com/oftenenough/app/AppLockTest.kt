package com.oftenenough.app

import android.content.SharedPreferences
import com.oftenenough.app.app.AppLock
import com.oftenenough.app.ui.settings.resetWords
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

/** App lock's rules (the iPhone's AppLock.swift): the passcode is kept only as a hash, and wrong codes wait. */
class AppLockTest {
    private var clock = 1_000_000_000L
    private val sp = MemoryPrefs()
    private fun lock() = AppLock(sp) { clock }

    @Test fun aPasscodeIsKeptOnlyAsAHash() {
        val lock = lock()
        lock.turnOnWithPasscode("123456")
        assertTrue(lock.isOn)
        assertFalse(lock.isLocked)
        assertTrue(sp.all.values.none { it.toString().contains("123456") })
        assertTrue(lock.isRight("123456"))
        assertFalse(lock.isRight("654321"))
        // A fresh start (a new process) opens locked, and remembers the way.
        val again = lock()
        assertTrue(again.isLocked)
        assertEquals(AppLock.Method.PASSCODE, again.method)
    }

    @Test fun theSameCodeHasADifferentHashEachTime() {
        val salt1 = ByteArray(16) { 1 }
        val salt2 = ByteArray(16) { 2 }
        assertNotEquals(AppLock.hash("111111", salt1).toList(), AppLock.hash("111111", salt2).toList())
    }

    @Test fun wrongCodesWaitAfterFiveInARow() {
        val lock = lock()
        lock.turnOnWithPasscode("123456")
        lock.phoneLocked()
        repeat(4) { assertEquals("That's not your app passcode.", lock.enter("000000")) }
        assertEquals("Try again in 1 minute.", lock.enter("000000"))
        // While it waits, even the right code waits.
        assertEquals("Try again in 1 minute.", lock.enter("123456"))
        assertTrue(lock.isLocked)
        clock += 61_000
        assertEquals("Try again in 5 minutes.", lock.enter("000000"))
        clock += 301_000
        assertEquals("Try again in 15 minutes.", lock.enter("000000"))
        clock += 901_000
        assertEquals("Try again in 1 hour.", lock.enter("000000"))
        clock += 3_601_000
        assertEquals("Try again in 1 hour.", lock.enter("000000"))
        clock += 3_601_000
        assertNull(lock.enter("123456"))
        assertFalse(lock.isLocked)
        // The right code clears the count: the next wrong one doesn't wait.
        lock.phoneLocked()
        assertEquals("That's not your app passcode.", lock.enter("000000"))
    }

    @Test fun turningOffKeepsNothing() {
        val lock = lock()
        lock.turnOnWithPasscode("123456")
        lock.chooseAgain(AppLock.Again.FIFTEEN_MINUTES)
        lock.turnOff()
        assertFalse(lock.isOn)
        assertFalse(lock.hasPasscode)
        assertTrue(sp.all.isEmpty())
    }

    @Test fun lockingThePhoneLocksAtOnce() {
        val lock = lock()
        lock.turnOnWithPhone()
        lock.chooseAgain(AppLock.Again.FIFTEEN_MINUTES)
        assertFalse(lock.isLocked)
        lock.phoneLocked()
        assertTrue(lock.isLocked)
    }

    @Test fun resetWordsCountTheHoursLeft() {
        assertEquals("A new passcode can be chosen in 24 hours.", resetWords(AppLock.RESET_MS))
        assertEquals("A new passcode can be chosen in 2 hours.", resetWords(3_600_001))
        assertEquals("A new passcode can be chosen within the hour.", resetWords(60_000))
    }
}

/** SharedPreferences in memory, for JVM tests. */
class MemoryPrefs : SharedPreferences {
    private val map = HashMap<String, Any?>()
    override fun getAll(): MutableMap<String, *> = HashMap(map)
    override fun getString(key: String, defValue: String?) = map[key] as String? ?: defValue
    @Suppress("UNCHECKED_CAST") override fun getStringSet(key: String, defValues: MutableSet<String>?) = map[key] as MutableSet<String>? ?: defValues
    override fun getInt(key: String, defValue: Int) = map[key] as Int? ?: defValue
    override fun getLong(key: String, defValue: Long) = map[key] as Long? ?: defValue
    override fun getFloat(key: String, defValue: Float) = map[key] as Float? ?: defValue
    override fun getBoolean(key: String, defValue: Boolean) = map[key] as Boolean? ?: defValue
    override fun contains(key: String) = map.containsKey(key)
    override fun registerOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener?) {}
    override fun unregisterOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener?) {}
    override fun edit(): SharedPreferences.Editor = object : SharedPreferences.Editor {
        private val puts = HashMap<String, Any?>()
        private val removes = HashSet<String>()
        private var clear = false
        override fun putString(key: String, value: String?) = apply { puts[key] = value }
        override fun putStringSet(key: String, values: MutableSet<String>?) = apply { puts[key] = values }
        override fun putInt(key: String, value: Int) = apply { puts[key] = value }
        override fun putLong(key: String, value: Long) = apply { puts[key] = value }
        override fun putFloat(key: String, value: Float) = apply { puts[key] = value }
        override fun putBoolean(key: String, value: Boolean) = apply { puts[key] = value }
        override fun remove(key: String) = apply { removes.add(key) }
        override fun clear() = apply { clear = true }
        override fun commit(): Boolean { apply(); return true }
        override fun apply() {
            if (clear) map.clear()
            removes.forEach { map.remove(it) }
            map.putAll(puts)
        }
    }
}
