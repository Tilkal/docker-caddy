package main

import (
	"github.com/mholt/caddy/caddy/caddymain"
	
	// plug in plugins here
  _ "github.com/sgaide/caddy-jwt"
	_ "github.com/caddyserver/dnsproviders/gandiv5"
	// _ "github.com/BTBurke/caddy-jwt"
)

func main() {
	// optional: disable telemetry
	caddymain.EnableTelemetry = false
	caddymain.Run()
}