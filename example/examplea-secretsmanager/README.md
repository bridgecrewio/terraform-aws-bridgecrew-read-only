# Adding the secret

```cli
aws secretsmanager create-secret --name /bridgecrew/api_token
aws secretsmanager put-secret-value --secret-id /bridgecrew/api_token --secret-string <your_token>
```
