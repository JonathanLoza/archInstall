# Base ArchInstall G16

run timedatectl  

Partition with cfdisk /dev/disk  

Format with mkfs.ext4 and mkfs.fat -F 32  

Mount /mnt /mnt/home /mnt/boot  

Run preChroot.sh  

uncomment en and es in /etc/locale.gen  

Run baseConfig.sh  

Modify /boot/refind_linux.conf , remove invalid entries

Modify /boot/EFI/BOOT/refind and add your boot partition there
