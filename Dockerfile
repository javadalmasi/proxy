FROM rust:1.83-slim as build

WORKDIR /app/

COPY . .

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nasm && \
    rm -rf /var/lib/apt/lists/*

# Build the application
RUN cargo build --release && \
    mv target/release/piped-proxy .

FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY --from=build /app/piped-proxy .

EXPOSE 8080

CMD ["/app/piped-proxy"]
