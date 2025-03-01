The `.exists()` method is indeed available in jOOQ, but it seems like there might be an issue with the context or the way it's being used. Here's a corrected version of your code:

```java
if (dslContext.selectExists(
        dslContext.selectFrom(Customers.CUSTOMERS)
                 .where(Customers.CUSTOMERS.ID.eq(id))
    ))
```

This ensures that you are using `selectExists` correctly, which is the proper method to check if a subquery returns any rows.