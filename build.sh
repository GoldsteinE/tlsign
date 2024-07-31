#!/bin/sh

set -ex

cd "$(dirname "$0")"

mkdir -p build

# Build rwrapper.
gcc -g rwrapper.c -lsodium -o build/rwrapper

# Build random_seed.
gcc -g random_seed.c -o build/random_seed

# Build requester.
cd requester
cargo build
target_dir="${CARGO_TARGET_DIR:-target}"
target_dir="$(realpath "$target_dir")"
requester_bin="${target_dir}/debug/requester"
cd ..
ln -sf "${requester_bin}" build/requester
