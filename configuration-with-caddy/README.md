# Configuration with caddy

This is an example configuration for using the Lychee photo management tool with the Caddy web server. Make sure to adjust the domain in the Caddyfile and set the MYSQL_ROOT_PASSWORD and MYSQL_LYCHEE_PASSWORD in the .env file to secure your database.

## Start Lychee Docker

```
docker-compose pull
docker-compose up -d
```