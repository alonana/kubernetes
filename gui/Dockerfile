# Stage 1
FROM node:8 as react-build
WORKDIR /app
COPY react/packages.json ./
RUN yarn install
COPY react ./
RUN yarn build

# Stage 2 - the production environment
FROM nginx:1.15.9-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]