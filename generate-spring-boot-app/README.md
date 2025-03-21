# Generate Spring Boot Application

Can you generate a Spring Boot Application using an AI coding assistant?

The code should be production-grade quality.

## Setup
LMStudio, qwen2.5-coder, GPU

## Create Skeleton
The Spring Boot application has the following requirements:
* The Rest API must be defined by means of an OpenAPI specification;
* The controller interface is generated by means of the `openapi-generator-maven-plugin`;
* PostgreSQL is used as database;
* Liquibase is used to create the database tables;
* jOOQ is used to access the database;
* The jOOQ classes must be generated by means of the `testcontainers-jooq-codegen-maven-plugin`.

Navigate to [Spring Initializr](https://start.spring.io/) and add the following dependencies:
* Spring Web
* PostgreSQL Driver
* JOOQ Access Layer
* Validation
* Liquibase Migration

The following changes are applied to the generated Spring Boot application:
* The controller interface must be generated based on the OpenAPI specification, add plugin `openapi-generator-maven-plugin` and dependency `swagger-annotations`;
* Add scope runtime to dependency `liquibase-core`;
* Add a file `db.changelog-root.xml` to `src/main/resources/db/changelog/db.changelog-root.xml` as root file for the Liquibase migration scripts;
* The jOOQ classes should be generated, add plugin `testcontainers-jooq-codegen-maven-plugin`;
* Remove the test from the test sources.

The changes are applied to branch [feature/base-repository](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/base-repository).

Run the build.
```shell
mvn clean verify
```

The build fails because the OpenAPI specification is missing. However, this is the starting point.

## Generate OpenAPI Specification
The build fails on the OpenAPI specification which is missing. So, let's first fix this.

### Prompt
Enter the prompt.
```text
Generate an OpenAPI specification version 3.1.1. 
The spec should contain CRUD methods for customers. 
The customers have a first name and a last name. 
Use the Zalando restful api guidelines.
```
### Response
The response can be viewed [here](responses/1-generate-openapi-spec.md).

### Apply Response
Add the response to file [src/main/resources/static/customers.yaml](https://github.com/mydeveloperplanet/myaicodeprojectplanet/blob/feature/add-openapi-spec/src/main/resources/static/customers.yaml).

Additionally, change the following.
* Change the identifiers from strings to integers;
* Add the identifier to the Customer schema, this way the identifier will be returned in the responses.
```yaml
components:
  schemas:
    Customer:
      type: object
      properties:
        id:
          type: integer
          format: int64
        firstName:
          type: string
        lastName:
          type: string
```

Run the build. The build is successful and in directory `target/generated-sources/openapi` the generated sources are available.

The build shows some warnings, but these can be fixed by adding an `operationId` to the OpenAPI specification. For now, the warnings are ignored.
```shell
[WARNING] Empty operationId found for path: GET /customers. Renamed to auto-generated operationId: customersGET
[WARNING] Empty operationId found for path: POST /customers. Renamed to auto-generated operationId: customersPOST
[WARNING] Empty operationId found for path: GET /customers/{id}. Renamed to auto-generated operationId: customersIdGET
[WARNING] Empty operationId found for path: PUT /customers/{id}. Renamed to auto-generated operationId: customersIdPUT
[WARNING] Empty operationId found for path: DELETE /customers/{id}. Renamed to auto-generated operationId: customersIdDELETE
```

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/add-openapi-spec).

## Generate Liquibase Scripts
In this section, the Liquibase scripts will be generated.

### Prompt
Open the OpenAPI spec and enter the prompt.
```text
Based on this openapi spec, generate liquibase migration scripts in XML format
```

### Response
The response can be viewed [here](responses/2-generate-liquibase.md).

### Apply Response
The generated XML Liquibase script is entirely correct. Create in directory `src/main/resources/db/changelog/migration` a file `db.changelog-1.xml` and copy the response into it. Besides that, change the author to `mydeveloperplanet`.
```xml
<changeSet id="1" author="mydeveloperplanet">
```

Run the build.

The build log shows that the tables are generated.
```shell
Feb 23, 2025 12:42:59 PM liquibase.changelog
INFO: Reading resource: src/main/resources/db/changelog/migration/db.changelog-1.xml
Feb 23, 2025 12:42:59 PM liquibase.changelog
INFO: Creating database history table with name: public.databasechangelog
Feb 23, 2025 12:42:59 PM liquibase.changelog
INFO: Reading from public.databasechangelog
Feb 23, 2025 12:42:59 PM liquibase.command
INFO: Using deploymentId: 0310979670
Feb 23, 2025 12:42:59 PM liquibase.changelog
INFO: Reading from public.databasechangelog
Running Changeset: src/main/resources/db/changelog/migration/db.changelog-1.xml::1::yourname
Feb 23, 2025 12:42:59 PM liquibase.changelog
INFO: Table customers created
Feb 23, 2025 12:42:59 PM liquibase.changelog
```

In directory `target/generated-sources/jooq` you can also find the generated jOOQ files which are generated.

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/add-liquibase-scripts).

