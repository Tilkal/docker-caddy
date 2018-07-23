FROM golang:1.10-alpine as gobuilder

ENV PLATFORM alpine

RUN apk --update --no-cache add git bash \
    && go get -d github.com/sgaide/caddy-jwt \
    && go get -d github.com/mholt/caddy/caddy \
    && cd /go/src/github.com/mholt/caddy/caddy \
    && sed -i '/\/\/ This is where other plugins get plugged in (imported)/c\_ "github.com/sgaide/caddy-jwt"' caddymain/run.go \
    && go get github.com/caddyserver/builds \
    && go run build.go \
    && mv caddy /go/bin/caddy-with-jwt-${PLATFORM}

FROM alpine:3.5

ENV PLATFORM alpine

RUN apk --update --no-cache add ca-certificates \
  && update-ca-certificates

COPY --from=gobuilder /go/bin/caddy-with-jwt-${PLATFORM} /opt/bin/caddy

WORKDIR /opt/bin
EXPOSE 443
EXPOSE 80
ENTRYPOINT ["/opt/bin/caddy"]
