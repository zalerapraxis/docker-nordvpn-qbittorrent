#!/usr/bin/env bash

# Connection\Proxy\IP=url.com
# Connection\Proxy\Username=username@mail.com
# Connection\Proxy\Password=s3cr3t
# Connection\Proxy\Port=1080
# Connection\ProxyType=2        # (SOCKS5)

if [ -z $1 ]; then
    echo "Error: no first argument, should give the path to the config file"
    exit 1
fi

if [ -z $2 ]; then
    echo "Error: no second argument, should give the IP of the proxy server"
    exit 1
else
    # echo "Setting QBITTORRENT_PROXY_IP to $2"
    QBITTORRENT_PROXY_IP=$2
fi

if [ -z $3 ]; then
    echo "Error: no 3rd argument, should give the username of the proxy server"
    exit 1
else
    # echo "Setting QBITTORRENT_PROXY_USERNAME to $3"
    QBITTORRENT_PROXY_USERNAME=$3
fi

if [ -z $4 ]; then
    echo "Error: no 4th argument, should give the password of the proxy server"
    exit 1
else
    # echo "Setting QBITTORRENT_PROXY_PASSWORD to $4"
    QBITTORRENT_PROXY_PASSWORD=$4
fi

if [ -z $5 ]; then
    echo "Error: no 5th argument, should give the port of the proxy server"
    exit 1
else
    # echo "Setting QBITTORRENT_PROXY_PORT to $5"
    QBITTORRENT_PROXY_PORT=$5
fi

QBITTORRENT_PROXY_TYPE=2

sed -i -E "s/(Connection\\\Proxy\\\IP=)(.*)/\1${QBITTORRENT_PROXY_IP}/g" $1
sed -i -E "s/(Connection\\\Proxy\\\Username=)(.*)/\1${QBITTORRENT_PROXY_USERNAME}/g" $1
sed -i -E "s/(Connection\\\Proxy\\\Password=)(.*)/\1${QBITTORRENT_PROXY_PASSWORD}/g" $1
sed -i -E "s/(Connection\\\Proxy\\\Port=)(.*)/\1${QBITTORRENT_PROXY_PORT}/g" $1
sed -i -E "s/(Connection\\\ProxyType=)(.*)/\1${QBITTORRENT_PROXY_TYPE}/g" $1
