# Go Loadtest API
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/jmb12686/go-loadtest-api)
![Docker Pulls](https://img.shields.io/docker/pulls/jmb12686/go-loadtest-api)

Simple program, written in Go, to generate CPU load thru a RESTFul Web API.

## DockerHub Automated Builds
This repository's Docker image is linked to DockerHub registry [jmb12686/go-loadtest-api](https://hub.docker.com/r/jmb12686/go-loadtest-api).  Every commit to the master branch on GitHub triggers a [DockerHub Automated Build](https://docs.docker.com/docker-hub/builds/), simplifying the image publishing process by eliminating the need to manually images to a registry.

## How to Build Locally
Building and compiling the program is easiest by using Docker.  The included Dockerfile is a multi-stage build: https://docs.docker.com/develop/develop-images/multistage-build/

To build:

```bash
git clone https://github.com/jmb12686/go-loadtest-api.git
cd go-loadtest-api
docker build -t go-loadtest-api .
```


## How to Run
Assuming you built the docker image using the above command, you can use the following command to run:

```bash
docker run --rm -p 8000:8000 --name go-loadtest-api go-loadtest-api
```

## Program API Usage
The following APIs are usable from the program
### Hello endpoint
```
http://localhost:8000/hello
```

### CPU Loadtest endpoint
```
http://localhost:8000/loadtest/iterations/$NUM_ITERATIONS
```

### Technical Extras
This runtime container utilizes the [Distroless](https://github.com/GoogleContainerTools/distroless) base image.  As of 8/2019, when utilizing distroless/base, the effective size of this container is 24.6 MB.  In comparison, when using [alpine](https://hub.docker.com/_/alpine) as a base, the full container image is only 13.8 MB.  Interestingly enough, the alpine version is much smaller than the Distroless version (at least for containerizing a small Go applications).

