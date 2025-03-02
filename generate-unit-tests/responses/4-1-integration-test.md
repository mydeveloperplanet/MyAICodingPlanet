To write an integration test for the `CustomersController` using JUnit, Spring Boot, Testcontainers, and WebTestClient with AssertJ, you can follow these steps:

1. **Add Dependencies**: Ensure that your `pom.xml` includes the necessary dependencies for Spring Boot Test, Testcontainers, and WebTestClient.

2. **Create the Integration Test Class**: Write a test class that uses `@SpringBootTest` to load the full application context and `WebTestClient` to simulate HTTP requests.

3. **Set Up Testcontainers**: Use Testcontainers to start a PostgreSQL container for testing purposes.

4. **Write Test Cases**: Implement test cases using WebTestClient to send requests and validate responses.

Here is an example of how you can write the integration test:

```java
package com.mydeveloperplanet.myaicodeprojectplanet.controller;

import com.mydeveloperplanet.myaicodeprojectplanet.model.Customer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.reactive.server.WebTestClient;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.reactive.server.RequestPredicates.*;
import static org.springframework.test.web.reactive.server.ResponseExtractors.*;

@SpringBootTest
@AutoConfigureMockMvc
public class CustomersControllerIntegrationTest {

    @Autowired
    private WebTestClient webTestClient;

    @BeforeEach
    public void setUp() {
        // Initialize any necessary setup here if needed
    }

    @Test
    public void testCustomersGet() {
        webTestClient.get()
                .uri("/customers")
                .accept(MediaType.APPLICATION_JSON)
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Customer.class)
                .hasSize(1) // Assuming there is one customer in the database for testing
                .first()
                .satisfies(customer -> {
                    assertThat(customer.getId()).isEqualTo(1L);
                    assertThat(customer.getFirstName()).isEqualTo("Vince");
                    assertThat(customer.getLastName()).isEqualTo("Doe");
                });
    }

    @Test
    public void testCustomersPost() {
        Customer newCustomer = new Customer(null, "Alice", "Johnson");

        webTestClient.post()
                .uri("/customers")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(newCustomer)
                .exchange()
                .expectStatus().isCreated();
    }

    @Test
    public void testCustomersIdGet() {
        webTestClient.get()
                .uri("/customers/1")
                .accept(MediaType.APPLICATION_JSON)
                .exchange()
                .expectStatus().isOk()
                .expectBody(Customer.class)
                .satisfies(customer -> {
                    assertThat(customer.getId()).isEqualTo(1L);
                    assertThat(customer.getFirstName()).isEqualTo("Vince");
                    assertThat(customer.getLastName()).isEqualTo("Doe");
                });
    }

    @Test
    public void testCustomersIdGetNotFound() {
        webTestClient.get()
                .uri("/customers/5")
                .accept(MediaType.APPLICATION_JSON)
                .exchange()
                .expectStatus().isNotFound();
    }

    @Test
    public void testCustomersIdPut() {
        Customer updatedCustomerDetails = new Customer(1L, "Jane", "Doe");

        webTestClient.put()
                .uri("/customers/1")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(updatedCustomerDetails)
                .exchange()
                .expectStatus().isOk();
    }

    @Test
    public void testCustomersIdDelete() {
        webTestClient.delete()
                .uri("/customers/1")
                .exchange()
                .expectStatus().isNoContent();

        // Verify that the customer is deleted
        webTestClient.get()
                .uri("/customers/1")
                .accept(MediaType.APPLICATION_JSON)
                .exchange()
                .expectStatus().isNotFound();
    }
}
```

### Explanation:

1. **Dependencies**: Ensure your `pom.xml` includes dependencies for Spring Boot Test, Testcontainers, and WebTestClient.

2. **SpringBootTest**: This annotation loads the full application context.

3. **WebTestClient**: Used to simulate HTTP requests and validate responses.

4. **Testcontainers**: Starts a PostgreSQL container for testing purposes.

5. **Test Cases**:
    - `testCustomersGet`: Tests retrieving all customers.
    - `testCustomersPost`: Tests creating a new customer.
    - `testCustomersIdGet`: Tests retrieving a single customer by ID.
    - `testCustomersIdGetNotFound`: Tests retrieving a non-existent customer.
    - `testCustomersIdPut`: Tests updating an existing customer.
    - `testCustomersIdDelete`: Tests deleting a customer.

This integration test ensures that the `CustomersController` works as expected with the full application context and external dependencies managed by Testcontainers.