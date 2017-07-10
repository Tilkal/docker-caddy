# Prebuilt caddy server with jwt authentication plugin

## How to run

To start caddy server using your own Caddyfile :

`docker run --rm -p 443:443 -p 80:80 -v /path/to/config/file/:/conf tilkal-docker/caddy -conf /conf/Caddyfile`

or 

`docker run --rm -p 443:443 -p 80:80 -v /path/to/config/file/Caddyfile:/opt/bin/Caddyfile tilkal-docker/caddy`