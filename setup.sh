#!/bin/bash

# Docker Registry Setup Script
# This script helps you set up the authentication for your Docker registry

echo "=========================================="
echo "Docker Registry Setup"
echo "=========================================="
echo ""

# Create auth directory
echo "Creating auth directory..."
mkdir -p auth

echo ""
echo "Now we'll create the user accounts."
echo ""

# Admin user
echo "Creating admin user (read-write access):"
read -p "Enter password for 'admin' user: " -s ADMIN_PASS
echo ""
docker run --rm --entrypoint htpasswd httpd:2 -Bbn admin "$ADMIN_PASS" > auth/htpasswd

echo "✓ Admin user created"
echo ""

# Reader user
echo "Creating reader user (read-only access):"
read -p "Enter password for 'reader' user: " -s READER_PASS
echo ""
docker run --rm --entrypoint htpasswd httpd:2 -Bbn reader "$READER_PASS" >> auth/htpasswd

echo "✓ Reader user created"
echo ""

echo "=========================================="
echo "Setup complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Edit docker-compose.yml and update DOMAIN and EMAIL"
echo "2. Run: docker-compose up -d"
echo "3. Check logs: docker-compose logs -f"
echo ""
echo "Your credentials:"
echo "  Admin (read-write): admin / [password you entered]"
echo "  Reader (read-only): reader / [password you entered]"
echo ""

