# Configuration with caddy

This is an example configuration for using the Lychee photo management tool with the Caddy web server. Make sure to adjust the domain in the Caddyfile and set the `MYSQL_ROOT_PASSWORD` and `MYSQL_LYCHEE_PASSWORD` in the .env file to secure your database.

These configurations are automatically applied when using the `setup.sh` script.

## Setup

The `setup.sh` script downloads necessary files, generates strong MySQL passwords, and updates the domain in the Caddyfile.

```
curl -O https://raw.githubusercontent.com/LycheeOrg/Lychee-Docker/refs/heads/master/configuration-with-caddy/setup.sh && chmod +x setup.sh && ./setup.sh
```

## Start

Docker pulls the containers and then starts them as services running in the background.

```
docker-compose pull
docker-compose up -d
```
