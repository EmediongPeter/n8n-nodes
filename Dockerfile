# 1. Base image
FROM n8nio/n8n:latest

# 2. Become root so we can install globally
USER root

# 3) Enable Corepack and prepare pnpm (no EEXIST risk)
RUN corepack enable \
 && corepack prepare pnpm@latest --activate

# 4. Install all of your custom nodes in one step
RUN pnpm install -g \
      n8n-nodes-firecrawl \
      n8n-nodes-scrapeninja \
      # ← add new ones here as you adopt them
    && pnpm store prune

# 5. Revert to the non-root 'node' user
USER node

# 6. (Optional) Expose the port and set default command
EXPOSE 5678
CMD ["n8n"]
