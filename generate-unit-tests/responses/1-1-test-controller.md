```java
package com.mydeveloperplanet.myaicodeprojectplanet.controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(CustomersController.class)
public class CustomersControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CustomerService customerService;

    @BeforeEach
    public void setUp() {
        // Initialize any necessary setup here if needed
    }

    @Test
    public void testCustomersGet() throws Exception {
        List<Customer> customers = List.of(
                new Customer(1L, "John", "Doe"),
                new Customer(2L, "Jane", "Smith")
        );

        when(customerService.getAllCustomers()).thenReturn(customers);

        mockMvc.perform(get("/customers"))
               .andExpect(status().isOk())
               .andExpect(jsonPath("$.length()").value(2))
               .andExpect(jsonPath("$[0].id").value(1))
               .andExpect(jsonPath("$[0].firstName").value("John"))
               .andExpect(jsonPath("$[0].lastName").value("Doe"))
               .andExpect(jsonPath("$[1].id").value(2))
               .andExpect(jsonPath("$[1].firstName").value("Jane"))
               .andExpect(jsonPath("$[1].lastName").value("Smith"));
    }

    @Test
    public void testCustomersPost() throws Exception {
        com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer openAPICustomer = new com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer();
        openAPICustomer.setId(3L);
        openAPICustomer.setFirstName("Alice");
        openAPICustomer.setLastName("Johnson");

        Customer customer = convertToDomainModel(openAPICustomer);

        when(customerService.createCustomer(customer)).thenReturn(customer);

        mockMvc.perform(post("/customers")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"id\":3,\"firstName\":\"Alice\",\"lastName\":\"Johnson\"}"))
               .andExpect(status().isCreated());
    }

    @Test
    public void testCustomersIdGet() throws Exception {
        Customer customer = new Customer(4L, "Bob", "Brown");

        when(customerService.getCustomerById(4L)).thenReturn(Optional.of(customer));

        mockMvc.perform(get("/customers/4"))
               .andExpect(status().isOk())
               .andExpect(jsonPath("$.id").value(4))
               .andExpect(jsonPath("$.firstName").value("Bob"))
               .andExpect(jsonPath("$.lastName").value("Brown"));
    }

    @Test
    public void testCustomersIdGetNotFound() throws Exception {
        when(customerService.getCustomerById(5L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/customers/5"))
               .andExpect(status().isNotFound());
    }

    @Test
    public void testCustomersIdPut() throws Exception {
        com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer openAPICustomer = new com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer();
        openAPICustomer.setId(6L);
        openAPICustomer.setFirstName("Charlie");
        openAPICustomer.setLastName("Davis");

        Customer customerDetails = convertToDomainModel(openAPICustomer);

        when(customerService.updateCustomer(6L, customerDetails)).thenReturn(customerDetails);

        mockMvc.perform(put("/customers/6")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"id\":6,\"firstName\":\"Charlie\",\"lastName\":\"Davis\"}"))
               .andExpect(status().isOk());
    }

    @Test
    public void testCustomersIdDelete() throws Exception {
        mockMvc.perform(delete("/customers/7"))
               .andExpect(status().isNoContent());

        verify(customerService, times(1)).deleteCustomer(7L);
    }
}
```