FROM node:18

WORKDIR /app

# Copy everything
COPY . .

# Make sure medusa-config.js is present AFTER copying all files
RUN test -f /app/medusa-config.js || (echo "medusa-config.js missing!" && exit 1)

# Install dependencies — prefer local install
RUN npm install

# OPTIONAL: Install medusa-cli globally (only for CLI access)
RUN npm install -g medusa-cli

# Start via script for safety
CMD ["npm", "start"]

EXPOSE 9000
