# 1) Base off the official n8n image
FROM n8nio/n8n:latest

# 2) Become root so we can install packages globally
USER root

# 3) Temporarily disable all lifecycle scripts so “only-allow pnpm” never runs
RUN npm install -g --ignore-scripts \
      n8n-nodes-firecrawl \
      n8n-nodes-scrapeninja \
    && npm cache clean --force

# 4) Revert to the non‑root user for security
USER node

# 5) Expose the standard n8n port and default to running n8n
EXPOSE 5678
# CMD ["n8n"]
