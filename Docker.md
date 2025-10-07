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

# 2 What is a multi-stage build in Docker? Why is it useful?

A multi-stage build in Docker is a technique that allows you to use multiple FROM statements in a single Dockerfile. Each FROM starts a new stage. You can build your application in one stage (with all build tools and dependencies) and then copy only the required artifacts into a final lightweight image.

# This is useful because it:

Reduces image size → Only the necessary files go into the final image (no compilers, package managers, etc.).

Improves security → Build tools and unnecessary dependencies are left out.

Simplifies Dockerfile → No need for manual cleanup of temporary files.
<img width="798" height="620" alt="image" src="https://github.com/user-attachments/assets/c6fbb41d-2bd7-4cf6-9709-e5fadb116971" />

# 3 How do you copy files from host to container and vice versa?

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

# 4 How do you remove a container and an image in Docker?

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
# 5 What happens when you run docker run -it ubuntu bash?

docker run -it ubuntu bash creates a new container from the Ubuntu image, attaches you to an interactive terminal (-it), and runs the bash shell inside the container. When you exit the shell, the container stops.

# What is the difference b/w COPY and ADD

<img width="974" height="498" alt="image" src="https://github.com/user-attachments/assets/951009c6-5299-4a0e-9743-f6cab3649e69" />

Always prefer COPY because it’s simple, explicit, and predictable.

Use ADD only when you need its extra features (tar extraction or remote download).

# 6 What is the purpose of .dockerignore file?

 The .dockerignore file tells Docker which files and directories to exclude from the build context when running docker build.

This makes the build faster, lighter, and more secure.

# Why it’s important

Reduce build context size → Prevents sending unnecessary files (like .git/, node_modules/, logs) to the Docker daemon.

Faster builds → Smaller context means quicker transfers and less caching overhead.

Security → Keeps sensitive files (e.g., .env, SSH keys) out of images.

<img width="836" height="589" alt="image" src="https://github.com/user-attachments/assets/6f766074-0ec2-4888-8f40-a653d804cd7d" />


# 7 Explain Docker Volumes vs. Bind Mounts.

# Docker Volumes

Managed by Docker (stored under /var/lib/docker/volumes/ on Linux).

Portable & reusable across multiple containers.

Docker handles the storage location and lifecycle.

Good for production use, as it’s decoupled from the host filesystem.

Works well with Docker Swarm & Kubernetes.

👉 Example:

    docker volume create mydata
    
    docker run -d --name vol-container -v mydata:/app/data ubuntu sleep infinity


Now, /app/data inside container maps to mydata volume.

# 🔹 Bind Mounts

Maps a specific path on the host machine to a path inside the container.

Syntax: -v /host/path:/container/path

Useful for development, where you want real-time sync between host files and container files.

Not portable — depends on the host’s directory structure.

Full control, but also more risk (accidental overwrite or delete on host will affect container).

👉 Example:

     docker run -d --name bind-container -v /home/user/data:/app/data ubuntu sleep infinity


Now, /app/data inside container maps directly to /home/user/data on host.

# 8 What is a multi-stage build in Docker? Why is it useful?

A multi-stage build in Docker means using multiple FROM statements in a single Dockerfile, where each stage can use a different base image.
You copy only the necessary artifacts from earlier stages into the final image.

<img width="688" height="452" alt="image" src="https://github.com/user-attachments/assets/63532262-6768-466f-9509-b1b5fc04520c" />
<img width="1000" height="677" alt="image" src="https://github.com/user-attachments/assets/00a9966d-92ef-47b5-8da7-7357e44d6f81" />

# 9 How do you persist container data?

By default, Docker containers are ephemeral – when a container deleted, the data inside it is lost.
To persist data across container restarts or deletions, we use:

# 1. Volumes (Preferred)

Managed by Docker (docker volume create).

Stored under /var/lib/docker/volumes/ on the host.

Independent of the container lifecycle → data remains even if the container is deleted.

Example:

    docker run -d --name my-app -v mydata:/data ubuntu

Here mydata is a named volume that persists data in /data inside the container.

# 2. Bind Mounts

Maps a specific host directory/file into a container.

Useful when you want direct control over where data is stored on the host.

Example:

    docker run -d --name my-app -v /home/user/data:/data ubuntu


Now any files written in /data inside the container are saved to /home/user/data on the host.


🔹 Interview one-liner

Containers are ephemeral, so to persist data we use Volumes (managed by Docker, safe, and portable) or Bind Mounts (map host paths to container paths). Volumes are the preferred approach for production because they’re managed independently of the container lifecycle.

# 1 What is the difference between ENTRYPOINT and CMD in Docker?

# ENTRYPOINT

