#!/bin/bash
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap -K /mnt base linux linux-firmware git amd-ucode sudo vim
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

