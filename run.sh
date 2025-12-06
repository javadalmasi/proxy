#!/bin/bash
# Script to run the piped-proxy with HTTP/3 support enabled

RUSTFLAGS='--cfg reqwest_unstable' ./target/release/piped-proxy "$@"