package com.oftenenough.app

import app.habits.core.DriveError
import com.oftenenough.app.app.backup.LocalDrive
import java.nio.file.Files
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Assert.fail
import org.junit.Test

/** The stand-in Drive answers as Google Drive does where sync depends on it (Rulebook D16; Prototype Results). */
class LocalDriveTest {
    private val drive = LocalDrive(Files.createTempDirectory("drive").toFile())

    @Test fun aReservedIdIsSavedOnce() = runBlocking {
        val (id) = drive.generateIds(1)
        drive.create(id, "v1", mapOf("chain" to "base"), byteArrayOf(1, 2, 3))
        try { drive.create(id, "v1", emptyMap(), byteArrayOf(4)); fail("a second save under one ID must be refused") } catch (_: DriveError.Conflict) {}
        assertArrayEquals(byteArrayOf(1, 2, 3), drive.download(id))
        assertEquals("base", drive.get(id)!!.properties["chain"])
    }

    @Test fun aDeletedFilesIdStaysTaken() = runBlocking {
        val (id) = drive.generateIds(1)
        drive.create(id, "v1", emptyMap(), byteArrayOf(1))
        drive.delete(id)
        assertTrue(drive.list().isEmpty())
        try { drive.download(id); fail("a deleted file is gone") } catch (_: DriveError.NotFound) {}
        try { drive.create(id, "v1", emptyMap(), byteArrayOf(2)); fail("a deleted file's ID counts as taken") } catch (_: DriveError.Conflict) {}
    }

    @Test fun propertiesChangeWithoutTheContent() = runBlocking {
        val (id) = drive.generateIds(1)
        drive.create(id, "device", mapOf("a" to "1"), byteArrayOf(9))
        assertEquals(mapOf("a" to "1", "b" to "2"), drive.updateProperties(id, mapOf("b" to "2")).properties)
        assertArrayEquals(byteArrayOf(9), drive.download(id))
    }
}
