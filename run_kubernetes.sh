#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath="opexception/udacity-projects:udacity-microservices"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run udacity-microservices\
    --image=$dockerpath\
    --port=80 --labels app=udacity-microservices

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
running=0
firstcheck=0
while [ $running -eq 0 ]
    do
        if $(kubectl get pods | grep 'udacity-microservices' | grep -q Running)
            then 
                echo -e "\n...Found running pod"
                running=1
            else
                if [ $firstcheck -eq 0 ]
                    then
                        echo -n "Pod not ready yet."
                        firstcheck=1
                    else
                        echo -n "."
                fi
                sleep 1
        fi
    done
kubectl port-forward udacity-microservices 8000:80
