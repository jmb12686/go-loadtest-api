# Go Loadtest API
Simple program, written in Go, to generate CPU load thru a RESTFul Web API.

## How to Build
Building and compiling the program is easiest by using Docker.  The included Dockerfile is a multi-stage build: https://docs.docker.com/develop/develop-images/multistage-build/

To build:

```bash
docker build -t go-loadtest-api .
```


## How to Run
Assuming you built the docker image using the above command, you can use the following command to run:

```bash
docker run --rm -p 8000:8000 --name go-loadtest-appi go-loadtest-api
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


