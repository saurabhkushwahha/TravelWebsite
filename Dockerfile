# Build stage
FROM node:alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Verify output folder
RUN ls -l /app  # Check if 'out' exists

# Runtime stage
FROM node:alpine
WORKDIR /app
COPY --from=builder /app/out /app/out  # Adjust this path if necessary
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "out", "-l", "3000"]
