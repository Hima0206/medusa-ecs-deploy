FROM node:18

WORKDIR /app

COPY . .

RUN npm install -g medusa-cli
cmd ["medusa", "start"]
EXPOSE 9000

# This Dockerfile sets up a Medusa.js application.
# It uses Node.js 18 as the base image, copies the application files,   
# installs the necessary dependencies, and starts the Medusa server.
# The server listens on port 9000.
