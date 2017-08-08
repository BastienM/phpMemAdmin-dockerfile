# phpMemAdmin-docker

## Disclaimer

​:warning: Work in progress :warning:

> **BE WARNED : **
>
>  THIS VERSION IS CURRENTLY TAILORED TO WORK WITH AWS ELASTICACHE MEMCACHED SERVICE

## How-to

```
$ docker build -t phpmemadmin .

$ docker run -d \
             --name phpMemAdmin \
             -e USERNAME=<admin_username> \
             -e PASSWORD=<admin_password> \
             -e CLUSTER_NAME=<cluster_name> \
             -e MEMCACHED_HOST=<memcached_ip>
             -e MEMCACHED_PORT=11211
             phpmemadmin
```
