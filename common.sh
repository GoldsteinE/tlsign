#!/bin/sh

usage() {
	echo "usage: $0 <url> <data dir>"
	exit 1
}

cleanup() {
	kill %socat 2>/dev/null ||:
}
trap cleanup TERM INT EXIT

url="${1:-}"
if [ -z "$url" ]; then
	usage
fi

data_dir="${2:-}"
if [ -z "$data_dir" ]; then
	usage
fi
mkdir -p "${data_dir}"
