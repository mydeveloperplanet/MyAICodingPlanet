# Generate Feature

Can AI generate a new feature? 

In the [Spring Petclinic](https://github.com/spring-projects/spring-petclinic) you can search for the owners.

The starting point is this [main branch](https://github.com/mydeveloperplanet/devoxxgenie-spring-petclinic/tree/feature/search-pets-local-llm-gpu-main)

Run it as follows:
```shell
mvn spring-boot:run
```

![Find Owners](sources/spring-petclinic-find-owners.png)

Search for 'Franklin'

![Results](sources/spring-petclinic-find-owners-results.png)

Now you would like to have similar functionality for finding pets.

## Setup
LMStudio, qwen2.5-coder, GPU. With this setup, it was not possible to add the entire source directory to the prompt due to the hardware limit.
Instead, this task is executed by means of Anthropic using model Claude 3.5 Sonnet.

## Prompt
Add the project to the prompt context and enter the prompt.
```text
create a search pet functionality, similar as searching for owners, generate the code for it
```

## Response

---

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

---

## Response Analysis

The suggested changes seem to be ok. These are applied in this [branch](https://github.com/mydeveloperplanet/devoxxgenie-spring-petclinic/tree/feature-search-pets-first-response-new-solution)

After applying the changes, you also need to format the files.
```shell
spring-javaformat:apply
```

However, when you run the application and click the 'Find Pets' menu item, an exception occurs.

## Prompt
Enter the prompt.

```text
    the following error occurs:
    ```
    2025-02-01T11:31:46.013+01:00 ERROR 29216 --- [nio-8080-exec-3] org.thymeleaf.TemplateEngine             : [THYMELEAF][http-nio-8080-exec-3] Exception processing template "pets/petsList": Exception evaluating SpringEL expression: "pet.owner.id" (template: "pets/petsList" - line 22, col 10)
    
    org.thymeleaf.exceptions.TemplateProcessingException: Exception evaluating SpringEL expression: "pet.owner.id" (template: "pets/petsList" - line 22, col 10)
    ```
```

## Response

---

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

---

## Response Analysis
When you apply the suggested fixes and run the application, again an exception occurs.

## Prompt
Enter the prompt.

```text
    the following eror occurs
    ```
    Caused by: org.hibernate.query.sqm.UnknownPathException: Could not resolve attribute 'owner' of 'org.springframework.samples.petclinic.owner.Pet' [SELECT DISTINCT pet FROM Pet pet LEFT JOIN FETCH pet.owner WHERE LOWER(pet.name) LIKE LOWER(CONCAT('%', :name, '%'))]
    at org.hibernate.query.hql.internal.StandardHqlTranslator.translate(StandardHqlTranslator.java:88) ~[hibernate-core-6.6.2.Final.jar:6.6.2.Final]
    at org.hibernate.query.internal.QueryInterpretationCacheStandardImpl.createHqlInterpretation(QueryInterpretationCacheStandardImpl.java:145) ~[hibernate-core-6.6.2.Final.jar:6.6.2.Final]
    at org.hibernate.query.internal.QueryInterpretationCacheStandardImpl.resolveHqlInterpretation(QueryInterpretationCacheStandardImpl.java:132) ~[hibernate-core-6.6.2.Final.jar:6.6.2.Final]
    at org.hibernate.query.spi.QueryEngine.interpretHql(QueryEngine.java:54) ~[hibernate-core-6.6.2.Final.jar:6.6.2.Final]
    at org.hibernate.internal.AbstractSharedSessionContract.interpretHql(AbstractSharedSessionContract.java:831) ~[hibernate-core-6.6.2.Final.jar:6.6.2.Final]
    at org.hibernate.internal.AbstractSharedSessionContract.createQuery(AbstractSharedSessionContract.java:877) ~[hibernate-core-6.6.2.Final.jar:6.6.2.Final]
    ... 57 common frames omitted
    ```
```

## Response

---

This error occurs because Hibernate cannot find the `owner` property in the `Pet` class. Looking at the code, I notice that the `Pet` class is imported from `org.springframework.samples.petclinic.owner.Pet` in the `PetRepository`, but there seems to be no explicit owner relationship defined in the `Pet` class.

Here's how to fix this:

1. First, modify the `Pet` class to include the owner relationship:

```java
@Entity
@Table(name = "pets")
public class Pet extends NamedEntity {

    @Column(name = "birth_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthDate;

    @ManyToOne
    @JoinColumn(name = "owner_id")
    private Owner owner;

    @ManyToOne
    @JoinColumn(name = "type_id")
    private PetType type;

    // Add getter and setter for owner
    public Owner getOwner() {
        return owner;
    }

    public void setOwner(Owner owner) {
        this.owner = owner;
    }

    // ... rest of the existing code
}
```

2. Then, update the query in `PetRepository.java` to ensure it uses the correct join:

```java
public interface PetRepository extends Repository<Pet, Integer> {

    @Query("SELECT DISTINCT pet FROM Pet pet LEFT JOIN FETCH pet.owner WHERE LOWER(pet.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    Page<Pet> findByNameContainingIgnoreCase(String name, Pageable pageable);

}
```

The key changes are:

1. Added the `@ManyToOne` relationship to the `Pet` class to properly map the owner relationship
2. Added the `@JoinColumn` annotation to specify the foreign key column
3. Added getter and setter methods for the owner property

This should resolve the Hibernate error as it will now be able to find and properly map the owner relationship in the Pet entity.

The error occurred because the JPQL query was trying to join with `pet.owner`, but the `owner` property wasn't properly defined in the `Pet` entity class. By adding the proper JPA annotations and the owner field, we establish the relationship that the query expects.

---

## Response Analysis
The suggested changes seem to be ok. These are applied in this [branch](https://github.com/mydeveloperplanet/devoxxgenie-spring-petclinic/tree/feature-search-pets-final-new-solution)

This time, the functionality is working as expected.

A new menu item is added
![Find Pets](sources/spring-petclinic-find-pets-menu.png)

Find all pets
![Find All Pets](sources/spring-petclinic-find-all-pets.png)

Find one specific pet
![Find One Specific Pet](sources/spring-petclinic-find-one-pet.png)


## End Conclusion
Are we able to create a new feature using AI? Well, yes, it was successful in the end, after a few iterations. 
We did hit the limit of a local LLM and the hardware.