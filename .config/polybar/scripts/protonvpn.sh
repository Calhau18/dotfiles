#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function connect_vpn () {
    protonvpn c -f
}

function disconnect_vpn () {
    protonvpn d
}

function is_vpn_connected () {
    status=$(protonvpn s | grep Status: | awk '{ print $2 }')
    if [[ $status == "Connected" ]]; then
        echo 0
    else
        echo 1
    fi
}

function toggle_vpn () {
    connected=`is_vpn_connected`
    if [[ $connected -eq 0 ]]; then
        connect_vpn
    else
        disconnect_vpn
    fi
}

function output () {
    out=""
    connected=`is_vpn_connected`
    if [[ $connected -eq 0 ]]; then
        out=(`protonvpn s | grep Server: | awk '{ print $2 }'`)
    else
        out=""
    fi
    echo "$out"
}
while getopts 'oat' c
do
    case $c in
        o) output ;;
	a) is_vpn_connected ;;
        t) toggle_vpn ;;
    esac
done
