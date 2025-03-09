#!/bin/bash
pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

grep -q "\[g14\]" /etc/pacman.conf
if [ $? -ne 0 ]; then
    echo -e "\n[g14]\nServer = https://arch.asus-linux.org" >> /etc/pacman.conf
    echo "Repository [g14] added to /etc/pacman.conf."
fi

pacman -Suy

