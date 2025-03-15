The error occurs because in the `pets/petsList.html` template, it's trying to access `pet.owner.id` but the owner property is not properly populated in the Pet objects being displayed.

Looking at the code, I can see that the `PetRepository` interface only returns basic Pet information without fetching the associated Owner data. Let's fix this by:

1. First, modify the `PetRepository` interface to fetch the owner data along with the pet data:

```java
package org.springframework.samples.petclinic.pet;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.samples.petclinic.owner.Pet;

public interface PetRepository extends Repository<Pet, Integer> {

    @Query("SELECT DISTINCT pet FROM Pet pet LEFT JOIN FETCH pet.owner WHERE LOWER(pet.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    Page<Pet> findByNameContainingIgnoreCase(String name, Pageable pageable);

}
```

2. Then, modify the `pets/petsList.html` template to handle potential null owners:

```html
<!DOCTYPE html>
<html xmlns:th="https://www.thymeleaf.org" th:replace="~{fragments/layout :: layout (~{::body},'pets')}">

<body>
<h2>Pets</h2>

<table id="pets" class="table table-striped">
  <thead>
  <tr>
    <th style="width: 150px;">Name</th>
    <th style="width: 200px;">Birth Date</th>
    <th>Type</th>
    <th>Owner</th>
  </tr>
  </thead>
  <tbody>
  <tr th:each="pet : ${listPets}">
    <td th:text="${pet.name}"/>
    <td th:text="${#temporals.format(pet.birthDate, 'yyyy-MM-dd')}"/>
    <td th:text="${pet.type}"/>
    <td>
      <a th:if="${pet.owner != null}" 
         th:href="@{/owners/__${pet.owner.id}__}" 
         th:text="${pet.owner?.firstName + ' ' + pet.owner?.lastName}">
      </a>
      <span th:if="${pet.owner == null}">No owner</span>
    </td>
  </tr>
  </tbody>
</table>

<div th:if="${totalPages > 1}">
  <span>Pages:</span>
  <span>[</span>
  <span th:each="i: ${#numbers.sequence(1, totalPages)}">
      <a th:if="${currentPage != i}" th:href="@{'/pets?page=' + ${i}}" th:text="${i}"></a>
      <span th:unless="${currentPage != i}" th:text="${i}"></span>
    </span>
  <span>]&nbsp;</span>
  <span>
      <a th:if="${currentPage > 1}" th:href="@{'/pets?page=1'}" title="First" class="fa fa-fast-backward"></a>
      <span th:unless="${currentPage > 1}" title="First" class="fa fa-fast-backward"></span>
    </span>
  <span>
      <a th:if="${currentPage > 1}" th:href="@{'/pets?page=__${currentPage - 1}__'}" title="Previous" class="fa fa-step-backward"></a>
      <span th:unless="${currentPage > 1}" title="Previous" class="fa fa-step-backward"></span>
    </span>
  <span>
      <a th:if="${currentPage < totalPages}" th:href="@{'/pets?page=__${currentPage + 1}__'}" title="Next" class="fa fa-step-forward"></a>
      <span th:unless="${currentPage < totalPages}" title="Next" class="fa fa-step-forward"></span>
    </span>
  <span>
      <a th:if="${currentPage < totalPages}" th:href="@{'/pets?page=__${totalPages}__'}" title="Last" class="fa fa-fast-forward"></a>
      <span th:unless="${currentPage < totalPages}" title="Last" class="fa fa-step-forward"></span>
    </span>
</div>
</body>
</html>
```

The key changes are:

1. Added a JOIN FETCH in the repository query to ensure the owner data is loaded along with the pet data
2. Added null checks in the template using `th:if` to handle cases where a pet might not have an owner
3. Used the safe navigation operator (`?.`) when accessing owner properties

These changes should resolve the error by ensuring that:
1. The owner data is properly loaded with the pets
2. The template gracefully handles cases where owner data might be missing