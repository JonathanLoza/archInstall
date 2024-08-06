#!/bin/bash

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


pacman -Sy grub efibootmgr base-devel linux-headers os-prober bluez bluez-utils blueman iwd alsa-utils pulseaudio pulseaudio-alsa pavucontrol ntfs-3g acpi acpid openssh reflector rsync firefox htop neofetch nano dosfstools mtools kitty xterm feh picom fish cargo cmake gcc p7zip zathura zathura-pdf-mupdf bat curl wget xdg-utils unzip fuse3 neovim docker

systemctl enable bluetooth
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable acpid
systemctl enable iwd
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl enable docker
