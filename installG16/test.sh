#!/bin/bash

if [ ! -d "/home/jonathan/iwd" ]; then
    mkdir -p /home/jonathan/iwd
fi

echo -e "[General]\nEnableNetworkConfiguration=true" > /home/jonathan/iwd/main.conf
