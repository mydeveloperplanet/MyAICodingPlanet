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
('Max', '2017-06-10', 10, 5); -- Other

INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Buddy', '2018-05-15', 1, 7), -- Dog
('Whiskers', '2017-03-20', 2, 7), -- Cat
('Tweety', '2016-11-10', 3, 11), -- Bird
('Nemo', '2019-08-05', 4, 11), -- Fish
('Bubbles', '2017-12-25', 5, 15), -- Reptile
('Fluffy', '2016-09-30', 6, 8), -- Small Mammal
('Rex', '2018-04-12', 7, 25), -- Large Mammal
('Goldie', '2019-07-01', 8, 20), -- Aquarium Fish
('Polly', '2016-10-05', 9, 20), -- Exotic Bird
('Max', '2017-06-18', 10, 1); -- Other

INSERT INTO pets (name, birth_date, type_id, owner_id) VALUES
('Buddy', '2018-05-15', 1, 29), -- Dog
('Whiskers', '2017-03-20', 2, 29), -- Cat
('Tweety', '2016-11-10', 3, 13), -- Bird
('Nemo', '2019-08-05', 4, 13), -- Fish
('Bubbles', '2017-12-25', 5, 8), -- Reptile
('Fluffy', '2016-09-30', 6, 8), -- Small Mammal
('Rex', '2018-04-12', 7, 9), -- Large Mammal
('Goldie', '2019-07-01', 8, 10), -- Aquarium Fish
('Polly', '2016-10-05', 9, 10), -- Exotic Bird
('Max', '2017-06-18', 10, 11); -- Other

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
