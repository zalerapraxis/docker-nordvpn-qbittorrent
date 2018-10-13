#!/bin/bash

if [ -z ${OPENPYN_COUNTRY} ]; then
    echo "Undefined the variable OPENPYN_COUNTRY"
    exit 1
fi

if [ -z ${OPENPYN_SERVERNUMBER} ]; then
    echo "Undefined the variable OPENPYN_SERVERNUMBER, set to default 5"
    export OPENPYN_SERVERNUMBER=5
fi

if [[ "${OPENPYN_P2P}" ]]; then
    OPENPYN_FLAGS="${OPENPYN_FLAGS} --p2p"
fi

if [[ ${OPENVPN_OPTS} ]]; then
    OPENPYN_OPTS="-o \"${OPENVPN_OPTS}\""
fi

sudo openpyn -c ${OPENPYN_COUNTRY} -t ${OPENPYN_SERVERNUMBER} ${OPENPYN_FLAGS} ${OPENPYN_OPTS}

