FROM node:16.14.2-alpine3.15

RUN mkdir -p /var/www/shace

RUN mkdir -p /var/www/shace/frontend

WORKDIR /var/www/shace/frontend

RUN apk update && apk upgrade && apk add --no-cache bash git openssh

ARG GIT_PERSONAL_ACCESS_TOKEN
ARG BASE_URL
ARG HOST
ARG PORT

RUN git clone "https://${GIT_PERSONAL_ACCESS_TOKEN}@github.com/3x1io/shace-frontend" /var/www/shace/frontend

RUN npm install

RUN echo ${BASE_URL}

RUN npm run build

EXPOSE ${PORT}

ENV BASE_URL=${BASE_URL}



ENV NUXT_HOST=${HOST}

ENV NUXT_PORT=${PORT}

CMD [ "npm", "start" ]
