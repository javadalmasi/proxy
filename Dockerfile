FROM rust:slim as BUILD

WORKDIR /app/

COPY . .

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nasm && \
    rm -rf /var/lib/apt/lists/*

# Build the application with static linking
RUN RUSTFLAGS='-C target-feature=+crt-static' \
    cargo build --release --target x86_64-unknown-linux-gnu && \
    mv target/x86_64-unknown-linux-gnu/release/piped-proxy .

FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY --from=BUILD /app/piped-proxy .

EXPOSE 8080

CMD ["/app/piped-proxy"]
