FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install custom nodes globally
RUN npm install -g n8n-nodes-firecrawl

# Revert to the default 'node' user for security
USER node
