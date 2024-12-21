#!/bin/bash

# Set variables
REPO_URL="https://raw.githubusercontent.com/LycheeOrg/Lychee-Docker/refs/heads/master/configuration-with-caddy/"
DOCKER_COMPOSE_FILE="docker-compose.yml"
ENV_FILE=".env"
CADDYFILE="Caddyfile"

# Prompt for domain
read -p "Enter your domain name: " DOMAIN

# Download files from GitHub
curl -O "$REPO_URL/$DOCKER_COMPOSE_FILE" || { echo "Failed to download $DOCKER_COMPOSE_FILE"; exit 1; }
curl -O "$REPO_URL/$ENV_FILE" || { echo "Failed to download $ENV_FILE"; exit 1; }
curl -O "$REPO_URL/$CADDYFILE" || { echo "Failed to download $CADDYFILE"; exit 1; }

# Set MYSQL_ROOT_PASSWORD and MYSQL_LYCHEE_PASSWORD in the .env file
MYSQL_ROOT_PASSWORD="$(openssl rand -base64 12)"
MYSQL_LYCHEE_PASSWORD="$(openssl rand -base64 12)"

if [ -f "$ENV_FILE" ]; then
    sed -i "s/^MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD/" "$ENV_FILE"
    sed -i "s/^MYSQL_LYCHEE_PASSWORD=.*/MYSQL_LYCHEE_PASSWORD=$MYSQL_LYCHEE_PASSWORD/" "$ENV_FILE"
else
    echo "$ENV_FILE not found. Creating the file."
    echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" > "$ENV_FILE"
    echo "MYSQL_LYCHEE_PASSWORD=$MYSQL_LYCHEE_PASSWORD" >> "$ENV_FILE"
fi

# Replace domain placeholder in the Caddyfile
if [ -f "$CADDYFILE" ]; then
    sed -i "s/<YOUR_DOMAIN>/$DOMAIN/" "$CADDYFILE"
else
    echo "$CADDYFILE not found."
    exit 1
fi

# Display success message
echo "Files successfully downloaded and passwords set:"
echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD"
echo "MYSQL_LYCHEE_PASSWORD=$MYSQL_LYCHEE_PASSWORD"

echo "Caddyfile updated with domain: $DOMAIN"

echo "You can now run 'docker-compose up -d'."
