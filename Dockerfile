FROM golang:1.8.1-alpine as gobuilder

ENV PLATFORM alpine
ENV GO_VERSION 1.8.1
ENV CADDY_VERSION v0.10.2

RUN apk --update --no-cache add git bash \
    && go get github.com/sgaide/caddy-jwt \
    && go get -d github.com/mholt/caddy/caddy \
    && cd /go/src/github.com/mholt/caddy/caddy \
    && git checkout ${CADDY_VERSION} \
    && go get github.com/mholt/caddy/caddy \
    && sed -i '/\/\/ This is where other plugins get plugged in (imported)/c\_ "github.com/sgaide/caddy-jwt"' caddymain/run.go \
    && ./build.bash \
    && mv caddy /go/bin/caddy-with-jwt-${PLATFORM}

FROM alpine:3.5

ENV PLATFORM alpine
ENV GO_VERSION 1.8.1
ENV CADDY_VERSION v0.10.2

RUN apk --update --no-cache add ca-certificates \
  && update-ca-certificates

COPY --from=gobuilder /go/bin/caddy-with-jwt-${PLATFORM} /opt/bin/caddy

WORKDIR /opt/bin

ENTRYPOINT ["/opt/bin/caddy"]
