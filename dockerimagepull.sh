#!/bin/bash
# A script to search for containers, pull their images,
# and echo if there is a new image

#Capture docker container details
containerimages=$(docker ps --format "{{.Image}}")
echo "$containerimages"

#Iterate through each image and pull
for item in $containerimages
do
  output=$(docker pull $item)
  if [[ "$output" == *"Image is up to date"* ]]
  then
    echo "$item is already up to date"
  elif [[ "$output" == *"Downloaded newer image"* ]]
  then
    echo "$item has a newer image"
  else
    echo "Unexpected Output: $output"
  fi
done
