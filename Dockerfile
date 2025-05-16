# 1) Base image
FROM n8nio/n8n:latest

# 2) Switch to root to configure package managers
USER root

# 3) Tell pnpm exactly where to put its global binaries,
#    and make sure that directory is on the PATH
ENV PNPM_HOME="/pnpm"  
ENV PATH="$PNPM_HOME:$PATH"

# 4) Enable Corepack and prepare pnpm for use
RUN corepack enable \
 && corepack prepare pnpm@latest --activate

# 5) Bootstrap pnpm’s global‑bin dir
RUN pnpm setup

# 6) Install all your custom n8n community nodes in one shot
#    (add more packages here as you adopt them)
RUN pnpm install -g \
      n8n-nodes-firecrawl \
      n8n-nodes-scrapeninja \
    && pnpm store prune

# 7) Drop back to n8n’s non‑root user for safety
USER node

# 8) Expose the editor port and start n8n
EXPOSE 5678
CMD ["n8n"]
