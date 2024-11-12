# Build stage
FROM node:alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build  # This should generate the `out` folder

# Runtime stage
FROM node:alpine
WORKDIR /app
COPY --from=builder /app/out /app/out
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "out", "-l", "3000"]
