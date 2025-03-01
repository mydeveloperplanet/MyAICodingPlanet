It appears that `selectExists` might not be directly available in your jOOQ version. In that case, you can use a subquery to achieve the same result. Here's how you can fix the code:

```java
boolean exists = dslContext.selectFrom(Customers.CUSTOMERS)
                          .where(Customers.CUSTOMERS.ID.eq(id))
                          .fetchExists();
```

This approach uses `fetchExists()` method, which checks if any rows are returned by the subquery.