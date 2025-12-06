# Docker Setup for Piped-Proxy with WARP SOCKS5 Proxy

This setup allows you to run piped-proxy with Cloudflare WARP as a SOCKS5 proxy to bypass regional restrictions.

## Prerequisites

- Docker and Docker Compose installed
- No running services on ports 8080 and 1080

## Setup

1. Create the required directory for WARP data:
   ```bash
   mkdir -p warp/data
   ```

2. Run the services:
   ```bash
   docker-compose up -d
   ```

## Configuration

- The WARP container runs on port 1080 (SOCKS5 proxy)
- The piped-proxy container connects to WARP as its upstream proxy
- Piped-proxy is accessible on port 8080

## Usage

Once the containers are running, your piped-proxy will be accessible at:
- `http://localhost:8080`

You can use this as a proxy for Piped or other applications that need to bypass regional restrictions.

## Environment Variables

The setup uses these environment variables:
- `PROXY=socks5://warp:1080` - Configures piped-proxy to route traffic through the WARP SOCKS5 proxy

## Stopping the Services

```bash
docker-compose down
```

## Logs

To check logs for a specific service:
```bash
docker-compose logs warp      # View WARP logs
docker-compose logs piped-proxy  # View piped-proxy logs
```

## Deploying to GitHub Container Registry (GHCR)

The repository includes a GitHub Actions workflow to automatically build and push the Docker image to GHCR. To use this:

1. Push your code to a GitHub repository named `proxy` under the `javadalmasi` organization/user
2. The workflow will automatically build the image on pushes to `main` branch or when tags are created
3. The image will be available at: `ghcr.io/javadalmasi/proxy:latest`

Make sure to enable "Read and write permissions" for Actions in your repository settings under Security > Actions.

### Using the published image

After the workflow runs successfully, you can pull the image with:
```bash
docker pull ghcr.io/javadalmasi/proxy:latest
```

Or update your docker-compose.yml to use the published image instead of building locally:
```yaml
piped-proxy:
  image: ghcr.io/javadalmasi/proxy:latest
  container_name: piped-proxy
  restart: always
  depends_on:
    - warp
  environment:
    - PROXY=socks5://warp:1080
    - BIND=0.0.0.0:8080
  ports:
    - '8080:8080'
```