FROM node:9-alpine

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT ${SOURCE_COMMIT}
ARG DOCKER_TAG
ENV DOCKER_TAG ${DOCKER_TAG}

ENV NPM_CONFIG_LOGLEVEL warn

RUN apk add --no-cache git nano

RUN npm config set unsafe-perm true
RUN npm i npm@latest -g

WORKDIR /var/app
RUN mkdir -p /var/app


ADD package.json yarn.lock /var/app/
RUN yarn install --non-interactive --frozen-lockfile

COPY . /var/app

# FIXME TODO: fix eslint warnings

#RUN mkdir tmp && \
#  npm test && \
#  ./node_modules/.bin/eslint . && \
#  npm run build
#RUN yarn fmt

#RUN yarn storybook-build

RUN mkdir tmp && \
    yarn test && yarn build

ENV PORT 8080
ENV NODE_ENV production

EXPOSE 8080

CMD [ "yarn", "run", "production" ]

# uncomment the lines below to run it in development mode
# ENV NODE_ENV development
# CMD [ "yarn", "run", "start" ]
