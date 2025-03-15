# Generate Test Data

The goal is to generate testdata based on an SQL schema.

The final solution [branch](https://github.com/mydeveloperplanet/devoxxgenie-spring-petclinic/tree/feature-search-pets-final-new-solution) of the Spring Petclinic [generating a feature](../generate-feature/README.md) is used.  

The setup using PostgreSQL is needed. Some actions need to be taken for this.
* Run the PostgreSQL database. Start the following command from within the root of the repository.
    ```shell
    docker compose up -d
    ```
* Copy the contents of `src/main/resources/application-postgres.properties` and replace the following line in `src/main/resources/application.properties`:
    ```text
    database=h2
    ```
* Run the Spring Petclinic.
    ```shell
    mvn spring-boot:run
    ```

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
Add file [postgres-schema.sql](../generate-plantuml-from-sql/sources/postgres-schema.sql) to the Prompt Context and enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database
```

## Response
The response can be viewed [here](responses/1-generate-test-data.md)

## Response Analysis

Using a visual check, this seems to be ok. But, the proof of the pudding is in the eating, so let's use the data.

* Shut down the Spring Petclinic and PostgreSQL container (`docker compose down`).
* Copy the suggested test data in file `src/main/resources/db/postgres/data.sql`
* Start the PostgreSQL container and Spring Boot application.

The test data is correct and complete.

## Prompt
Let's see whether we can make the test data more specific and add some more criteria.

Start a new chat window and add the file again to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database.
I want at least 5 vets, 30 owners, 10 different types of pets. 
Each owner must have at least one pet, some owners have more than one pet.
```

## Response
The response can be viewed [here](responses/2-generate-test-data.md)

## Response Analysis

Mediocre response and incomplete.
* 5 vets are added.
* 9 different types of pets are added instead of 10.
* One owner is added with one pet.
* A second owner is added with two pets.
* The pet names are not very creative (Pet1, Pet2, Pet3). Same applies to the owners.

After this, some tests were performed using a higher temperature, but the SQL statements were not correct anymore and the data was incomplete.

## Prompt
Let's try to split it up in smaller tasks.

First, let's create the vets. Start a new chat window and add the file to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database.
 I want at least 5 vets, exactly three specialties and every vet must have at least one specialty
```

## Response
The response can be viewed [here](responses/3-generate-test-data.md)

## Response Analysis
The vets, specialties and vet specialties are created as asked. This is good.

## Prompt
Let's create the type of pets.

Start a new chat window and add the file to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database. 
I want 10 different types of pets. Nothing else needs to be generated.
```

## Response
The response can be viewed [here](responses/4-generate-test-data.md)

## Response Analysis
This response was remarkably faster than the previous one. Ten pet types are provided.

## Prompt
Let's create 30 owners.

Start a new chat window and add the file to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database.
I want 30 owners. Nothing else needs to be generated.
```

## Response
The response can be viewed [here](responses/5-generate-test-data.md)

## Response Analysis
29 owners are provided, one is missing, but the data seems to be ok.

## Prompt
Let's create at least one pet for each owner.

All data is gathered in file [large-data-without-pets.sql](responses/large-data-without-pets.sql)

Start a new chat window and add the schema file and the sql file from above to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database.
The data in large-data-without-pets.sql is already available. 
Generate for each owner at least one pet. Nothing else needs to be generated.
```

## Response
The response can be viewed [here](responses/6-generate-test-data.md)

## Response Analysis
50 pets are created. However, owner ID's higher than 29 are used, even up to and including 50. When you omit these, or assign them to existing owners, the data is usable.

File [large-data-with-pets.sql](responses/large-data-with-pets.sql) contains a fixed version.

## Prompt
The only thing we are missing are some visits.

All data up till now is gathered in file [large-data-with-pets.sql](responses/large-data-with-pets.sql)

Start a new chat window and add the schema file and the sql file from above to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database. 
The data in large-data-with-pets.sql is already available. 
Generate 20 visits. Nothing else needs to be generated.
```

## Response
The response can be viewed [here](responses/7-generate-test-data.md)

## Response Analysis
The LLM created 20 visits for the first 20 pets. It is not very creative because it just took the first 20 pets, but it did what was asked.

The data is gathered in file [large-data-with-visits.sql](responses/large-data-with-visits.sql). Copy and paste it in the data.sql file of the Spring Petclinic. Start the database container and the Spring PetClinic application. All data is available for use.

Generating test data with an LLM can save you a lot of time. Dependent of the capabilities of your LLM, it is wise to split it into smaller tasks for better results.
