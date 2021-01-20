##TODO: Implement multistage build and vars: https://github.com/moby/buildkit/pull/499
#FROM --platform=$BUILDPLATFORM golang as build


# Use the offical Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.15.7 as builder

# Copy local code to the container image.
WORKDIR /go/src/github.com/jmb12686/go-loadtest-api
RUN go get -d -v github.com/gorilla/mux
COPY . .

# Build the command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
## GOOS=${TARGETOS} GOARCH=${TARGETARCH}
ARG opts
RUN env ${opts} go build -v -o go-loadtest-api

# Use a Docker multi-stage build to create a lean production image.
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
# FROM --platform=TARGETPLATFORM alpine
FROM alpine
RUN apk add --no-cache ca-certificates

# Copy the binary to the production image from the builder stage.
COPY --from=builder /go/src/github.com/jmb12686/go-loadtest-api/go-loadtest-api /go-loadtest-api

EXPOSE 8000

# Run the web service on container startup.
CMD ["/go-loadtest-api"]