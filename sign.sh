#!/bin/sh

set -eu

cd "$(dirname "$0")"
. ./common.sh

host="$(trurl --get '{host}' "$url")"
port="$(trurl --get '{port}' "$url")"
port="${port:-443}"

RWRAPPER_SEED="$(build/random_seed)"
printf "%llu" "$RWRAPPER_SEED" > "${data_dir}/seed"
export RWRAPPER_SEED

socat -r "${data_dir}/ltr" -R "${data_dir}/rtl" TCP-LISTEN:44444 "TCP:${host}:${port}" &

build/rwrapper build/requester "$url" > "${data_dir}/data"

wait
