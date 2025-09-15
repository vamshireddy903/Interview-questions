# 1. What is a Dockerfile? Can you explain some commonly used instructions?

A Dockerfile is a text file that contains a set of instructions used to build a Docker image. It defines what goes into the image — such as the base operating system, application code, libraries, dependencies, and configuration.

When we run docker build, Docker reads the Dockerfile and creates an image step by step.

# Commonly used Dockerfile instructions

# FROM

Sets the base image for the build.

Example:

FROM ubuntu:20.04


# RUN

Executes commands inside the image during build.

Example:

RUN apt-get update && apt-get install -y python3


# COPY

Copies files from the host machine into the image.

Example:

COPY app.py /app/


# ADD

Similar to COPY but also supports remote URLs and auto-extraction of tar files.

Example:

ADD https://example.com/file.tar.gz /tmp/


# WORKDIR

Sets the working directory inside the container.

Example:

WORKDIR /app


# EXPOSE

Informs Docker that the container listens on a specific port.

Example:

EXPOSE 8080


# CMD

Provides default command/arguments for the container when it starts.

Example:

CMD ["python3", "app.py"]


# ENTRYPOINT

Defines the main command that always runs when the container starts.

Example:

ENTRYPOINT ["python3", "app.py"]

# What is a multi-stage build in Docker? Why is it useful?

A multi-stage build in Docker is a technique that allows you to use multiple FROM statements in a single Dockerfile. Each FROM starts a new stage. You can build your application in one stage (with all build tools and dependencies) and then copy only the required artifacts into a final lightweight image.

# This is useful because it:

Reduces image size → Only the necessary files go into the final image (no compilers, package managers, etc.).

Improves security → Build tools and unnecessary dependencies are left out.

Simplifies Dockerfile → No need for manual cleanup of temporary files.
<img width="798" height="620" alt="image" src="https://github.com/user-attachments/assets/c6fbb41d-2bd7-4cf6-9709-e5fadb116971" />

# How do you copy files from host to container and vice versa?

# 1. Copy file from host → container

    docker cp /path/on/host <container_id_or_name>:/path/in/container


👉 Example:

    docker cp ~/test.txt my-app:/root/


Copies test.txt from host into /root/ inside container my-app.

# 2. Copy file from container → host

    docker cp <container_id_or_name>:/path/in/container /path/on/host


👉 Example:

    docker cp my-app:/root/test.txt ~/test-copy.txt


C  opies test.txt from container to host as test-copy.txt.

# 🔹 Real-world usage

Copy config files, logs, or build artifacts out of a running container.

Inject files/scripts into a running container without rebuilding the image.

# How do you remove a container and an image in Docker?

🔹 Remove a container

First, list containers (running + stopped):

    docker ps -a


Then remove:

    docker rm <container_id_or_name>


👉 If the container is running, you must force remove it:

    docker rm -f <container_id_or_name>

🔹 Remove an image

First, list images:

    docker images


Then remove:

    docker rmi <image_id_or_name>


👉 If the image is being used by a container, you need to remove the container first.

🔹 Remove all stopped containers at once
      
      docker container prune

🔹 Remove all unused images at once

     docker image prune -a
# What happens when you run docker run -it ubuntu bash?

docker run -it ubuntu bash creates a new container from the Ubuntu image, attaches you to an interactive terminal (-it), and runs the bash shell inside the container. When you exit the shell, the container stops.
