package com.example;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class CalculatorAAATest {

    private Calculator calc;

    // Setup method - runs before every test
    @Before
    public void setUp() {
        System.out.println("➡️ Setup - Creating Calculator");
        calc = new Calculator();
    }

    // Teardown method - runs after every test
    @After
    public void tearDown() {
        System.out.println("⬅️ Teardown - Cleaning up");
        calc = null;
    }

    @Test
    public void testAdd() {
        // Arrange
        int a = 10;
        int b = 5;

        // Act
        int result = calc.add(a, b);

        // Assert
        assertEquals(15, result);
    }

}

