FROM node:18

WORKDIR /app

COPY . .
COPY path/to/medusa-config.js /app/

# Debug command to verify file presence
RUN ls -al /app

RUN npm install -g medusa-cli

# Ensure medusa-config.js is present in the image
RUN test -f /app/medusa-config.js || (echo "medusa-config.js missing!" && exit 1)

CMD ["medusa", "start"]
EXPOSE 9000
