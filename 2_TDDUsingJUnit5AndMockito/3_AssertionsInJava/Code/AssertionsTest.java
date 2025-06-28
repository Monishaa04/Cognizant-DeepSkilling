package com.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {

        // assertEquals - Checks if two values are equal
        assertEquals(5, 2 + 3);

        // assertTrue - Checks if condition is true
        assertTrue(5 > 3);

        // assertFalse - Checks if condition is false
        assertFalse(5 < 3);

        // assertNull - Checks if value is null
        String str = null;
        assertNull(str);

        // assertNotNull - Checks if value is not null
        String name = "JUnit";
        assertNotNull(name);
    }
}
