# Use the offical Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.12 as builder

# Copy local code to the container image.
WORKDIR /go/src/github.com/jmb12686/go-loadtest-api
RUN go get -d -v github.com/gorilla/mux
RUN go get -d -v github.com/jmb12686/docker-healthchecks/Golang
COPY . .

# Build the command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN CGO_ENABLED=0 GOOS=linux go build -v -o go-loadtest-api
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o health-check "github.com/jmb12686/docker-healthchecks/Golang/"

# Use a Docker multi-stage build to create a lean production image.
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM alpine
RUN apk add --no-cache ca-certificates

# Copy the binary to the production image from the builder stage.
COPY --from=builder /go/src/github.com/jmb12686/go-loadtest-api/go-loadtest-api /go-loadtest-api
COPY --from=builder /go/src/github.com/jmb12686/go-loadtest-api/health-check /health-check

EXPOSE 8000

HEALTHCHECK \
  --interval=30s \
  --timeout=3s \
  CMD ["/health-check","http://localhost:8000/hello"]

# Run the web service on container startup.
CMD ["/go-loadtest-api"]