To generate Liquibase migration scripts in XML format based on the provided OpenAPI specification, we need to create changesets that define the database schema and operations. Below are the Liquibase migration scripts for creating the `customers` table.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog
    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
                        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.3.xsd">

    <changeSet id="1" author="yourname">
        <createTable tableName="customers">
            <column name="id" type="BIGINT" autoIncrement="true">
                <constraints primaryKey="true" nullable="false"/>
            </column>
            <column name="first_name" type="VARCHAR(255)">
                <constraints nullable="false"/>
            </column>
            <column name="last_name" type="VARCHAR(255)">
                <constraints nullable="false"/>
            </column>
        </createTable>
    </changeSet>

</databaseChangeLog>
```

### Explanation:
1. **`<databaseChangeLog>`**: This is the root element of a Liquibase change log file.
2. **`<changeSet>`**: Each `<changeSet>` represents a single database change. The `id` attribute uniquely identifies this change set, and the `author` attribute specifies who made the change.
3. **`<createTable>`**: This tag is used to create a new table in the database. In this case, we are creating a table named `customers`.
4. **`<column>`**: Each `<column>` defines a column in the table. The `name` attribute specifies the column name, and the `type` attribute specifies the data type.
5. **`<constraints>`**: This tag is used to define constraints on columns. Here, we set the primary key constraint for the `id` column and ensure that both `first_name` and `last_name` columns are not nullable.

### Additional Considerations:
- **Data Types**: Ensure that the data types match those specified in your OpenAPI schema.
- **Indexes**: If needed, you can add indexes to improve query performance.
- **Foreign Keys**: If there are relationships between tables, you will need to define foreign keys.
- **Versioning**: Liquibase supports versioning of change logs. You can manage multiple versions by creating separate change log files.

This script provides a basic structure for the `customers` table based on your OpenAPI specification. Depending on your requirements, you may need to add more complex changesets or modify existing ones.