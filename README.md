# Docker-learning

# intro
```
docker run hello-world // hello world
```
```
docker run  ubuntu // starts an stops
```
it has to be used with -it flag and then the image you want
```
docker run -it ubuntu //interactive container
```

to run a container in the background for data processing etc

```
docker run  -d postgres // detached
```
to see a list of containers runing 
```
docker ps //ls for container runing
```

to stop a container 
```
docker stop <container-id>  // from ps command, can also use container name
```
to name a container 
```
docker run --name joe_db postgres // hello world
```
to filter running images
```
docker ps -f "name=joe_db"
```
to check for logs 
```
docker logs  <container-id>
```
to check live logs
```
docker logs -f <container-id>
```

to delete containers, first stop it and then delete
```
docker container rm  <container-id>
```
to delete all stopped containers
```
docker container prune
```
to pull images
```
docker pull postgres
docker pull ubuntu
/*version pull*/
docker pull ubuntu:22.04
docker pull ubuntu:jammy
```
to list images
```
docker images
```

to remove images

```
docker image rm <image-name>
```
to delete all not used by container images
```
docker image prune -a
```

Private Docker registries
Unlike Docker official images there is no quality guarantee 

```
docker pull dockerhub.myprivateregistry.com/classify_spam
```
to push to registry

```
docker tag classify_spam:v1 dockerhub.myprivateregistry.com/classify_spam:v1
docker image push dockerhub.myprivateregistry.com/classify_spam:v1
```
to login to docker hub

```
docker login dockerhub.myprivateregistry.com
```
saving docker images as a file 

```
docker save -o image.tar classify_spam:v1
```
Load an image
```
docker load -i image.tar
```

