# original image
FROM node:16

# update os and install some library
RUN apt-get update && apt-get install libvips-dev -y

# setup environment
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
ENV DATABASE_CLIENT=${DATABASE_CLIENT}
ENV DATABASE_HOST=${DATABASE_HOST}
ENV DATABASE_PORT=${DATABASE_PORT}
ENV DATABASE_NAME=${DATABASE_NAME}
ENV DATABASE_USERNAME=${DATABASE_USERNAME}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV DATABASE_SSL=${DATABASE_SSL}


# set working directory
WORKDIR /opt/

# copy install file
COPY ./package.json ./package-lock.json ./
# COPY ./package.json ./yarn.lock ./
# COPY ./package-lock.json ./
# COPY ./package.json ./yarn.lock ./

# setup environment for path
ENV PATH /opt/node_modules/.bin:$PATH

# config global and install library for this project
RUN npm install --platform=linux --arch=x64 sharp
#RUN yarn config set network-timeout 600000 -g && yarn install


WORKDIR /opt/app
COPY ./ .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
#CMD ["yarn", "start"]