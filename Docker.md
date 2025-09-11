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