Defines the main executable for the container.

It always runs when the container starts.

Cannot be overridden by arguments passed to docker run (unless you use --entrypoint).

👉 Example:

    FROM ubuntu
    ENTRYPOINT ["echo", "Hello"]

    docker run my-image World

 Output → Hello World ✅

 Here "World" is passed as an argument to the ENTRYPOINT.

# CMD

Provides default arguments for the container.

It can be overridden at runtime with arguments in docker run.

There can be only one CMD in a Dockerfile (the last one overrides previous ones).

👉 Example:

    FROM ubuntu
    CMD ["echo", "Hello from CMD"]

    docker run my-image


Output → Hello from CMD ✅

    docker run my-image Hi

Output → Hi ✅ (overrides CMD)

# 🔹 Interview one-liner
ENTRYPOINT sets the main command that always executes, while CMD provides default arguments to that command. ENTRYPOINT is not overridden by docker run, but CMD can be overridden.

# 11 How do you check logs of a container?

Docker provides the docker logs command to view the STDOUT (standard output) and STDERR (standard error) of a container.

✅ Basic command:
    
     docker logs <container_id_or_name>

✅ Useful options:

    docker logs -f <container_id_or_name>

Show timestamps

    docker logs -t <container_id_or_name>

# Interview one-liner
You can check container logs using docker logs <container_name_or_id>. You can also use flags like -f to follow logs, --tail to see the last few lines, and -t to add timestamps

# 12 How can you reduce the size of a Docker image?

# ✅ Best practices:

# Use a smaller base image

Example: alpine instead of ubuntu.

FROM openjdk:17-alpine


# Multi-stage builds

Build dependencies (Maven, Node.js, Go compiler, etc.) stay in build stage, final image has only the runtime.

# Clean up unnecessary files

Remove cache, temp files, and package managers after install.

    RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*


# Minimize layers

Combine related commands in a single RUN.

    RUN apt-get update && apt-get install -y curl vim

# Use .dockerignore

Exclude files (like .git, node_modules, test files) that don’t need to be in the image.

# Interview one-liner
Use smaller base images like Alpine, multi-stage builds, clean up temp files, minimize layers, and use .dockerignore."

#  13 What happens when you delete a container without removing the volume?

If a container was created with a named volume or -v volume_name:/path, the volume persists even after the container is deleted.

The data inside the volume stays safe and can be reused by another container.

👉 Example:

    docker run -d --name my-app -v mydata:/data ubuntu


Write a file in /data inside the container.

Delete container:

    docker rm -f my-app


The mydata volume is still available:

    docker run --rm -it -v mydata:/data ubuntu cat /data/file.txt


✅ You’ll still see your file — data is safe.

⚠️ BUT if you used an anonymous volume (like just -v /data without naming it) → Docker may garbage-collect it if no containers use it.

# Interview one-liner
If a container is deleted but the volume is not removed, the data in the volume persists and can be reused by other containers.

# How do u take the bakcup of a running container

# 1. Backup the Container’s Filesystem

This will give you a snapshot of the container’s current state (like making an image of it).
```
docker commit <container_name_or_id> my-backup-image
docker save -o my-backup-image.tar my-backup-image
```
# Run a new container directly from that image

    docker run -d --name my-new-container my-backup-image

**docker commit** → creates a new image from the running container.  
**docker save**→ exports the image into a .tar file you can store/transfer.

- You want to move the backup image to another host.  
- You want to store the image file for future use.  
Later you can restore with:
```
docker load -i my-backup-image.tar
docker run -d my-backup-image
```

# 2. Backup Data from a Volume

If your container uses a volume for persistence, you should back up that instead of the whole container.

# Best practice:

- Use volumes for application data.  
- Back up volumes (not the container itself) since containers are ephemeral.    
- Use docker commit only if you need to capture changes inside a running container.

# To check how much memory each running container is using,

     docker stats --no-stream

# Docker Architecture:

<img width="1062" height="864" alt="image" src="https://github.com/user-attachments/assets/19568834-197c-443e-9e05-4539384be4eb" />

The diagram below shows the architecture of Docker and how it works when we run “docker build”, “docker pull” and “docker run”.

There are 3 components in Docker architecture:

**Docker client**

The docker client talks to the Docker daemon.

**Docker host**

The Docker daemon listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes.

**Docker registry**

A Docker registry stores Docker images. Docker Hub is a public registry that anyone can use.

Let’s take the “docker run” command as an example.

- Docker pulls the image from the registry.  
- Docker creates a new container.  
- Docker allocates a read-write filesystem to the container.  
- Docker creates a network interface to connect the container to the default network.  
- Docker starts the container.

