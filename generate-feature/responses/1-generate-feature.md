I'll help you create a search pet functionality similar to the owner search. Here's the code you'll need to add:

1. First, create a new controller class `PetSearchController.java` in the `pet` package:

```java
package org.springframework.samples.petclinic.owner;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
class PetSearchController {

    private final PetRepository pets;

    private static final int PAGE_SIZE = 5;

    public PetSearchController(PetRepository pets) {
        this.pets = pets;
    }

    @GetMapping("/pets/find")
    public String initFindForm(Model model) {
        model.addAttribute("pet", new Pet());
        return "pets/findPets";
    }

    @GetMapping("/pets")
    public String processFindForm(@RequestParam(defaultValue = "1") int page, Pet pet, BindingResult result, Model model) {
        // allow parameterless GET request for /pets to return all records
        if (pet.getName() == null) {
            pet.setName(""); // empty string signifies broadest possible search
        }

        // find pets by name
        Page<Pet> petsResults = findPaginatedForPetsName(page, pet.getName());
        if (petsResults.isEmpty()) {
            // no pets found
            result.rejectValue("name", "notFound", "not found");
            return "pets/findPets";
        }

        model.addAttribute("listPets", petsResults.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", petsResults.getTotalPages());
        model.addAttribute("totalItems", petsResults.getTotalElements());
        return "pets/petsList";
    }

    private Page<Pet> findPaginatedForPetsName(int page, String name) {
        Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE);
        return pets.findByNameContainingIgnoreCase(name, pageable);
    }
}
```

2. Create a new repository interface `PetRepository.java`:

```java
package org.springframework.samples.petclinic.owner;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.Repository;

public interface PetRepository extends Repository<Pet, Integer> {
    Page<Pet> findByNameContainingIgnoreCase(String name, Pageable pageable);
}
```

3. Create a new template `findPets.html` in `src/main/resources/templates/pets/`:

```html
<html xmlns:th="https://www.thymeleaf.org"
  th:replace="~{fragments/layout :: layout (~{::body},'pets')}">

<body>
  <h2>Find Pets</h2>

  <form th:object="${pet}" th:action="@{/pets}" method="get"
    class="form-horizontal" id="search-pet-form">
    <div class="form-group">
      <div class="control-group" id="nameGroup">
        <label class="col-sm-2 control-label">Pet name </label>
        <div class="col-sm-10">
          <input class="form-control" th:field="*{name}" size="30"
            maxlength="80" /> 
          <span class="help-inline">
            <div th:if="${#fields.hasAnyErrors()}">
              <p th:each="err : ${#fields.allErrors()}" th:text="${err}">Error</p>
            </div>
          </span>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-primary">Find Pet</button>
      </div>
    </div>
  </form>
</body>
</html>
```

4. Create a new template `petsList.html` in `src/main/resources/templates/pets/`:

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
          <a th:href="@{/owners/__${pet.owner.id}__}" th:text="${pet.owner?.firstName + ' ' + pet.owner?.lastName}"/></a>
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

5. Add a new menu item in `layout.html` under the navigation section:

```html
<li th:replace="~{::menuItem ('/pets/find','pets','find pets','search','Find pets')}">
  <span class="fa fa-search" aria-hidden="true"></span>
  <span>Find pets</span>
</li>
```

This implementation provides:
- A search form to find pets by name
- Case-insensitive partial name matching
- Pagination of results
- Links to pet owners
- Similar look and feel to the owner search functionality

The search will:
1. Allow empty searches to show all pets
2. Show "not found" message when no pets match the search criteria
3. Display results in a paginated table
4. Show pet details including name, birth date, type and owner
5. Provide navigation links to the pet's owner details

To use this functionality:
1. Click on "Find pets" in the navigation menu
2. Enter a pet name (or partial name)
3. Click "Find Pet" to search
4. View results in the paginated table
5. Click on owner names to view owner details

The search is case-insensitive and will match partial names, making it easy to find pets even with incomplete information.