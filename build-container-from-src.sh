#!/bin/bash

export $(cat .env | grep ^[A-Z] | xargs)
files=("./exb-src/arcgis-experience-builder-"*.zip)

PS3="Select ExB source zip file, or 0 to exit: "
select file in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
        echo "Bye!" >&2
        exit
    elif [[ -z $file ]]; then
        echo "Invalid choice, try again" >&2
    else
        break
    fi
done

version=$(echo "$file" | grep -Eo '[0-9]+\.[0-9]+')

printf "\n"
printf "Slected file: $file\n"
printf "Selected version: $version\n"

docker build --build-arg EXB_SRC=$file -t "$DOCKER_HUB_NAMESPACE/$DOCKER_HUB_REPO:$version" .
docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_TOKEN
docker push "$DOCKER_HUB_NAMESPACE/$DOCKER_HUB_REPO:$version"
