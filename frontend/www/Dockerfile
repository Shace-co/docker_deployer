# https://github.com/3x1io/shace-frontend.git
FROM node:lts as builder

RUN apk add git

RUN mkdir -p /usr/src/nuxt-app

WORKDIR /usr/src/nuxt-app

RUN git clone git@github.com:3x1io/shace-frontend.git

WORKDIR /usr/src/nuxt-app/shace-frontend/

RUN npm install

RUN npm run build

ENV NUXT_HOST=0.0.0.0

ENV NUXT_PORT=3000

EXPOSE 3000

CMD [ "npm", "start" ]