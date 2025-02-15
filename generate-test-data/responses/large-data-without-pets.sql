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
