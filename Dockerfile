FROM node:17.0.1 as base
LABEL org.opencontainers.image.vendor="Superklok Labs"
LABEL org.opencontainers.image.authors="trev@superklok.com"
LABEL org.opencontainers.image.title="TrevMorinDotCom"
LABEL org.opencontainers.image.description="TrevMorin.com (English)"
LABEL org.opencontainers.image.version="1.6.4"
LABEL org.opencontainers.image.created="2021-10-31"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/superklok/trevmorindotcom"
LABEL org.opencontainers.image.source="https://github.com/Superklok/TrevMorinDotCom"
LABEL org.opencontainers.image.licenses="ISC"
ENV NODE_ENV=production
WORKDIR /usr/src/app
EXPOSE 80
ENV PORT 80
COPY package*.json ./
RUN npm i
COPY . .
CMD ["node", "app.js"]

FROM base as dev
ENV NODE_ENV=development
USER node

FROM dev as test
RUN npm audit
USER root

FROM base as prod
USER node