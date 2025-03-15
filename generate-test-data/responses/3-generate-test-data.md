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