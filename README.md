# arcgis-exb Docker Image
The Esri ArcGIS Experience Builder containerized for faster development of apps, widgets, and themes.

This image is publicly available on docker hub at: https://hub.docker.com/r/dspriggs/arcgis-exb

## Setup
Copy the `.env.sample` to a `.env` and fill in the properties as follows:
```shell
DOCKER_HUB_USER=<your docker hub user name>
DOCKER_HUB_TOKEN=<docker hub token>
DOCKER_HUB_NAMESPACE=<docker hub user or company namespace>
DOCKER_HUB_REPO=<docker hub namespace repo>
```

Download an Arcgis Experience Builder source zip file from [developers.arcgis.com](https://developers.arcgis.com/downloads/#arcgis-experience-builder).

Do not change the file name. The version in the file name is important. For example `arcgis-experience-builder-1.13.zip`

Place the zip file in the `exb-src` folder.

From a machine that has docker installed, run the `build-container-from-src.sh` script from the same directory as the `Dockerfile`:

```shell
sh ./build-container-from-src.sh
```

This will present you with a list of files to pick from. Make a selection then build.

If you dont want to push the container to your registry, comment out the login and push lines. Or use this command:
```shell
docker build --target production --build-arg EXB_SRC="FILE" -t "DOCKER_HUB_NAMESPACE/DOCKER_HUB_REPO:VERSION" .
```