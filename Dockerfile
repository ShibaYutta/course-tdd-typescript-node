FROM mhart/alpine-node:16
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

COPY ./dist/src /dist/src
COPY ./config /config
COPY ./package.json /package.json
COPY ./package-lock.json /package-lock.json 

LABEL fly_launch_runtime="nodejs"

RUN NODE_ENV=$NODE_ENV npm install --production
CMD ["node", "dist/src/index.js"]
