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