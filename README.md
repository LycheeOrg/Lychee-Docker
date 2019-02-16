[![Build Status](https://travis-ci.com/LycheeOrg/Lychee-Laravel-Docker.svg?branch=master)](https://travis-ci.com/LycheeOrg/Lychee-Laravel-Docker)

## Prerequsites ##

*  You must have a database docker running **OR** create one in your docker-compose.yml.

## Setup ##

1.  Create the db, username, password.
2.  Edit the environment variables:
    *  Supply the environment variables via `docker run` / `docker-compose`, **or**
    *  Create a `.env` file with the appropriate info and mount it to `/conf`.

## Example docker run command ##

1.  **Make sure that you link to the container running your database!!**  
    The example below shows --net and --link for these purposes  
    --net connects to the name of the network your database is on  
    --link connects to the database  

```bash
docker run -d \
--name=lychee-laravel \
-v /host_path/lychee-laravel/conf:/conf \
-v /host_path/lychee-laravel/uploads:/uploads \
-e PUID=1000 \
-e PGID=1000 \
-e PHP_TZ=America/New_York \
-e DB_CONNECTION=mysql \
-e DB_HOST=mariadb \
-e DB_PORT=3306 \
-e DB_DATABASE=homestead \
-e DB_USERNAME=homestead \
-e DB_PASSWORD=secret \
-p 90:80 \
--net network_name \
--link db_name \
bigrob8181/lychee-laravel
```

## Example docker-compose.yml ##

Change the environment variable in the [provided example](docker-compose.yml) to reflect your database credentials.

Note that in order to avoid writing credentials directly into the file, you can create a `db_secrets.env` and use the `env_file` directive (see the [docs](https://docs.docker.com/compose/environment-variables/#the-env_file-configuration-option)).

## Available Environment Variables and defaults ##

If you do not provide environment variables or `.conf` file, the [example env file](https://github.com/LycheeOrg/Lychee-Laravel/blob/master/.env.example) will be used with some values already set by default.

Some variables are specific to Docker, and the default values are :
* PUID=1000  
* PGID=1000  
* USER=lychee
* PHP_TZ=America/New_York  
