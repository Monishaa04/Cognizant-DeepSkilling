package com.example;

import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;

public class VerificationTest {

    @Test
    public void testVerifyInteraction() {
        // Create mock object
        ExternalApi mockApi = mock(ExternalApi.class);

        // Call the method
        MyService service = new MyService(mockApi);
        service.fetchData();

        // Verify that getData() was called
        verify(mockApi).getData();
    }
}
