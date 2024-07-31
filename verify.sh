#!/bin/sh

set -eu

cd "$(dirname "$0")"
. ./common.sh

work_dir="$(mktemp -d)"
printf "Working directory is '%s': if verification fails, you can check the files there.\n" "${work_dir}" >&2

RWRAPPER_SEED="$(cat "${data_dir}/seed")"
export RWRAPPER_SEED

socat -r "${work_dir}/ltr" -R "${work_dir}/rtl" TCP-LISTEN:44444 - < "${data_dir}/rtl" > "${work_dir}/received" &

if ! build/rwrapper build/requester "$url" > "${work_dir}/data"; then
	printf 'Verification failed: requester returned non-zero.\n' >&2
	exit 1
fi

wait

if ! cmp "${data_dir}/data" "${work_dir}/data"; then
	printf 'Verification failed: data files differ.\n' >&2
	exit 1
fi

if ! cmp "${data_dir}/ltr" "${work_dir}/ltr"; then
	printf 'Verification failed: request files differ.\n' >&2
	exit 1
fi

rm -r "${work_dir}"
printf 'Verification success!\n'