## Generate Domain Model
In this section, the domain model will be generated.

### Prompt
Open the Liquibase migration script and enter the prompt.
```text
Create a domain model based on this liquibase migration script
```

### Response
The response can be viewed [here](responses/3-domain-model.md).

### Apply Response
Create class `Customer` in package `com.mydeveloperplanet.myaicodeprojectplanet.model`. This clashes with the OpenAPI domain model package.

Change the following lines in the pom.xml:
```xml
<packageName>com.mydeveloperplanet.myaicodeprojectplanet</packageName>
<apiPackage>com.mydeveloperplanet.myaicodeprojectplanet.api</apiPackage>
<modelPackage>com.mydeveloperplanet.myaicodeprojectplanet.model</modelPackage>
```
Into:
```xml
<packageName>com.mydeveloperplanet.myaicodeprojectplanet.openapi</packageName>
<apiPackage>com.mydeveloperplanet.myaicodeprojectplanet.openapi.api</apiPackage>
<modelPackage>com.mydeveloperplanet.myaicodeprojectplanet.openapi.model</modelPackage>
```

Run the build, the build is successful.

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/add-domain-model).

## Generate Repository
In this section, the repository will be generated.

### Prompt
Add the full project and also add the generated jOOQ classes from the directory `target/generated-sources/jooq` to the Prompt Context. Note: later it seemed that DevoxxGenie did not add these files at all because they were ignored in the `.gitignore` file and that seems to have a higher priority.
```text
Generate a CustomerRepository in order that the operations defined in the openapi spec customers.yaml are supported
```

### Response
The response can be viewed [here](responses/4-1-repository).

The response uses Spring Data JPA and this is not what is wanted. 

### Prompt
Give explicit instructions to only use dependencies in the pom.xml.
```text
Generate a CustomerRepository in order that the operations defined in the openapi spec customers.yaml are supported.
Only use dependencies available in the pom.xml
```

### Response
The response can be viewed [here](responses/4-2-repository).

The same response is returned. The instructions are ignored.

### Prompt
Let's be more specific. Enter the prompt.
```text
You do not use the dependencies defined in the pom. You should use jooq instead of jpa
```

### Response
The response can be viewed [here](responses/4-3-repository).

### Apply Response
This response looks great. Even an example of how to use it in a Service is added.

Create a package `com/mydeveloperplanet/myaicodeprojectplanet/repository` and paste the `CustomerRepository` code. Some issues are present:
* A `RuntimeException` is thrown when a Customer cannot be found. Probably this needs to be changed, but for the moment this will do.
* The package `com.mydeveloperplanet.myaicodeprojectplanet.jooq` could not be found. A Maven Sync solved this issue.
* `Customers.CUSTOMER` could not be found. The following line needed to be added `import com.mydeveloperplanet.myaicodeprojectplanet.jooq.tables.Customers;`
* Still two compile errors remain due to a non-existing `exists()` method.
```java
if (dslContext.selectFrom(Customers.CUSTOMERS)
              .where(Customers.CUSTOMERS.ID.eq(id))
              .exists())
```

### Prompt
Open a new chat window. Open the `CustomerRepository` file and enter the prompt.
```text
the .exists() method does not seem to be available, fix the code
```

### Response
The response can be viewed [here](responses/4-4-repository.md).

### Apply Response
The response suggests to use the `selectExists` method, but also this method is non-existing.

### Prompt
Enter the follow-up prompt.
```text
the selectExists method is also not available, fix the code properly
```

### Response
The response can be viewed [here](responses/4-5-repository.md).

