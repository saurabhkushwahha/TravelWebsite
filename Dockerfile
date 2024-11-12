# Build stage
FROM node:alpine
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

#Production stage
FROM node:alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.js ./
ENV NODE_ENV=production
EXPOSE 3000
CMD ["npm", "start"]