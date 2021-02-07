# Nova 
To get functional environment you have to clone git submodules of the project.

## Run local environment 
To build and run local environment run this command:
```shell
docker-compose  -f docker/docker-compose.yml  up
```

## Cloud service
You can test cloud environment by accessing with a browser nova-web-cloud  spa website.
This service is connected to the api hosted on Azure WebApp. 

## Azure administration 
Directory named azure contains scripts used to administrate azure environment from local machine. 
For example:  
* You can mount file share with ./storage/smb-mount.sh
* You can enable logs for app service with ./webapp/turn-on-logging.sh 
* You can deploy axon server container instance with  ./container-instance/axon-server/axon-server-deploy.sh
