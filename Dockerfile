FROM golang:1.12-alpine as gobuilder

ENV PLATFORM alpine
ENV GO111MODULE on

COPY caddy-build.go /opt/go/caddy-build/caddy-build.go

RUN apk --update --no-cache add git bash \
    && cd /opt/go/caddy-build/ \
    && go mod init caddy \
    && go get github.com/mholt/caddy \
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
