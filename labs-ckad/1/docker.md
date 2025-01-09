# Dockerfile Best Practice
- Rootless container
```
USER myuser
ENTRYPOINT ["/myapp"]
```
- Less layer
- Spcify exact image version
```
FROM ubuntu:oracular-20241120
```
- Use linter: [Hadolint](https://github.com/hadolint/hadolint)
