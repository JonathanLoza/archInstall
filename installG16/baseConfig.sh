#!/bin/bash

if [ -z "$1" ]; then
    echo "Missing boot dir"
    exit 1
fi

ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
hwclock --systohc
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf
echo "XKBLAYOUT=latam" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts


pacman -Sy refind efibootmgr base-devel linux-headers iwd acpi acpid reflector firefox nano kitty xterm fish cargo cmake gcc bat curl wget xdg-utils fuse3 neovim

systemctl enable reflector.timer
systemctl enable acpid
systemctl enable iwd
systemctl enable systemd-networkd
systemctl enable systemd-resolved

ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf  

echo -e "[Match]\nName=en*\n\n[Network]\nDHCP=yes" > /etc/systemd/network/20-wired.network

if [ ! -d "/etc/iwd" ]; then
    mkdir -p /etc/iwd
fi

echo -e "[General]\nEnableNetworkConfiguration=true" > /etc/iwd/main.conf

refind-install --usedefault "$1"  --alldrivers
mkrlconf

passwd
useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash jonathan
passwd jonathan  
EDITOR=vim visudo

