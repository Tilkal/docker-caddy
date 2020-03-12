FROM golang:1.13-alpine as gobuilder

COPY caddy-build.go /opt/go/caddy-build/caddy-build.go

RUN cd /opt/go/caddy-build/ \
    && go mod init caddy \
    && go get github.com/caddyserver/caddy \
    && go build

FROM alpine:3.9

ENV PLATFORM alpine

RUN apk --update --no-cache add ca-certificates \
  && update-ca-certificates

COPY --from=gobuilder /opt/go/caddy-build/caddy /opt/bin/caddy

WORKDIR /opt/bin
EXPOSE 443
EXPOSE 80
ENTRYPOINT ["/opt/bin/caddy"]
