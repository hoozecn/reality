#!/bin/sh

if [ -z "$@" ]; then
    if [ ! -f config.yaml ];then
        export HTTP_PORT=${HTTP_PORT:-7890}
        export SERVER_HOST=${SERVER_HOST:-}
        export SERVER_PORT=${SERVER_PORT:-443}
        export REALITY_SERVER_NAME=${REALITY_SERVER_NAME:-www.microsoft.com}
        export REALITY_PUBLIC_KEY=${REALITY_PUBLIC_KEY:-}
        export REALITY_SHORT_ID=${REALITY_SHORT_ID:-}
        export VLESS_ID=${VLESS_ID:-}
        [ -z "${SERVER_HOST}" ] && echo SERVER_HOST is empty && exit 1
        [ -z "${REALITY_PUBLIC_KEY}" ] && echo REALITY_PUBLIC_KEY is empty && exit 1
        [ -z "${REALITY_SHORT_ID}" ] && echo REALITY_SHORT_ID is empty && exit 1
        [ -z "${VLESS_ID}" ] && echo VLESS_ID is empty && exit 1
        envtpl config.yaml.tpl > config.yaml
   fi
   reality run --config ./config.yaml 
else
   exec $@
fi
