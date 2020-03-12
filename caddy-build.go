package main

import (
	"github.com/caddyserver/caddy/caddy/caddymain"
	
	// plug in plugins here
  _ "github.com/sgaide/caddy-jwt/v3"
	_ "github.com/caddyserver/dnsproviders/gandiv5"
	_ "github.com/caddyserver/dnsproviders/route53"
	// _ "github.com/BTBurke/caddy-jwt"
)

func main() {
	// optional: disable telemetry
	caddymain.EnableTelemetry = false
	caddymain.Run()
}