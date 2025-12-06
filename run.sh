#!/bin/bash
# Script to run the piped-proxy
# To run with HTTP/3 support: RUSTFLAGS='--cfg reqwest_unstable' ./target/release/piped-proxy "$@"

./target/release/piped-proxy "$@"