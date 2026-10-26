FROM node:24.20.0-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends chromium ffmpeg espeak-ng ca-certificates tini && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build && mkdir -p /app/data /app/media && chown -R node:node /app
USER node
ENV NODE_ENV=production HOST=0.0.0.0 BROWSER_EXECUTABLE=/usr/bin/chromium FFMPEG_PATH=/usr/bin/ffmpeg FFPROBE_PATH=/usr/bin/ffprobe DATA_DIR=/app/data LOCAL_STORAGE_PATH=/app/media STORAGE_PROVIDER=local
EXPOSE 3000
ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["npm","start"]
