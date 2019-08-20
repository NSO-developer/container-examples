#!/bin/bash

# see https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86

# Enable bash to ping debug messages
set -x

ncsdir=/opt/ncs/current
confdir=/etc/ncs
rundir=/var/opt/ncs
logdir=/var/log/ncs

ncs=${ncsdir}/bin/ncs
prog=ncs
conf="-c ${confdir}/ncs.conf"

test -x $ncs || exit 1

setup_ncs_environment () {
    . ${ncsdir}/ncsrc
    NCS_CONFIG_DIR=${confdir}
    NCS_RUN_DIR=${rundir}
    NCS_LOG_DIR=${logdir}
    export NCS_CONFIG_DIR NCS_RUN_DIR NCS_LOG_DIR
}

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

    setup_ncs_environment
    # /etc/init.d/ncs start

    # Do we have a env var containing a password available?
    if [ "x$ADMIN_PWD" != "x" ]
    then
        echo "admin:$ADMIN_PWD" | chpasswd
    fi

    echo "NCS_RUN_DIR: $NCS_RUN_DIR"

    # wait forever
    $ncs --cd ${rundir} ${conf} --foreground -v & wait ${!}
else
    exec "$@"
fi
