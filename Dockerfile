FROM node:20.11.1 AS build

# cli arguments
ARG EXB_SRC

# Copy src zip to container
WORKDIR /home/node/
COPY ${EXB_SRC} ${EXB_SRC}
RUN unzip ${EXB_SRC}

# Install ExB dependencies 
WORKDIR /home/node/ArcGISExperienceBuilder/client
RUN npm ci

WORKDIR /home/node/ArcGISExperienceBuilder/server
RUN npm ci

FROM node:20.11.1-alpine as production

# Copy ExB from the build stage to the final stage
COPY --from=build /home/node/ArcGISExperienceBuilder /home/node/ArcGISExperienceBuilder

# Change working dirctory to ExB root
WORKDIR /home/node/ArcGISExperienceBuilder

# Install concurently globaly so we can run 2 services at once, client and server.
RUN npm i -g concurrently

# start up the ExB client and server.
CMD concurrently --names "CLIENT,SERVER" --prefix "{name}: {time}" "cd ./client && npm run start" "cd ./server && npm run start"
