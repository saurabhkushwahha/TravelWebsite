# Build stage
FROM node:alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production

# Copy the built files and necessary configurations from the builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/package.json ./  # Ensure package.json is also copied

# Environment setup and port exposure
ENV NODE_ENV=production
EXPOSE 3000

# Start command for production
CMD ["npm", "start"]
