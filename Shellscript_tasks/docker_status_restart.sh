#!/bin/bash

# This script check the status of the docker

docker_status=$(systemctl is-active docker)
echo "Docker status is: $docker_status"

if [ "$docker_status" = "active" ];
then
        echo "Docker is running...."

else

                echo "Docker is not running"
                echo "🔄 Attempting to restart Docker..."
                sleep 5

                sudo systemctl restart docker

                #Again check the status of the docker

                new_status=$(systemctl is-active docker)
                echo "Docker status after restart: $new_status"

                if [ "$new_status" = "active" ];
                then
                        echo "Docker is successfully restarted and running now"
               else

                        echo "Docker attempted to restarted but is still not running"

              fi
fi
