FROM node:18-bullseye as ts-compiler
WORKDIR /usr/app
COPY package*.json ./
COPY tsconfig*.json ./
COPY /config ./config
COPY /src ./src
COPY /test ./test
RUN npm install
RUN npm run build

FROM node:18-bullseye as ts-remover
WORKDIR /usr/app
COPY --from=ts-compiler /usr/app/package*.json ./
COPY --from=ts-compiler /usr/app/dist/src ./src
COPY --from=ts-compiler /usr/app/config ./config
RUN npm install --only=production

FROM node:18-bullseye-slim
WORKDIR /usr/app
COPY --from=ts-remover /usr/app ./
USER 1000
CMD ["src/index.js"]