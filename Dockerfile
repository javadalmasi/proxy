# Runtime image that expects the binary to be built separately
FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/

# Copy the pre-built binary
COPY piped-proxy /app/piped-proxy

EXPOSE 8080

CMD ["/app/piped-proxy"]
