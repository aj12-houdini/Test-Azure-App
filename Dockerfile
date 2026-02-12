#syntax=docker/dockerfile:1

FROM node:lts-alpine AS build

WORKDIR /app

COPY . ./

RUN corepack enable

ENV CI=true

RUN pnpm install

RUN pnpm run build 

FROM nginx:latest

COPY --from=build /app/dist/ /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx

CMD ["nginx", "-g", "daemon off;"]



