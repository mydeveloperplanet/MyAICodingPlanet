```java
package com.mydeveloperplanet.myaicodeprojectplanet.service;

import com.mydeveloperplanet.myaicodeprojectplanet.model.Customer;
import com.mydeveloperplanet.myaicodeprojectplanet.repository.CustomerRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class CustomerServiceImplTest {

    @Mock
    private CustomerRepository customerRepository;

    @InjectMocks
    private CustomerServiceImpl customerService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllCustomers() {
        List<Customer> customers = Arrays.asList(new Customer(1L, "John Doe"), new Customer(2L, "Jane Smith"));
        when(customerRepository.getAllCustomers()).thenReturn(customers);

        List<Customer> result = customerService.getAllCustomers();

        assertThat(result).isEqualTo(customers);
        verify(customerRepository, times(1)).getAllCustomers();
    }

    @Test
    public void testGetCustomerById() {
        Customer customer = new Customer(1L, "John Doe");
        when(customerRepository.getCustomerById(1L)).thenReturn(Optional.of(customer));

        Optional<Customer> result = customerService.getCustomerById(1L);

        assertThat(result).isEqualTo(Optional.of(customer));
        verify(customerRepository, times(1)).getCustomerById(1L);
    }

    @Test
    public void testCreateCustomer() {
        Customer customer = new Customer(null, "John Doe");
        when(customerRepository.createCustomer(any(Customer.class))).thenReturn(new Customer(1L, "John Doe"));

        Customer result = customerService.createCustomer(customer);

        assertThat(result).isEqualTo(new Customer(1L, "John Doe"));
        verify(customerRepository, times(1)).createCustomer(any(Customer.class));
    }

    @Test
    public void testUpdateCustomer() {
        Customer existingCustomer = new Customer(1L, "John Doe");
        Customer updatedCustomer = new Customer(1L, "Jane Smith");
        when(customerRepository.updateCustomer(1L, any(Customer.class))).thenReturn(updatedCustomer);

        Customer result = customerService.updateCustomer(1L, updatedCustomer);

        assertThat(result).isEqualTo(updatedCustomer);
        verify(customerRepository, times(1)).updateCustomer(1L, any(Customer.class));
    }

    @Test
    public void testDeleteCustomer() {
        customerService.deleteCustomer(1L);

        verify(customerRepository, times(1)).deleteCustomer(1L);
    }
}
```