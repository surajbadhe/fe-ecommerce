# --- Stage 1: Build Stage ---
# Use an official Node.js image as the builder environment
FROM node:20-alpine AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker layer caching
COPY package*.json ./
RUN npm install

# Copy the rest of the application's source code
COPY . .

# Build the application for production
RUN npm run build


# --- Stage 2: Production Stage ---
# Use a lightweight Nginx image to serve the static files
FROM nginx:1.27-alpine

# FIX: Changed the source directory from /app/build to /app/dist
# This should match the output directory of your build command.
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for the Nginx web server
EXPOSE 80

# The default command for the nginx image is to start the server, so no ENTRYPOINT is needed.
