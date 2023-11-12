# Use an official Node.js runtime based on Alpine Linux as the base image
FROM node:16.14-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the package.json and package-lock.json files from your host to the container's working directory
COPY package*.json ./

# Install the app's dependencies using npm
# RUN npm ci

# Copy the rest of the app's files from your host to the container's working directory
COPY . .

# Build the app using the npm script specified in package.json
RUN npm run build

# Use an official Nginx image based on Alpine Linux as the base image for the second build stage
FROM nginx:1.21.3-alpine

# Copy the build artifacts from the first build stage to the Nginx image
COPY --from=0 /app/dist/super-hero.ui /usr/share/nginx/html


# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
