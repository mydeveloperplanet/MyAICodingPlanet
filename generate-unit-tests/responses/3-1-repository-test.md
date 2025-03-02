```java
package com.mydeveloperplanet.myaicodeprojectplanet.repository;

import com.mydeveloperplanet.myaicodeprojectplanet.jooq.tables.Customers;
import com.mydeveloperplanet.myaicodeprojectplanet.model.Customer;
import org.jooq.DSLContext;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;
import java.util.Optional;

import static com.mydeveloperplanet.myaicodeprojectplanet.jooq.tables.Customers.CUSTOMERS;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@JdbcTest
@Testcontainers
@Import(CustomerRepository.class)
public class CustomerRepositoryTest {

    @Container
    public static PostgreSQLContainer<?> postgreSQLContainer = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private DSLContext dslContext;

    @Autowired
    private CustomerRepository customerRepository;

    @BeforeEach
    public void setUp() {
        // Initialize the database schema and insert test data here if needed
    }

    @Test
    public void getAllCustomers() {
        List<Customer> customers = customerRepository.getAllCustomers();
        assertThat(customers).isNotEmpty();
    }

    @Test
    public void getCustomerById() {
        Optional<Customer> customer = customerRepository.getCustomerById(1L);
        assertThat(customer).isPresent();
    }

    @Test
    public void createCustomer() {
        Customer newCustomer = new Customer(null, "John", "Doe");
        Customer createdCustomer = customerRepository.createCustomer(newCustomer);
        assertThat(createdCustomer.getId()).isNotNull();
    }

    @Test
    public void updateCustomer() {
        Customer updatedCustomerDetails = new Customer(1L, "Jane", "Doe");
        Customer updatedCustomer = customerRepository.updateCustomer(1L, updatedCustomerDetails);
        assertThat(updatedCustomer.getFirstName()).isEqualTo("Jane");
        assertThat(updatedCustomer.getLastName()).isEqualTo("Doe");
    }

    @Test
    public void deleteCustomer() {
        customerRepository.deleteCustomer(1L);
        Optional<Customer> deletedCustomer = customerRepository.getCustomerById(1L);
        assertThat(deletedCustomer).isNotPresent();
    }
}
```