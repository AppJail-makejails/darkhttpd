#!/bin/sh

. /lib.subr

set -e

create_user

if [ $# -eq 0 ]; then
    exec darkhttpd . --chroot --uid noroot --gid noroot
fi

exec "$@"
