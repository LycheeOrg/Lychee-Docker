## Prerequsites ##

*  You must have a database docker running **OR** create one in your docker-compose.yml.

## Setup ##

1.  Create the db, username, password.
2.  Edit the environment variables:
    *  After the first run, edit the /conf/.env file with the appropriate info
    *  **OR**
    *  Supply the environment variables via docker run/docker-compose

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
-e MY_DB_CONNECTION=mysql \
-e MY_DB_HOST=mariadb \
-e MY_DB_PORT=3306 \
-e MY_DB_DATABASE=homestead \
-e MY_DB_USERNAME=homestead \
-e MY_DB_PASSWORD=secret \
-p 90:80 \
--net network_name \
--link db_name \
bigrob8181/lychee-laravel
```

## Example docker-compose.yml ##

[docker-compose.yml](https://gitlab.landry.me/Dockerfile/lychee-laravel/blob/master/docker-compose.yml)  
<!--- [docker-compose-database.yml](https://gitlab.landry.me/Dockerfile/lychee-laravel/blob/master/docker-compose-database.yml) -->

## Available Environment Variables and defaults ##

PUID=1000  
PGID=1000  
PHP_TZ=America/New_York  
MY_APP_NAME=Laravel  
MY_APP_ENV=local  
MY_APP_DEBUG=true  
MY_APP_URL=http://localhost  
MY_LOG_CHANNEL=stack  
MY_DB_CONNECTION=mysql  
MY_DB_HOST=mariadb  
MY_DB_PORT=3306  
MY_DB_DATABASE=homestead  
MY_DB_USERNAME=homestead  
MY_DB_PASSWORD=secret  
MY_DB_DROP_CLEAR_TABLES_ON_ROLLBACK=false  
MY_DB_OLD_LYCHEE_PREFIX=''  
MY_BROADCAST_DRIVER=log  
MY_CACHE_DRIVER=file  
MY_SESSION_DRIVER=file  
MY_SESSION_LIFETIME=120  
MY_QUEUE_DRIVER=sync  
MY_SECURITY_HEADER_HSTS_ENABLE=false  
MY_REDIS_HOST=127.0.0.1  
MY_REDIS_PASSWORD=null  
MY_REDIS_PORT=6379  
MY_MAIL_DRIVER=smtp  
MY_MAIL_HOST=smtp.mailtrap.io  
MY_MAIL_PORT=2525  
MY_MAIL_USERNAME=null  
MY_MAIL_PASSWORD=null  
MY_MAIL_ENCRYPTION=null  
MY_PUSHER_APP_ID=''  
MY_PUSHER_APP_KEY=''  
MY_PUSHER_APP_SECRET=''  
MY_PUSHER_APP_CLUSTER=mt1  
