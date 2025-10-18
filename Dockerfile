# Stage 1: Build Stage
FROM node:22-slim AS build
WORKDIR /app

COPY package.json yarn.lock ./
RUN apt-get update && apt-get install -y cmake python3 make g++ \
  && yarn install --no-optional --frozen-lockfile --network-timeout 1000000 \
  && yarn cache clean

COPY . .
RUN yarn build

# Stage 2: Runtime Stage
FROM node:22-slim
WORKDIR /app

RUN addgroup --gid 1001 nodejs && \
    adduser --uid 1001 --ingroup nodejs nodejs

COPY package.json yarn.lock ./
RUN yarn install --production --frozen-lockfile --network-timeout 1000000 \
  && yarn cache clean

COPY --from=build /app/build ./build
COPY --from=build /app/server ./server
COPY --from=build /app/public ./public
COPY --from=build /app/.sequelizerc ./.sequelizerc

ENV NODE_ENV=production \
    FILE_STORAGE_LOCAL_ROOT_DIR=/var/lib/outline/data
VOLUME /var/lib/outline/data
EXPOSE 3000

USER nodejs

CMD ["yarn", "start"]