### Apply Response
The response suggests to use the `fetchExists` method. This is already closer to the real solution, but still does not compile. The LLM suggests to use:
```java
boolean exists = dslContext.selectFrom(Customers.CUSTOMERS)
                           .where(Customers.CUSTOMERS.ID.eq(id))
                           .fetchExists();
```
Time to help a little bit and change it manually to the correct implementation.
```java
boolean exists = dslContext.fetchExists(dslContext.selectFrom(Customers.CUSTOMERS));
```

Run the build, the build is successful.

### Prompt
In the current implementation, the repository methods use the jOOQ generated `CustomersRecord` as an argument. This means that the service layer would need to know about the repository layer and this is not correct. The service layer should know only the domain model.

Open a new chat window, add the `src` directory to the Prompt Context and also the generated jOOQ classes from the directory `target/generated-sources/jooq`. Enter the prompt.
```text
I want that the methods make use of the Customer model and that any mappings 
between Customer and CustomerRecord are done in the CustomerRepository itself
```

### Response
The response can be viewed [here](responses/4-6-repository.md).

### Apply Response
This looks great. Some variables, arguments are called `record` and this is a reserved word. Change this in `customerRecord`.

Run the build, the build is successful.

This took a bit longer than the previous generations, but the end result is quite good.

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/add-repository).

### Generate Service
In this section, the service will be generated.

### Prompt
Open a new chat window and add the full project to the Prompt Context. Enter the prompt.
```text
Create a spring service in order that the operations defined in the openapi spec customers.yaml are supported. 
The service must use the CustomerRepository.
```

### Response
The response can be viewed [here](responses/5-service.md).

### Apply Response
The response looks good. Also a Service Interface is created, which is not really needed.

Create package `com/mydeveloperplanet/myaicodeprojectplanet/service` and add the Service class and interface.

Run the build, the build is successful.

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/add-service).

## Generate Controller
In this section, the controller will be generated.

### Prompt
Open a new chat window, add the `src` directory and the `target/generated-sources/openapi/src` directory to the Prompt Context. Enter the prompt.
```text
Create a Spring Controller in order that the operations defined in the openapi spec customers.yaml are supported. 
The controller must implement CustomersApi. 
The controller must use the CustomersService.
```

### Response
The response can be viewed [here](responses/6-1-controller.md).

### Apply Response
The response looks good. Create the package `com/mydeveloperplanet/myaicodeprojectplanet/controller` and add the controller to this package. Some issues exist:
* The import for `CustomersApi` is missing, add it.
* The arguments in the methods use the `Customer` domain model which is not correct. It should use the OpenAPI `Customer` model.

### Prompt
Enter a follow-up prompt.
```text
The interface is not correctly implemented. 
The interface must use the openapi Customer model and 
must convert it to the Customer domain model which is used by the service.
```

### Response
The response can be viewed [here](responses/6-2-controller.md).

### Apply Response
The response is not correct. The LLM seems does not seem to see the difference between the `Customer` domain model and the `Customer` OpenAPI model.

There is also a strange non-existing Java syntax in the response.
```java
import com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer as OpenAPICustomer;
```

### Prompt
Enter a follow-up prompt.
```text
This is not correct. 
Try again, the openai Customer model is available in package com.mydeveloperplanet.myaicodeprojectplanet.openapi.model, 
the domain model is available in package com.mydeveloperplanet.myaicodeprojectplanet.model
```

### Response
The response can be viewed [here](responses/6-3-controller.md).

This response is identical to the previous one.

Let's help the LLM a little bit. Fix the methods and replace `OpenAPICustomer` with `com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer`.

This still raises compile errors, but maybe the LLM can fix this.

### Prompt
Open a new chat window, add the `src` directory and the `target/generated-sources/openapi/src` directory to the Prompt Context. Enter the prompt.
```text
The CustomersController has the following compile errors:
* customersGet return value is not correct
* customersIdGet return value is not correct
Fix this
```

### Response
The response can be viewed [here](responses/6-4-controller.md).

