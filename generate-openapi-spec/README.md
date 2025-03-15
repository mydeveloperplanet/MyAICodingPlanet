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
The response can be viewed [here](responses/1-generate-openapi-spec.md)

## Response Analysis
This is quite amazing. With only very limited information, a valid OpenAPI specification is created and this really makes sense.

The list of customers should have the ID's included in the response, but this is something you can easily add yourself.
