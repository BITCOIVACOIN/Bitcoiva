# Simple usage with a mounted data directory:
# > docker build -t bitcoiva .
# > docker run -it -p 46657:46657 -p 46656:46656 -v ~/.bitcoivad:/root/.bitcoivad -v ~/.bitcoivacli:/root/.bitcoivacli bitcoiva bitcoivad init
# > docker run -it -p 46657:46657 -p 46656:46656 -v ~/.bitcoivad:/root/.bitcoivad -v ~/.bitcoivacli:/root/.bitcoivacli bitcoiva bitcoivad start
FROM golang:alpine AS build-env

# Set up dependencies
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python3

# Set working directory for the build
WORKDIR /go/src/github.com/cosmos/bitcoiva

# Add source files
COPY . .

# Install minimum necessary dependencies, build Cosmos SDK, remove packages
RUN apk add --no-cache $PACKAGES && \
    make tools && \
    make install

# Final image
FROM alpine:edge

ENV GAIA /bitcoiva

# Install ca-certificates
RUN apk add --update ca-certificates

RUN addgroup bitcoiva && \
    adduser -S -G bitcoiva bitcoiva -h "$GAIA"

USER bitcoiva

WORKDIR $GAIA

# Copy over binaries from the build-env
COPY --from=build-env /go/bin/bitcoivad /usr/bin/bitcoivad
COPY --from=build-env /go/bin/bitcoivacli /usr/bin/bitcoivacli

# Run bitcoivad by default, omit entrypoint to ease using container with bitcoivacli
CMD ["bitcoivad"]
