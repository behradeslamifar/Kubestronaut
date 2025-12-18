# ServiceAccounts

## Type of ServiceAccounts
- Bound Service Account Tokens
- TokenRequest API
- Legacy ServiceAccount Token

### Bound Service Account Tokens
create serviceaccount
```bash
kubectl create serviceaccount ckad
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-with-serviceaccount
  labels:
    role: front
    app: nginx
spec:
  serviceAccount: ckad
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
```

after pod creation check get the token
```
kubectl exec -ti web-with-serviceaccoutn -- bash
$ cat /var/run/secrets/kubernetes.io/serviceaccount/token
eyJhbGciOiJSUzI1NiIsImtpZCI6Imx4N1FmeHdsMGRIVFJyOW1ZQXV6b2lkcS1Wa0V0UUZHODVQRk1Edm1ZMVUifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzk3NjI3MjEwLCJpYXQiOjE3NjYwOTEyMTAsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiNzUxZmZjYjMtNzc5ZC00NmM2LWI4MzAtYWVlNTQ4MDMzMjc2Iiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJkZWZhdWx0Iiwibm9kZSI6eyJuYW1lIjoiY2thZC13b3JrZXIiLCJ1aWQiOiI1NGM4NzRhOC1lMmE1LTQ0MDUtODFhMS02NzQ0MDM0ZWQ5M2IifSwicG9kIjp7Im5hbWUiOiJ3ZWItd2l0aC1zZXJ2aWNlYWNjb3VudCIsInVpZCI6IjJiNGU0MmQ0LTc0YzEtNDczOC05NDBiLTc1MzA3ZTM3Y2Y4OCJ9LCJzZXJ2aWNlYWNjb3VudCI6eyJuYW1lIjoiY2thZCIsInVpZCI6IjY2ZDc4ZjBmLWRkMjAtNDA4Ni04MjVkLTMxMTg3ZTIyNTkwNSJ9LCJ3YXJuYWZ0ZXIiOjE3NjYwOTQ4MTd9LCJuYmYiOjE3NjYwOTEyMTAsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmNrYWQifQ.wynE653qzyE_ReIjSsOOS6hT6z3AhnLw-o3x4unP74C7OK3Tz0vo16mUza71PlCQNgGq7TGrVIMO2MgBMjxydz2a-w38VHSEbKzy_Bsu_JJ7B1W3ZUOTB3Ay6A9akqnF9VXcicwKRraRQzU5C5LBSZszLiPLFVinxWKXjqAPVRBCvT_p6NRS0dEIsKBVFlBmv0oEwsTaBt0RxcD_9G-h9bgfF96ftV9rm2lhsYgrSTTRThKn2sOHlzA3Pt9FO5UkawdP6kflWpwwCnJKVKI1PFTNauzhNQrmN2dk_Df7yIBIH7Z9R_oDAQoVwl7uTV07DVxObYB2ozYffzTJvv4saA
```

check token expiration time
```bash
$ echo eyJhbGciOiJSUzI1NiIsImtpZCI6Imx4N1FmeHdsMGRIVFJyOW1ZQXV6b2lkcS1Wa0V0UUZHODVQRk1Edm1ZMVUifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzk3NjI3MjEwLCJpYXQiOjE3NjYwOTEyMTAsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiNzUxZmZjYjMtNzc5ZC00NmM2LWI4MzAtYWVlNTQ4MDMzMjc2Iiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJkZWZhdWx0Iiwibm9kZSI6eyJuYW1lIjoiY2thZC13b3JrZXIiLCJ1aWQiOiI1NGM4NzRhOC1lMmE1LTQ0MDUtODFhMS02NzQ0MDM0ZWQ5M2IifSwicG9kIjp7Im5hbWUiOiJ3ZWItd2l0aC1zZXJ2aWNlYWNjb3VudCIsInVpZCI6IjJiNGU0MmQ0LTc0YzEtNDczOC05NDBiLTc1MzA3ZTM3Y2Y4OCJ9LCJzZXJ2aWNlYWNjb3VudCI6eyJuYW1lIjoiY2thZCIsInVpZCI6IjY2ZDc4ZjBmLWRkMjAtNDA4Ni04MjVkLTMxMTg3ZTIyNTkwNSJ9LCJ3YXJuYWZ0ZXIiOjE3NjYwOTQ4MTd9LCJuYmYiOjE3NjYwOTEyMTAsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmNrYWQifQ.wynE653qzyE_ReIjSsOOS6hT6z3AhnLw-o3x4unP74C7OK3Tz0vo16mUza71PlCQNgGq7TGrVIMO2MgBMjxydz2a-w38VHSEbKzy_Bsu_JJ7B1W3ZUOTB3Ay6A9akqnF9VXcicwKRraRQzU5C5LBSZszLiPLFVinxWKXjqAPVRBCvT_p6NRS0dEIsKBVFlBmv0oEwsTaBt0RxcD_9G-h9bgfF96ftV9rm2lhsYgrSTTRThKn2sOHlzA3Pt9FO5UkawdP6kflWpwwCnJKVKI1PFTNauzhNQrmN2dk_Df7yIBIH7Z9R_oDAQoVwl7uTV07DVxObYB2ozYffzTJvv4saA | cut -f 2 -d "." | base64 -d | jq .
base64: invalid input
{
  "aud": [
    "https://kubernetes.default.svc.cluster.local"
  ],
  "exp": 1797627210,
  "iat": 1766091210,
  "iss": "https://kubernetes.default.svc.cluster.local",
  "jti": "751ffcb3-779d-46c6-b830-aee548033276",
  "kubernetes.io": {
    "namespace": "default",
    "node": {
      "name": "ckad-worker",
      "uid": "54c874a8-e2a5-4405-81a1-6744034ed93b"
    },
    "pod": {
      "name": "web-with-serviceaccount",
      "uid": "2b4e42d4-74c1-4738-940b-75307e37cf88"
    },
    "serviceaccount": {
      "name": "ckad",
      "uid": "66d78f0f-dd20-4086-825d-31187e225905"
    },
    "warnafter": 1766094817
  },
  "nbf": 1766091210,
  "sub": "system:serviceaccount:default:ckad"
}
```

```bash
$ date -d @1797627210
vr 18 dec 2026 21:53:30 CET

```

### TokenRequest API
create serviceaccount
```bash
kubectl create serviceaccount ckad-tokenrequest
```

get a token for external app
```bash
kubectl create token ckad --duration 1h
```

### Legacy ServiceAccount Token
Create non-expiring token
```bash
kubectl create serviceaccount ckad-legacy
```

create secret
```yaml
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: ckad-legacy
  annotations:
    kubernetes.io/service-account.name: ckad-legacy
```
