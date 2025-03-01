Based on the provided Liquibase migration script, we can create a simple domain model in Java. The script defines a `customers` table with three columns: `id`, `first_name`, and `last_name`. Here is a basic domain model class for this table:

```java
public class Customer {
    private Long id;
    private String firstName;
    private String lastName;

    // Default constructor
    public Customer() {}

    // Parameterized constructor
    public Customer(Long id, String firstName, String lastName) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    // Optional: toString method for easy debugging
    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                '}';
    }
}
```

This class represents the `customers` table and includes fields, constructors, getters, setters, and a `toString` method for easy debugging.