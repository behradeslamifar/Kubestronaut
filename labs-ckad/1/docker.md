# Docker Lab

## Dockerfile Best Practice
- Rootless container
```
USER myuser
ENTRYPOINT ["/myapp"]
```
- Less layer (
- Exclude with .dockerignore
```
*.md
```
- Spcify exact image version
```
FROM ubuntu:oracular-20241120
```
- Use linter: [Hadolint](https://github.com/hadolint/hadolint)

## Interview questions
#### What's differents between ADD and COPY
`COPY` Same as `ADD`, but without the tar and remote URL handling.

#### What's differents between ENTRYPOINT and CMD
The `ENTRYPOINT` specifies a command that will always be executed when the container starts.
The `CMD` specifies arguments that will be fed to the `ENTRYPOINT`. Default ENTRYPOINT is `/bin/bash -c`

```
FROM debian:wheezy
ENTRYPOINT ["/bin/ping"]
CMD ["localhost"]
```

## Docker Build Examples

### Example 1
Dockerfile
```
FROM ubuntu:oracular-20241120

RUN apt update && apt install python3 && \
  apt clean
```

Build the image
```bash
docker build -t ubunut:custom-20250113 .
```
