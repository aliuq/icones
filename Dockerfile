FROM node:20.16.0-alpine3.20 AS build

WORKDIR /app
COPY . .
RUN npm install pnpm@9.7.1 -g && pnpm install && pnpm run build

FROM nginx:1.27.1-alpine

ENV TZ=Asia/Shanghai
ENV NODE_ENV=production

COPY --from=build /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
