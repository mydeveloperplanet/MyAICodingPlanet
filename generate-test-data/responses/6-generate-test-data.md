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