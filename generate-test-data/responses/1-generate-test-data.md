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