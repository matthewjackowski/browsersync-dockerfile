FROM node:4-slim
MAINTAINER Matthew Jackowski

ENV REFRESHED_AT 2014-11-29

RUN apt-get -y update && apt-get install -y git

RUN mkdir -p /app
ENV APP_DIR=//app
ENV WORK_DIR=//app
ENV PORT=8000
ENV UI_PORT=8080

ADD ./files $APP_DIR
WORKDIR $WORK_DIR
RUN npm install && npm run-script bower install

VOLUME ["$WORK_DIR/src","$WORK_DIR/tests"]

EXPOSE $PORT
EXPOSE $UI_PORT
CMD ./node_modules/browser-sync/bin/browser-sync.js start --port $PORT --ui-port $UI_PORT --directory true --no-open -s '.' -f 'src,tests'