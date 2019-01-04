#!/bin/bash

# see https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86

# Enable bash to ping debug messages
set -x

# SIGTERM-handler
term_handler() {
    ncs --stop
    # exit 143; # 128 + 15 -- SIGTERM
    exit 0; # 128 + 15 -- SIGTERM
}

# source /root/nso/ncsrc

if [ "$1" == '' ]; then
    # This will kill then tail -f below, and then invoke ncs --stop
    trap 'kill ${!}; term_handler' SIGTERM

    source /opt/ncs/current/ncsrc
    /etc/init.d/ncs start

    # wait forever
    while true
    do
        tail -f /dev/null & wait ${!}
    done
else
    exec "$@"
fi
