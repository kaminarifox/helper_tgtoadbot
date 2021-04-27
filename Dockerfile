FROM node:14
WORKDIR /usr/src/app/

COPY *.json *.js *.ts ./
COPY src/ src/

RUN npm i

CMD npm run build && npm run start

