# Base image
FROM node:16-alpine as base

# Install dependencies
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

# Build the app
COPY . .
RUN npm run build

# # Production image
# FROM node:16-alpine as production
# WORKDIR /app

# # Copy built files from the build stage
# COPY --from=base /app/.next ./.next
# COPY --from=base /app/public ./public
# COPY --from=base /app/package.json .
# COPY --from=base /app/package-lock.json .

# Environment setup and port exposure
ENV NODE_ENV=production
EXPOSE 3000

# Start command for production
CMD ["npm", "start"]