# Example Docker Registry with Let's Encrypt SSL

This is a simple example of a Docker Registry with Let's Encrypt SSL. It uses Caddy as a reverse proxy and Let's Encrypt for SSL.

> [!CAUTION]
> This repo serves as a simple example of a Docker Registry with Let's Encrypt SSL. It isn't considered production-ready. We use this repo simply for testing purposes with other applications.

## Features

- 🔒 **Automatic HTTPS** - Let's Encrypt certificates via Caddy (zero configuration)
- 🔐 **Basic Authentication** - htpasswd-based user authentication
- 👥 **Multi-user Support** - Separate admin (read-write) and reader (read-only) accounts
- 🚀 **Easy Setup** - One-command deployment with Docker Compose
- 📦 **Latest Registry** - Uses Docker Registry v3 (OCI Distribution Spec compliant)
- 🔄 **Auto-renewal** - SSL certificates automatically renewed
- 📊 **HTTP/3 Support** - Modern protocol support out of the box

## Quick Start

### 1. Clone and Configure

```bash
# Copy environment template
cp env.example .env

# Edit with your domain and email
nano .env
```

Update `.env`:
```bash
REGISTRY_DOMAIN=registry.example.com  # Your actual domain
```

### 2. Create User Accounts

**Option A: Using the setup script (recommended)**
```bash
./setup.sh
```

**Option B: Manual setup**
```bash
mkdir -p auth

# Create admin user (read-write)
docker run --rm --entrypoint htpasswd httpd:2 -Bbn admin YourPassword > auth/htpasswd

# Add reader user (read-only)
docker run --rm --entrypoint htpasswd httpd:2 -Bbn reader YourPassword >> auth/htpasswd
```

### 3. Start the Registry

```bash
docker-compose up -d
```

### 4. Verify It Works

```bash
# Check logs
docker-compose logs -f

# Test the endpoint (wait ~30 seconds for cert generation)
curl https://registry.example.com/v2/
# Should return: {} (after authentication)
```

### 5. Use Your Registry

```bash
# Login
docker login registry.example.com
# Username: admin (or reader)

# Tag and push (admin only)
docker tag ubuntu:latest registry.example.com/myapp:latest
docker push registry.example.com/myapp:latest

# Pull (both users)
docker pull registry.example.com/myapp:latest
```

## Prerequisites

- **Docker** and **Docker Compose** installed
- **Domain name** with DNS A record pointing to your server
- **Ports 80 and 443** open on your firewall/security group
- **Public IP address** (required for Let's Encrypt validation)

## User Accounts

| User | Access | Use Case |
|------|--------|----------|
| `admin` | Read-Write | Push and pull images |
| `reader` | Read-Only* | Pull images only |

## Usage Examples

### Basic Operations

```bash
# Login to registry
docker login registry.example.com

# Pull an image from Docker Hub
docker pull alpine:latest

# Tag for your registry
docker tag alpine:latest registry.example.com/alpine:latest

# Push to your registry
docker push registry.example.com/alpine:latest

# Pull from your registry
docker pull registry.example.com/alpine:latest
```

### Managing Multiple Accounts

Add more users to the htpasswd file:

```bash
# Add a new user
docker run --rm --entrypoint htpasswd httpd:2 -Bbn newuser password >> auth/htpasswd

# Restart registry to apply changes
docker-compose restart registry
```

## About Us
We're [Dan](https://x.com/danpastori) and [Jay](https://x.com/jaydrogers) - a two person team with a passion for open source products. We created [Server Side Up](https://serversideup.net) to help share what we learn.

<div align="center">

| <div align="center">Dan Pastori</div>                  | <div align="center">Jay Rogers</div>                                 |
| ----------------------------- | ------------------------------------------ |
| <div align="center"><a href="https://x.com/danpastori"><img src="https://serversideup.net/wp-content/uploads/2023/08/dan.jpg" title="Dan Pastori" width="150px"></a><br /><a href="https://x.com/danpastori"><img src="https://serversideup.net/wp-content/themes/serversideup/images/open-source/twitter.svg" title="Twitter" width="24px"></a><a href="https://github.com/danpastori"><img src="https://serversideup.net/wp-content/themes/serversideup/images/open-source/github.svg" title="GitHub" width="24px"></a></div>                        | <div align="center"><a href="https://x.com/jaydrogers"><img src="https://serversideup.net/wp-content/uploads/2023/08/jay.jpg" title="Jay Rogers" width="150px"></a><br /><a href="https://x.com/jaydrogers"><img src="https://serversideup.net/wp-content/themes/serversideup/images/open-source/twitter.svg" title="Twitter" width="24px"></a><a href="https://github.com/jaydrogers"><img src="https://serversideup.net/wp-content/themes/serversideup/images/open-source/github.svg" title="GitHub" width="24px"></a></div>                                       |

</div>

### Find us at:

* **📖 [Blog](https://serversideup.net)** - Get the latest guides and free courses on all things web/mobile development.
* **🙋 [Community](https://community.serversideup.net)** - Get friendly help from our community members.
* **🤵‍♂️ [Get Professional Help](https://serversideup.net/hire-us)** - Get custom solutions built for your team.
* **💻 [GitHub](https://github.com/serversideup)** - Check out our other open source projects.
* **📫 [Newsletter](https://serversideup.net/subscribe)** - Skip the algorithms and get quality content right to your inbox.
* **🐥 [Twitter](https://x.com/serversideup)** - You can also follow [Dan](https://x.com/danpastori) and [Jay](https://x.com/jaydrogers).
* **❤️ [Sponsor Us](https://github.com/sponsors/serversideup)** - Please consider sponsoring us so we can create more helpful resources.

## Our products
If you appreciate this project, be sure to check out our other projects.

### 📚 Books
- **[The Ultimate Guide to Building APIs & SPAs](https://serversideup.net/ultimate-guide-to-building-apis-and-spas-with-laravel-and-nuxt3/)**: Build web & mobile apps from the same codebase.
- **[Building Multi-Platform Browser Extensions](https://serversideup.net/building-multi-platform-browser-extensions/)**: Ship extensions to all browsers from the same codebase.

### 🛠️ Software-as-a-Service
- **[Bugflow](https://bugflow.io/)**: Get visual bug reports directly in GitHub, GitLab, and more.
- **[SelfHost Pro](https://selfhostpro.com/)**: Connect Stripe or Lemonsqueezy to a private docker registry for self-hosted apps.

### 🌍 Open Source
- **[AmplitudeJS](https://521dimensions.com/open-source/amplitudejs)**: Open-source HTML5 & JavaScript Web Audio Library.
- **[Spin](https://serversideup.net/open-source/spin/)**: Laravel Sail alternative for running Docker from development → production.
- **[Financial Freedom](https://github.com/serversideup/financial-freedom)**: Open source alternative to Mint, YNAB, & Monarch Money.
