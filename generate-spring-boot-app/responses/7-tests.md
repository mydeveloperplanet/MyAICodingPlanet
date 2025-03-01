Here are some `curl` commands to test the endpoints defined in your OpenAPI specification:

### Retrieve a list of customers
```sh
curl -X GET "http://localhost:8080/customers" -H "accept: application/json"
```

### Create a new customer
```sh
curl -X POST "http://localhost:8080/customers" -H "Content-Type: application/json" -d '{
  "firstName": "John",
  "lastName": "Doe"
}'
```

### Retrieve a single customer by ID
```sh
curl -X GET "http://localhost:8080/customers/1" -H "accept: application/json"
```

### Update an existing customer
```sh
curl -X PUT "http://localhost:8080/customers/1" -H "Content-Type: application/json" -d '{
  "id": 1,
  "firstName": "Jane",
  "lastName": "Doe"
}'
```

### Delete a customer
```sh
curl -X DELETE "http://localhost:8080/customers/1" -H "accept: application/json"
```

Make sure to replace `http://localhost:8080` with the actual URL where your API is running.