### Apply Response
This seems to be a better solution. Only the following snippet does not compile.
```java
private com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer convertToOpenAPIModel(Customer customer) {
    return new com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer(
            customer.getId(),
            customer.getFirstName(),
            customer.getLastName()
    );
}
```
Let's fix this manually.
```java
private com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer convertToOpenAPIModel(Customer customer) {
    com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer openAPICustomer = 
            new com.mydeveloperplanet.myaicodeprojectplanet.openapi.model.Customer();
    openAPICustomer.setId(customer.getId());
    openAPICustomer.setFirstName(customer.getFirstName());
    openAPICustomer.setLastName(customer.getLastName());
    return openAPICustomer;
}
```

Run the build, the build is successful.

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/add-controller).

## Run Application
Time to run the application.

Add the following dependency in order to start a PostgreSQL database when running the application.
```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-docker-compose</artifactId>
	<scope>runtime</scope>
	<optional>true</optional>
</dependency>
```

Add a `compose.yaml` file to the root of the repository.
```yaml
services:
  postgres:
    image: 'postgres:17-alpine'
    environment:
      - 'POSTGRES_DB=mydatabase'
      - 'POSTGRES_PASSWORD=secret'
      - 'POSTGRES_USER=myuser'
    labels:
      - "org.springframework.boot.service-connection=postgres"
    ports:
      - '5432'
```

Run the application.
```shell
mvn spring-boot:run
```

An error occurs.
```shell
2025-02-23T15:29:27.478+01:00 ERROR 33602 --- [MyAiCodeProjectPlanet] [           main] o.s.b.d.LoggingFailureAnalysisReporter   : 

***************************
APPLICATION FAILED TO START
***************************

Description:

Liquibase failed to start because no changelog could be found at 'classpath:/db/changelog/db.changelog-master.yaml'.

Action:

Make sure a Liquibase changelog is present at the configured path.

[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  19.530 s
[INFO] Finished at: 2025-02-23T15:29:27+01:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.springframework.boot:spring-boot-maven-plugin:3.4.3:run (default-cli) on project myaicodeprojectplanet: Process terminated with exit code: 1 -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
```

This can be fixed by adding the following line into the `application.properties` file.
```properties
spring.liquibase.change-log=classpath:db/changelog/db.changelog-root.xml
```

Run the application and now it starts successfully.

## Test Application
The application runs, but is it also functional?

### Prompt
Open a new chat window and open the OpenAPI specification. Enter the prompt.
```text
Generate some curl commands in order to test this openapi spec
```

### Response
The response can be viewed [here](responses/7-tests.md).

### Run Tests
Create a Customer.
```shell
curl -X POST "http://localhost:8080/customers" -H "Content-Type: application/json" -d '{
  "firstName": "John",
  "lastName": "Doe"
}'
{"timestamp":"2025-02-23T14:33:11.903+00:00","status":404,"error":"Not Found","path":"/customers"}
```
This test fails. The cause is that the `CustomerController` has the following unnecessary annotation.
```java
@RequestMapping("/customers")
```
This should not be here, this is already part of the `CustomersApi` interface.

Remove this line, build the application and run it again.

The changes can be viewed [here](https://github.com/mydeveloperplanet/myaicodeprojectplanet/tree/feature/run-application).

Create a Customer. This is successful.
```shell
curl -X POST "http://localhost:8080/customers" -H "Content-Type: application/json" -d '{
  "firstName": "John",
  "lastName": "Doe"
}'
```

Retrieve a Customer. This is successful.
```shell
curl -X GET "http://localhost:8080/customers/1" -H "accept: application/json"
{"id":1,"firstName":"John","lastName":"Doe"}
```

Update a Customer. This is successful.
```shell
curl -X PUT "http://localhost:8080/customers/1" -H "Content-Type: application/json" -d '{
  "id": 1,
  "firstName": "Jane",
  "lastName": "Doe"
}'
```

Retrieve all Customers. This is successful.
```shell
curl -X GET "http://localhost:8080/customers" -H "accept: application/json"
[{"id":1,"firstName":"Jane","lastName":"Doe"}]
```

Delete a Customer. This is successful.
```shell
curl -X DELETE "http://localhost:8080/customers/1" -H "accept: application/json"
```

Retrieve all Customers. An empty list is returned. This is successful.
```shell
curl -X GET "http://localhost:8080/customers" -H "accept: application/json"
[]
```

## Conclusion
It is possible to create a Spring Boot application from scratch using a local LLM. Creating the repository and controller needed some extra iterations and manual interventions. However, the result is quite good: the application is functional and meets the initial requirements. 