ARG BUILD_DIR="/usr/app/"

FROM node:18 as packer
ARG BUILD_DIR
WORKDIR ${BUILD_DIR}

COPY app/package.json app/package-lock.json ${BUILD_DIR}
RUN npm install

COPY app ${BUILD_DIR}
CMD ["npm", "run", "start:dev"]

FROM packer AS builder
RUN npm run build

FROM node:18-alpine as prod
ARG BUILD_DIR
WORKDIR ${BUILD_DIR}

COPY app/package.json app/package-lock.json ${BUILD_DIR}
RUN npm install --only=production
COPY --from=builder ${BUILD_DIR}/dist ${BUILD_DIR}/dist

CMD ["node", "./dist/main"]
