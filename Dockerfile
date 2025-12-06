FROM rust:1.83-slim as build

WORKDIR /app/

# Copy source files
COPY . .

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nasm && \
    rm -rf /var/lib/apt/lists/*

# Build the application with the same flags as the build workflow
RUN RUSTFLAGS='-C target-feature=+crt-static' \
    cargo build --release --target x86_64-unknown-linux-gnu && \
    mv target/x86_64-unknown-linux-gnu/release/piped-proxy .

FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY --from=build /app/piped-proxy .

EXPOSE 8080

CMD ["/app/piped-proxy"]
