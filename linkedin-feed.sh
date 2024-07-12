#!/bin/bash

feed_url=$1
post_file=posts/$(echo "${feed_url}" | sed 's/[^a-zA-Z0-9]/\./g' | sed 's/\.\{2,\}/./g')
next_post=$(rsstail -u "${feed_url}" -l -1 -n 1)

touch "${post_file}"

if [ "$(cat "${post_file}")" != "${next_post}" ]; then
    echo "${next_post}" > "${post_file}"
    linkedin.sh post "${post_file}"
fi
