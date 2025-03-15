You're right. Let me correct the PlantUML diagram using proper IE notation:

```plantuml
@startuml

' hide the spot
hide circle

' avoid problems with angled crows feet
skinparam linetype ortho

entity "vets" {
  *id : INT <<generated>>
  --
  first_name : TEXT
  last_name : TEXT
}

entity "specialties" {
  *id : INT <<generated>>
  --
  name : TEXT
}

entity "vet_specialties" {
  --
  *vet_id : INT <<FK>>
  *specialty_id : INT <<FK>>
}

entity "types" {
  *id : INT <<generated>>
  --
  name : TEXT
}

entity "owners" {
  *id : INT <<generated>>
  --
  first_name : TEXT
  last_name : TEXT
  address : TEXT
  city : TEXT
  telephone : TEXT
}

entity "pets" {
  *id : INT <<generated>>
  --
  name : TEXT
  birth_date : DATE
  *type_id : INT <<FK>>
  *owner_id : INT <<FK>>
}

entity "visits" {
  *id : INT <<generated>>
  --
  *pet_id : INT <<FK>>
  visit_date : DATE
  description : TEXT
}

' Relationships
vets ||..|| vet_specialties
specialties ||..|| vet_specialties
types ||..o{ pets
owners ||..o{ pets
pets ||..o{ visits

@enduml
```

Key changes made:
1. Used proper `entity` instead of `table`
2. Added proper IE notation for relationships using `||..||` and `||..o{`
3. Marked primary keys and foreign keys with proper notation
4. Used `*` to denote mandatory fields
5. Added `<<generated>>` for auto-generated IDs
6. Added `<<FK>>` for foreign keys
7. Used `--` to separate primary keys from other fields
8. Added proper skinparam settings for IE notation

This diagram now correctly follows the Information Engineering notation standards while representing your database schema.