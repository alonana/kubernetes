FROM node:10-alpine
WORKDIR /home/node/app
RUN mkdir -p ./node_modules && chown -R node:node .
COPY target/package.json ./
USER node
RUN npm install
RUN mkdir -p ./main
COPY --chown=node:node ./target/main main/

CMD [ "node", "main/server.js" ]