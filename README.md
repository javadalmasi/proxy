# Proxy

## Features

- **High Performance**: Built with Rust and Actix Web for optimal performance
- **SOCKS5 Support**: Can route traffic through SOCKS5 proxies for enhanced privacy and geo-bypass
- **Image Transcoding**: Optionally transcode images to WebP/AVIF to save bandwidth
- **Range Request Handling**: Properly handles HTTP range requests for media streaming
- **Caching Headers**: Preserves caching headers from upstream services
- **Cross-platform**: Runs anywhere Rust can compile to

## Architecture

This project acts as a reverse proxy that forwards requests to YouTube and other allowed domains, 
replacing the original host headers with the proxy server's address. This allows clients to 
bypass restrictions while maintaining proper functionality.

## Supported Domains

- youtube.com
- googlevideo.com
- ytimg.com
- ggpht.com
- googleusercontent.com
- lbryplayer.xyz
- odycdn.com
- ajay.app

## Configuration

### Environment Variables

- `BIND`: Address to bind the server to (default: `0.0.0.0:8080`)
- `UDS`: Set to `true` to use Unix Domain Socket instead of TCP
- `BIND_UNIX`: Path to Unix socket (default: `./socket/actix.sock`)
- `PROXY`: SOCKS5 proxy URL (e.g., `socks5://127.0.0.1:1080`)
- `PROXY_USER`: Username for proxy authentication
- `PROXY_PASS`: Password for proxy authentication
- `IPV4_ONLY`: Use IPv4 only (set to `true`)
- `IPV6_PREFERRED`: Prefer IPv6 over IPv4 when available (set to `true`)
- `HASH_SECRET`: Secret for URL hashing (requires `qhash` feature)
- `DISALLOW_IMAGE_TRANSCODING`: Disable image transcoding features

### Docker Setup

For a complete setup with Cloudflare WARP as a SOCKS5 proxy, see the [Docker documentation](DOCKER-README.md).

#### Quick Docker Compose Setup

```bash
# Clone the repository
git clone https://github.com/javadalmasi/proxy.git
cd proxy

# Create necessary directories
mkdir -p warp/data

# Run with Docker Compose
docker-compose up -d
```

## Building from Source

### Prerequisites

- Rust 1.70+
- NASM assembler (for image processing features)

### Build Steps

```bash
# Clone the repository
git clone https://github.com/javadalmasi/proxy.git
cd proxy

# Build the project
cargo build --release

# Run the proxy
./target/release/piped-proxy
```

## Environment-Specific Deployment

### Running with a SOCKS5 Proxy

To route all traffic through a SOCKS5 proxy:

```bash
PROXY=socks5://127.0.0.1:1080 ./target/release/piped-proxy
```

### Production Deployment

For production use, consider:

1. Setting up HTTPS reverse proxy with Nginx or similar
2. Using systemd service for process management
3. Configuring firewall rules to restrict access
4. Monitoring resource usage

## GitHub Container Registry (GHCR)

Pre-built images are available on GHCR:

```bash
docker pull ghcr.io/javadalmasi/proxy:latest
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, 
please open an issue first to discuss what you would like to change.

## License

This project is licensed under the AGPLv3 license - see the [LICENSE](LICENSE) file for details.
