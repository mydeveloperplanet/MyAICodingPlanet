# Generate OpenAPI Specification

Can you generate an OpenAPI specification using AI?

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
Enter the following prompt.
```text
Generate an OpenAPI specification version 3.1.1. 
The spec should contain CRUD methods for customers. 
The customers have a first name and a last name. 
Use the Zalando restful api guidelines.
```

## Response

---

```yaml
openapi: 3.1.1
info:
  title: Customer Management API
  version: 1.0.0
paths:
  /customers:
    get:
      summary: Retrieve a list of customers
      responses:
        '200':
          description: A list of customers
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Customer'
    post:
      summary: Create a new customer
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Customer'
      responses:
        '201':
          description: Customer created successfully
  /customers/{id}:
    get:
      summary: Retrieve a single customer by ID
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: A single customer
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Customer'
    put:
      summary: Update an existing customer
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Customer'
      responses:
        '200':
          description: Customer updated successfully
    delete:
      summary: Delete a customer
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '204':
          description: Customer deleted successfully
components:
  schemas:
    Customer:
      type: object
      properties:
        firstName:
          type: string
        lastName:
          type: string
```

---

## Response Analysis
This is quite amazing. With only very limited information, a valid OpenAPI specification is created and this really makes sense.

The list of customers should have the ID's included in the response, but this is something you can easily add yourself.
