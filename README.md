You must have a database docker running.

You will need to create the db, username, password.

Once the docker is run, you will need to edit the /conf/.env file with the appropriate info.

```
docker run -d
--name=lychee-laravel
-v /host_path/lychee-laravel/conf:/conf
-v /host_path/lychee-laravel/uploads:/uploads
-p 90:80
--net network_name
--link db_name
bigrob8181/lychee-laravel
```
