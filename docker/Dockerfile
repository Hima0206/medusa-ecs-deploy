FROM node:18

WORKDIR /app

COPY . .

RUN npm install -g medusa-cli

# Ensure medusa-config.js is present in the image
RUN test -f /app/medusa-config.js

CMD ["medusa", "start"]
EXPOSE 9000
