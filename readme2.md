# DOCKERFILE : HOW TO CONFIG

# STARTING 

```
/* anyone of the image you want you can use from to get it */
FROM postgress
FROM ubuntu
FROM mariadb
```

# scope
```
/* anyone of the image VERSION you want you can use from  AND THE SCOPE(:) to get it */
FROM postgress:15.0
FROM ubuntu:22.4
FROM mariadb:latest
```
# building a docker file
```
docker build /USER/Desktop/docker  //give the PATH to the docker file
docker build . //go to the directory and run this
```
# to name a build 
```
docker build -t first_image . 
docker build -t first_image:v0 .  //example of version build with name
```

# prconfigure
```
  RUN <any valid command>
  RUN apt-get update 
  RUN apt-get install -y python2 
```

# copy file config
```
  COPY <SOURCE ON HOST> <DEST ON IMG> // DEST IS THE FOLDER WHERE IMAGE IS OR THE DOCKERFILE IS
  COPY /USER/Desktop/IN /app/USER
  COPY /USER/Desktop//app/ // will copy sub directories also
```
# Download files from online
https://assets.datacamp.com/production/repositories/6082/datasets/31a5052c6a5424cbb8d939a7a6eff9311957e7d0/pipeline_final.zip to /pipeline_final.zip
```
/* this is less efficient as the memory of the image won't reduce after deleting the zip files*/
 RUN curl <filr URL> -o <dest>
 RUN unzip <dest>.zip //file
 RUN rm <dest>.zip
/* efficient way  using and && and  \  will make it efficent*/
 RUN curl <filr URL> -o <dest> \
 && unzip <dest>.zip //file \
 && rm <dest>.zip 
```

```
/* this is a startup command */
 CMD  <SHELL COMMAND> 
/* this runs when image starts */
/* if you write multiple cmd commands only the last one will run */
 
/*it will stop after cmd is done running or when it crashes*/

/* start command can be overwritten*/
docker run <image> <shell-command>

```
/* when making a docker image for second time it will CASH the commands what are not changed and use them for making the image
to make it efficent get packages before instruction like copy*/

```
 /*FROM RUN and COPY effect the file system*/
 WORKIDR /* changes the working directory instructions are executed in*/
 USER /* changes which user is executing the following instructions.*/
```
/*USER PERMISSIONS*/
/* use root user to create new users with permissions specified and then stop using root*/
```
USER <username> //wil change the user
```
/* Variables  */
LIKE ENV VARIABLES OR ALIAS
/* THIS IS ONLY FOR BUILDING IMAGES USED FOR PATH VARIABLES AND VERSION VARIABLES */
```
  ARG <VARIABLE NAME>= <VALUE>
```
EDITITING THE VARIABLE THROUGH FLAGS
```
docker build --build-arg project_folder=/repl/pipeline
```
/* CAN BE USED IN CONTAINER */
```
  ENV <VARIABLE NAME>= <VALUE>

  ENV MODE production
  docker run --env <key>=<value> <image-name>
```

/* docker security */
/* use image from trusted sources */
/* intstall only required software in the container */
