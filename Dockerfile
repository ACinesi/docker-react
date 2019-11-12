# MULTI-STAGE BUILD

# BUILD phase
FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# RUN phase
FROM nginx
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
# by default nginx is started automatically.

# Elastic Beanstalk will look for EXPOSE in this file to open ports.