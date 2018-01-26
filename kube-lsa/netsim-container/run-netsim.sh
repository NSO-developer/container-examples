#!/bin/bash

# see https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86

# Enable bash to ping debug messages
set -x

# SIGTERM-handler
term_handler() {
    ncs-netsim stop
    exit 143; # 128 + 15 -- SIGTERM
}

source /root/nso/ncsrc

if [ "$1" == '' ]; then
    cd /root/nso-project
    # This will kill then tail -f below, and then invoke ncs --stop
    trap 'kill ${!}; term_handler' SIGTERM

    ncs-netsim start

    # wait forever
    while true
    do
        tail -f /dev/null & wait ${!}
    done
else
    exec "$@"
fi

