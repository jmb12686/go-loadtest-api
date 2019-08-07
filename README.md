# Go Loadtest API
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


