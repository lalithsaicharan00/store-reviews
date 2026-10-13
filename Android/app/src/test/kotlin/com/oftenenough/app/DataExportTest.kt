package com.oftenenough.app

import com.oftenenough.app.data.DataExport
import org.junit.Assert.assertEquals
import org.junit.Test

/** The spreadsheet's cells, as the iPhone's DataExport.swift writes them (MOVE TO CORE). */
class DataExportTest {
    @Test fun cells() {
        assertEquals("8", DataExport.number(8.0))
        assertEquals("2.5", DataExport.number(2.5))
        assertEquals("", DataExport.number(Double.NaN))
        assertEquals("'=SUM(A1)", DataExport.spreadsheetText("=SUM(A1)"))
        assertEquals("Water", DataExport.spreadsheetText("Water"))
        assertEquals("2026-10-13,Read,\"a, b\",\"say \"\"hi\"\"\"", DataExport.line(listOf("2026-10-13", "Read", "a, b", "say \"hi\"")))
        assertEquals("Date,Habit,What,Amount,Unit,Note\r\n2026-10-13,Read,Done,1,time,\r\n",
            DataExport.csv(listOf(DataExport.Row("b", listOf("2026-10-13", "Read", "Done", "1", "time", "")))))
    }
}
