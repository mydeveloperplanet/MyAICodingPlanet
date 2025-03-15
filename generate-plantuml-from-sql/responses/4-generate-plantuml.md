To include the missing relationships between `Owners` and `Pets`, as well as between `Owners` and `Types`, you can update the PlantUML code as follows:

```plantuml
@startuml

entity Vets {
  +id: INT [PK]
  +first_name: TEXT
  +last_name: TEXT
}

entity Specialties {
  +id: INT [PK]
  +name: TEXT
}

entity VetSpecialties {
  +vet_id: INT [PK, FK] -- vets(id)
  +specialty_id: INT [PK, FK] -- specialties(id)
}

entity Types {
  +id: INT [PK]
  +name: TEXT
}

entity Owners {
  +id: INT [PK]
  +first_name: TEXT
  +last_name: TEXT
  +address: TEXT
  +city: TEXT
  +telephone: TEXT
}

entity Pets {
  +id: INT [PK]
  +name: TEXT
  +birth_date: DATE
  +type_id: INT [FK] -- types(id)
  +owner_id: INT [FK] -- owners(id)
}

entity Visits {
  +id: INT [PK]
  +pet_id: INT [FK] -- pets(id)
  +visit_date: DATE
  +description: TEXT
}

Vets ||--o{ VetSpecialties : has
Specialties ||--o{ VetSpecialties : has
Pets *--o{ Visits : has
Owners *--o{ Pets : owns
Owners *--o{ Types : uses

@enduml
```

In this updated code:
- The `Owners` table is linked to the `Pets` table with a one-to-many relationship, indicating that each owner can have multiple pets.
- The `Owners` table is also linked to the `Types` table with a one-to-many relationship, indicating that each owner can use multiple types.

This should include all the necessary relationships in your PlantUML diagram.