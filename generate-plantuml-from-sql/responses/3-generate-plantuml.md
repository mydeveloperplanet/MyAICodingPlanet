To correct the cardinality and ensure that all relationships are properly drawn in the PlantUML diagram, you can adjust the code as follows:

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

@enduml
```

In this updated code:
- The `VetSpecialties` table is correctly linked to both `Vets` and `Specialties`.
- The `Pets` table is linked to the `Visits` table with a one-to-many relationship, indicating that each pet can have multiple visits.

This should ensure that all relationships are properly drawn and the cardinality is correct.