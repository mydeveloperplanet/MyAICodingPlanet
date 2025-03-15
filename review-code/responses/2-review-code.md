To adhere to security best practices, you should avoid hardcoding sensitive information like usernames and passwords directly in your YAML files. Instead, use Kubernetes Secrets to manage these credentials securely.

Here's how you can modify your `db.yml` file to use environment variables for the database credentials:

1. **Create a Secret**: First, create a Kubernetes Secret that contains the database credentials.
2. **Update the Deployment**: Use environment variables in the deployment to reference the values from the Secret.

### Step 1: Create a Secret

You can create a Secret using the `kubectl` command or by defining it directly in your YAML file. Here's an example of creating a Secret using `kubectl`:

```sh
kubectl create secret generic demo-db-secret \
  --from-literal=username=user \
  --from-literal=password=pass \
  --from-literal=database=petclinic
```

### Step 2: Update the Deployment

Update your `db.yml` file to use environment variables from the Secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-db-secret
type: Opaque
stringData:
  username: user
  password: pass
  database: petclinic

---
apiVersion: v1
kind: Service
metadata:
  name: demo-db
spec:
  ports:
    - port: 5432
  selector:
    app: demo-db

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-db
  labels:
    app: demo-db
spec:
  replicas: 1  # Ensure you have a replica for high availability
  selector:
    matchLabels:
      app: demo-db
  template:
    metadata:
      labels:
        app: demo-db
    spec:
      containers:
        - image: postgres:17
          name: postgresql
          env:
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: demo-db-secret
                  key: username
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: demo-db-secret
                  key: password
            - name: POSTGRES_DB
              valueFrom:
                secretKeyRef:
                  name: demo-db-secret
                  key: database
          ports:
            - containerPort: 5432
              name: postgresql
          resources:
            requests:
              memory: "64Mi"
              cpu: "250m"
            limits:
              memory: "128Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /health
              port: 5432
              initialDelaySeconds: 30
              periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /health
              port: 5432
              initialDelaySeconds: 30
              periodSeconds: 10
          startupProbe:
            tcpSocket:
              port: postgresql
              initialDelaySeconds: 10
              periodSeconds: 10
```

### Explanation:

- **Secret Creation**: The `demo-db-secret` Secret is created with the database credentials.
- **Deployment Update**: The deployment now references these credentials using environment variables and `secretKeyRef`.

By following this approach, you ensure that sensitive information is stored securely in Kubernetes Secrets and not exposed directly in your YAML files.