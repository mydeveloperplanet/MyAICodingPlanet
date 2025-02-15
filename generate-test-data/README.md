# Generate Test Data

The goal is to generate testdata based on an SQL schema.

The final solution [branch](https://github.com/mydeveloperplanet/devoxxgenie-spring-petclinic/tree/feature-search-pets-final-new-solution) of the Spring PetClinic [generating a feature](../generate-feature/README.md) is used.  

The setup using PostgreSQL is needed. Some actions need to be taken for this.
* Run the PostgreSQL database. Start the following command from within the root of the repository.
    ```shell
    docker compose up -d
    ```
* Copy the contents of `src/main/resources/application-postgres.properties` and replace the following line in `src/main/resources/application.properties`:
    ```text
    database=h2
    ```
* Run the Spring PetClinic.
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

---

Certainly! Below is an example of test data that you can insert into your PostgreSQL database using SQL commands. This data includes entries for `vets`, `specialties`, `vet_specialties`, `types`, `owners`, `pets`, and `visits`.

```sql
-- Inserting data into the vets table
INSERT INTO vets (first_name, last_name) VALUES ('John', 'Doe');
INSERT INTO vets (first_name, last_name) VALUES ('Jane', 'Smith');

-- Inserting data into the specialties table
INSERT INTO specialties (name) VALUES ('Cardiology');
INSERT INTO specialties (name) VALUES ('Surgery');
INSERT INTO specialties (name) VALUES ('Radiology');

-- Inserting data into the vet_specialties table
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (1, 1);
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (2, 2);

-- Inserting data into the types table
INSERT INTO types (name) VALUES ('Cat');
INSERT INTO types (name) VALUES ('Dog');

-- Inserting data into the owners table
INSERT INTO owners (first_name, last_name, address, city, telephone)
VALUES ('Alice', 'Johnson', '123 Main St', 'Anytown', '555-1234');
INSERT INTO owners (first_name, last_name, address, city, telephone)
VALUES ('Bob', 'Brown', '456 Elm St', 'Othertown', '555-5678');

-- Inserting data into the pets table
INSERT INTO pets (name, birth_date, type_id, owner_id)
VALUES ('Whiskers', '2018-03-15', 1, 1);
INSERT INTO pets (name, birth_date, type_id, owner_id)
VALUES ('Buddy', '2020-07-20', 2, 2);

-- Inserting data into the visits table
INSERT INTO visits (pet_id, visit_date, description)
VALUES (1, '2023-04-01', 'Annual check-up');
INSERT INTO visits (pet_id, visit_date, description)
VALUES (2, '2023-05-15', 'Surgery for a broken leg');
```

You can run these SQL commands in your PostgreSQL database to populate the tables with test data. This will help you verify that your application is interacting correctly with the database.

---

## Response Analysis

Using a visual check, this seems to be ok. But, the proof of the pudding is in the eating, so let's use the data.

* Shut down the Spring PetClinic and PostgreSQL container (`docker compose down`).
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

---

To generate test data for your PostgreSQL schema, you can use the following SQL commands. This script will create 5 vets, 30 owners, and 10 different types of pets. It ensures that each owner has at least one pet, with some owners having more than one pet.

```sql
-- Insert 5 vets
INSERT INTO vets (first_name, last_name) VALUES ('John', 'Doe');
INSERT INTO vets (first_name, last_name) VALUES ('Jane', 'Smith');
INSERT INTO vets (first_name, last_name) VALUES ('Alice', 'Johnson');
INSERT INTO vets (first_name, last_name) VALUES ('Bob', 'Brown');
INSERT INTO vets (first_name, last_name) VALUES ('Charlie', 'Davis');

-- Insert 10 different types of pets
INSERT INTO types (name) VALUES ('Cat');
INSERT INTO types (name) VALUES ('Dog');
INSERT INTO types (name) VALUES ('Bird');
INSERT INTO types (name) VALUES ('Fish');
INSERT INTO types (name) VALUES ('Reptile');
INSERT INTO types (name) VALUES ('Hamster');
INSERT INTO types (name) VALUES ('Turtle');
INSERT INTO types (name) VALUES ('Rabbit');
INSERT INTO types (name) VALUES ('Guinea Pig');

-- Insert 30 owners with at least one pet
INSERT INTO owners (first_name, last_name, address, city, telephone)
VALUES ('Owner1', 'LastName1', 'Address1', 'City1', '1234567890');
INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES ('Pet1', '2020-01-01', 1, 1);

INSERT INTO owners (first_name, last_name, address, city, telephone)
VALUES ('Owner2', 'LastName2', 'Address2', 'City2', '0987654321');
INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES ('Pet2', '2020-02-01', 2, 2);
INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES ('Pet3', '2020-03-01', 3, 2);

-- Continue inserting owners and pets as needed to reach a total of 30 owners
```

You can continue this pattern to insert the remaining owners and their pets. Each owner will have at least one pet, and some may have more than one. Adjust the number of pets per owner as desired to meet your requirements.

---

## Response Analysis

Mediocre response and incomplete.
* 5 vets are added.
* 9 different types of pets are added instead of 10.
* One owner is added with one pet.
* A second owner is added with two pets.
* The pet names are not very creative (Pet1, Pet2, Pet3). Same applies to the owners.

After this, some tests were performed using a higher temperature, but the SQL statements were not correct anymore and the data was incomplet.

## Prompt
Let's try to split it up in smaller tasks.

First, let's create the vets. Start a new chat window and add the file to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database.
 I want at least 5 vets, exactly three specialties and every vet must have at least one specialty
```

## Response

---

Certainly! Below is an example of SQL commands that you can use to insert the required test data into your PostgreSQL database:

```sql
-- Inserting Vets
INSERT INTO vets (first_name, last_name) VALUES ('John', 'Doe');
INSERT INTO vets (first_name, last_name) VALUES ('Jane', 'Smith');
INSERT INTO vets (first_name, last_name) VALUES ('Alice', 'Johnson');
INSERT INTO vets (first_name, last_name) VALUES ('Bob', 'Brown');
INSERT INTO vets (first_name, last_name) VALUES ('Charlie', 'Davis');

-- Inserting Specialties
INSERT INTO specialties (name) VALUES ('Cardiology');
INSERT INTO specialties (name) VALUES ('Surgery');
INSERT INTO specialties (name) VALUES ('Dentistry');

-- Assigning Specialties to Vets
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (1, 1); -- John Doe - Cardiology
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (2, 2); -- Jane Smith - Surgery
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (3, 3); -- Alice Johnson - Dentistry
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (4, 1); -- Bob Brown - Cardiology
INSERT INTO vet_specialties (vet_id, specialty_id) VALUES (5, 2); -- Charlie Davis - Surgery

-- Inserting Types of Pets
INSERT INTO types (name) VALUES ('Cat');
INSERT INTO types (name) VALUES ('Dog');

-- Inserting Owners
INSERT INTO owners (first_name, last_name, address, city, telephone)
VALUES ('Owner1', 'LastName1', 'Address1', 'City1', '1234567890');
INSERT INTO owners (first_name, last_name, address, city, telephone)
VALUES ('Owner2', 'LastName2', 'Address2', 'City2', '0987654321');

-- Inserting Pets
INSERT INTO pets (name, birth_date, type_id, owner_id)
VALUES ('Fluffy', '2020-01-01', 1, 1);
INSERT INTO pets (name, birth_date, type_id, owner_id)
VALUES ('Buddy', '2019-05-15', 2, 2);

-- Inserting Visits
INSERT INTO visits (pet_id, visit_date, description)
VALUES (1, '2023-04-01', 'Annual check-up');
INSERT INTO visits (pet_id, visit_date, description)
VALUES (2, '2023-05-10', 'Dental cleaning');
```

This script will insert the required data into your PostgreSQL database. Make sure to run these commands in a transaction or within a script that handles any potential errors to maintain data integrity.

---

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

---

Certainly! Below is an example of SQL commands that you can use to insert 10 different types of pets into your PostgreSQL database:

```sql
INSERT INTO types (name) VALUES ('Dog');
INSERT INTO types (name) VALUES ('Cat');
INSERT INTO types (name) VALUES ('Bird');
INSERT INTO types (name) VALUES ('Fish');
INSERT INTO types (name) VALUES ('Reptile');
INSERT INTO types (name) VALUES ('Small Mammal');
INSERT INTO types (name) VALUES ('Large Mammal');
INSERT INTO types (name) VALUES ('Aquarium Fish');
INSERT INTO types (name) VALUES ('Exotic Bird');
INSERT INTO types (name) VALUES ('Other');
```

These commands will insert 10 different types of pets into the `types` table.

---

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

---

Certainly! Below is an example of SQL commands that you can use to insert 30 sample owner records into your PostgreSQL database:

```sql
INSERT INTO owners (first_name, last_name, address, city, telephone) VALUES
('John', 'Doe', '1234 Elm St', 'Springfield', '555-1234'),
('Jane', 'Smith', '5678 Oak St', 'Springfield', '555-5678'),
('Alice', 'Johnson', '9012 Pine St', 'Springfield', '555-9012'),
('Bob', 'Brown', '3456 Maple St', 'Springfield', '555-3456'),
('Charlie', 'Davis', '7890 Birch St', 'Springfield', '555-7890'),
('Diana', 'Miller', '1234 Cedar St', 'Springfield', '555-1234'),
('Eve', 'Wilson', '5678 Walnut St', 'Springfield', '555-5678'),
('Frank', 'Moore', '9012 Spruce St', 'Springfield', '555-9012'),
('Grace', 'Taylor', '3456 Oakwood St', 'Springfield', '555-3456'),
('Hank', 'Anderson', '7890 Pineview St', 'Springfield', '555-7890'),
('Ivy', 'Thomas', '1234 Maplewood St', 'Springfield', '555-1234'),
('Jack', 'Jackson', '5678 Birchwood St', 'Springfield', '555-5678'),
('Jill', 'White', '9012 Cedarwood St', 'Springfield', '555-9012'),
('Kim', 'Harris', '3456 Walnutwood St', 'Springfield', '555-3456'),
('Larry', 'Martin', '7890 Pinebrook St', 'Springfield', '555-7890'),
('Mia', 'Garcia', '1234 Oakbrook St', 'Springfield', '555-1234'),
('Nate', 'Martinez', '5678 Maplebrook St', 'Springfield', '555-5678'),
('Olivia', 'Robinson', '9012 Birchbrook St', 'Springfield', '555-9012'),
('Pete', 'Lee', '3456 Cedarbrook St', 'Springfield', '555-3456'),
('Quinn', 'Walker', '7890 Walnutbrook St', 'Springfield', '555-7890'),
('Rachel', 'Hall', '1234 Pinebrook St', 'Springfield', '555-1234'),
('Sam', 'Young', '5678 Oakbrook St', 'Springfield', '555-5678'),
('Tina', 'King', '9012 Maplebrook St', 'Springfield', '555-9012'),
('Uma', 'Lewis', '3456 Birchbrook St', 'Springfield', '555-3456'),
('Victor', 'Scott', '7890 Cedarbrook St', 'Springfield', '555-7890'),
('Wendy', 'Green', '1234 Walnutbrook St', 'Springfield', '555-1234'),
('Xander', 'Adams', '5678 Pinebrook St', 'Springfield', '555-5678'),
('Yara', 'Murphy', '9012 Oakbrook St', 'Springfield', '555-9012'),
('Zoe', 'Brown', '3456 Maplebrook St', 'Springfield', '555-3456');
```

You can run these commands in your PostgreSQL database to insert 30 sample owner records.

---

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

---

To generate test data for pets associated with each owner, you can use the following SQL commands:

```sql
-- Inserting Pets for Owners
INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Buddy', '2018-05-15', 1, 1), -- Dog
('Whiskers', '2017-03-20', 2, 2), -- Cat
('Tweety', '2016-11-10', 3, 3), -- Bird
('Nemo', '2019-08-05', 4, 4), -- Fish
('Bubbles', '2017-12-25', 5, 5), -- Reptile
('Fluffy', '2016-09-30', 6, 6), -- Small Mammal
('Rex', '2018-04-12', 7, 7), -- Large Mammal
('Goldie', '2019-07-01', 8, 8), -- Aquarium Fish
('Polly', '2016-10-05', 9, 9), -- Exotic Bird
('Max', '2017-06-18', 10, 10); -- Other

INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Molly', '2018-03-25', 1, 11), -- Dog
('Bella', '2017-04-10', 2, 12), -- Cat
('Charlie', '2016-12-05', 3, 13), -- Bird
('Daisy', '2019-09-20', 4, 14), -- Fish
('Leo', '2017-11-15', 5, 15), -- Reptile
('Benny', '2016-10-30', 6, 16), -- Small Mammal
('Simba', '2018-05-10', 7, 17), -- Large Mammal
('Spike', '2019-06-25', 8, 18), -- Aquarium Fish
('Peaches', '2016-07-30', 9, 19), -- Exotic Bird
('Benny', '2017-08-15', 10, 20); -- Other

INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Rocky', '2018-04-30', 1, 21), -- Dog
('Mittens', '2017-05-15', 2, 22), -- Cat
('Spike', '2016-11-20', 3, 23), -- Bird
('Bubbles', '2019-08-25', 4, 24), -- Fish
('Charlie', '2017-12-30', 5, 25), -- Reptile
('Fluffy', '2016-10-05', 6, 26), -- Small Mammal
('Rex', '2018-04-10', 7, 27), -- Large Mammal
('Goldie', '2019-07-15', 8, 28), -- Aquarium Fish
('Polly', '2016-10-30', 9, 29), -- Exotic Bird
('Max', '2017-06-10', 10, 30); -- Other

INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Buddy', '2018-05-15', 1, 31), -- Dog
('Whiskers', '2017-03-20', 2, 32), -- Cat
('Tweety', '2016-11-10', 3, 33), -- Bird
('Nemo', '2019-08-05', 4, 34), -- Fish
('Bubbles', '2017-12-25', 5, 35), -- Reptile
('Fluffy', '2016-09-30', 6, 36), -- Small Mammal
('Rex', '2018-04-12', 7, 37), -- Large Mammal
('Goldie', '2019-07-01', 8, 38), -- Aquarium Fish
('Polly', '2016-10-05', 9, 39), -- Exotic Bird
('Max', '2017-06-18', 10, 40); -- Other

INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Buddy', '2018-05-15', 1, 41), -- Dog
('Whiskers', '2017-03-20', 2, 42), -- Cat
('Tweety', '2016-11-10', 3, 43), -- Bird
('Nemo', '2019-08-05', 4, 44), -- Fish
('Bubbles', '2017-12-25', 5, 45), -- Reptile
('Fluffy', '2016-09-30', 6, 46), -- Small Mammal
('Rex', '2018-04-12', 7, 47), -- Large Mammal
('Goldie', '2019-07-01', 8, 48), -- Aquarium Fish
('Polly', '2016-10-05', 9, 49), -- Exotic Bird
('Max', '2017-06-18', 10, 50); -- Other
```

This SQL script will insert one pet for each owner listed in the `large-data-without-pets.sql` file. Each pet is associated with a different type from the `types` table.

---

## Response Analysis
50 pets are created. But, the LLM did not take into account the 29 owners. Also owner ID's higher than 29 are used, even up to and including 50. However, when you omit these, or assign them to existing owners, the data is usable.

File [large-data-with-pets.sql](responses/large-data-with-pets.sql) contains a fixed version.

## Prompt
Last thing we are missing are some visits.

All data up till now is gathered in file [large-data-with-pets.sql](responses/large-data-with-pets.sql)

Start a new chat window and add the schema file and the sql file from above to the Prompt Context. Enter the prompt.

```text
Generate test data which can be inserted by means of SQL commands in a postgres database. 
The data in large-data-with-pets.sql is already available. 
Generate 20 visits. Nothing else needs to be generated.
```

## Response

---

```sql
INSERT INTO visits (pet_id, visit_date, description) VALUES
(1, '2023-04-01', 'Annual check-up'),
(2, '2023-05-15', 'Spay surgery'),
(3, '2023-06-20', 'Dental cleaning'),
(4, '2023-07-25', 'Eye examination'),
(5, '2023-08-30', 'Vaccination boost'),
(6, '2023-09-10', 'Weight check'),
(7, '2023-10-15', 'Flea treatment'),
(8, '2023-11-20', 'Heartworm test'),
(9, '2023-12-25', 'Spaying'),
(10, '2024-01-30', 'Annual check-up'),
(11, '2024-02-28', 'Ear cleaning'),
(12, '2024-03-31', 'Vaccination boost'),
(13, '2024-04-29', 'Weight check'),
(14, '2024-05-27', 'Flea treatment'),
(15, '2024-06-25', 'Heartworm test'),
(16, '2024-07-23', 'Spaying'),
(17, '2024-08-21', 'Annual check-up'),
(18, '2024-09-19', 'Ear cleaning'),
(19, '2024-10-17', 'Vaccination boost'),
(20, '2024-11-15', 'Weight check');
```

---

## Response Analysis
The LLM created 20 visits for the first 20 pets. It is not very creative, but it just did what was asked.

The data is gathered in file [large-data-with-visits.sql](responses/large-data-with-visits.sql). Copy and paste it in the data.sql file of the Spring PetClinic. Start the database container and the Spring PetClinic application. All data is available for use.

Generating test data with an LLM can save you a lot of time. Dependent of the capabilities of your LLM, it is wise to split it into smaller tasks for better results.
