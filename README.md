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

<!-- serversideup-sponsors -->
## Our Sponsors
All of our software is free and open to the world. None of this can be brought to you without the financial backing of our sponsors.

<p align="center"><a href="https://github.com/sponsors/serversideup"><img src="https://521public.s3.amazonaws.com/serversideup/sponsors/sponsor-box.png" alt="Become a sponsor"></a></p>

### Platinum Sponsors
<a href="https://sevalla.com"><img src="https://serversideup.net/sponsors/sevalla.png" alt="Sevalla" width="500px"></a>

### Silver Sponsors
<a href="https://giga-infosystems.com"><img src="https://serversideup.net/sponsors/giga-infosystems.png" alt="GiGa infosystems" width="200px"></a>

### Infrastructure Sponsors
These companies give us free access to the tools and infrastructure we use to build, test, and ship our open source projects. Their support helps our entire community.

<a href="https://depot.dev"><img src="https://serversideup.net/sponsors/depot.png" alt="Depot" width="250px"></a>&nbsp;&nbsp;<a href="https://hub.docker.com/u/serversideup"><img src="https://serversideup.net/sponsors/docker.png" alt="Docker" width="250px"></a>
<!-- serversideup-sponsors -->

<!-- serversideup-about -->
## About Us
We're [Dan](https://x.com/danpastori) and [Jay](https://x.com/jaydrogers) - a two-person team with a passion for open source products. We created [Server Side Up](https://serversideup.net) to help share what we learn.

<div align="center">

| <div align="center">Dan Pastori</div> | <div align="center">Jay Rogers</div> |
| --- | --- |
| <div align="center"><a href="https://x.com/danpastori"><img src="https://serversideup.net/wp-content/uploads/2023/08/dan.jpg" title="Dan Pastori" width="150px"></a><br /><a href="https://x.com/danpastori"><img src="https://serversideup.net/logos/x.svg" title="X" width="24px"></a><a href="https://github.com/danpastori"><img src="https://serversideup.net/logos/github.svg" title="GitHub" width="24px"></a></div> | <div align="center"><a href="https://x.com/jaydrogers"><img src="https://serversideup.net/wp-content/uploads/2023/08/jay.jpg" title="Jay Rogers" width="150px"></a><br /><a href="https://x.com/jaydrogers"><img src="https://serversideup.net/logos/x.svg" title="X" width="24px"></a><a href="https://github.com/jaydrogers"><img src="https://serversideup.net/logos/github.svg" title="GitHub" width="24px"></a></div> |

</div>

### Find us at:

* **📖 [Blog](https://serversideup.net)** - Get the latest guides and free courses on all things web/mobile development.
* **🙋 [Community](https://community.serversideup.net)** - Get friendly help from our community members.
* **🤵‍♂️ [Get Professional Help](https://serversideup.net/professional-support)** - Get video + screen-sharing support from the core contributors.
* **💻 [GitHub](https://github.com/serversideup)** - Check out our other open source projects.
* **📫 [Newsletter](https://serversideup.net/subscribe)** - Skip the algorithms and get quality content right to your inbox.
* **🐥 [X (Twitter)](https://x.com/serversideup)** - You can also follow [Dan](https://x.com/danpastori) and [Jay](https://x.com/jaydrogers).
* **❤️ [Sponsor Us](https://github.com/sponsors/serversideup)** - Please consider sponsoring us so we can create more helpful resources.

## Our Products
If you appreciate this project, be sure to check out our other projects.

### 🛠️ Premium
- **[Self-Host Pro](https://selfhostpro.com)**: Sell self-hosted software in minutes.
- **[Bugflow](https://bugflow.io)**: Get product feedback directly in GitHub, GitLab, and more.
- **[Spin Pro](https://getspin.pro)**: Production-ready Docker templates for shipping quickly.

### 🌍 Open Source
- **[serversideup/php](https://serversideup.net/open-source/docker-php/)**: Supercharged PHP Docker images, based off the official PHP images. <!-- repo:serversideup/docker-php -->
- **[Spin](https://serversideup.net/open-source/spin/)**: Docker Simplified. Deploy Anywhere. Zero Downtime. Any OS. <!-- repo:serversideup/spin -->
- **[Financial Freedom](https://serversideup.net/open-source/financial-freedom/)**: Open source alternative to Mint, YNAB, and more. <!-- repo:serversideup/financial-freedom -->
- **[AmplitudeJS](https://serversideup.net/open-source/amplitudejs/)**: Customize the design of any element of the HTML5 Audio Player. <!-- repo:521dimensions/amplitudejs -->
- **[webext-bridge](https://serversideup.net/open-source/webext-bridge/)**: Messaging in Web Extensions made easy. Batteries included. <!-- repo:serversideup/webext-bridge -->
- **[serversideup/ansible](https://github.com/serversideup/docker-ansible)**: Run Ansible anywhere with a lightweight and powerful Docker image. <!-- repo:serversideup/docker-ansible -->

### 📚 Books
- **[Building Browser Extensions](https://serversideup.net/products/building-multi-platform-browser-extensions/)**: Build browser extensions for Firefox, Chrome, and more.
- **[Ultimate Guide To Building APIs & SPAs](https://serversideup.net/products/ultimate-guide-to-building-apis-and-spas-with-laravel-and-nuxt3/)**: Build web and mobile apps from the same codebase.
<!-- serversideup-about -->
