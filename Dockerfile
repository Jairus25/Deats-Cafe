# ─── Stage 1: Build ───────────────────────────────────────────────────────────
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# ─── Stage 2: Production ──────────────────────────────────────────────────────
FROM node:22-alpine AS production
WORKDIR /app

# Security: run as non-root
RUN addgroup -S deats && adduser -S deats -G deats

COPY --from=builder /app/node_modules ./node_modules
COPY backend/ ./backend/
COPY frontend/ ./frontend/
COPY package.json ./

# Set ownership
RUN chown -R deats:deats /app
USER deats

EXPOSE 5000
ENV NODE_ENV=production PORT=5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:5000/api/health || exit 1

CMD ["node", "backend/server.js"]
