# ArchLinux Install
## Base Packages
pacstrap /mnt base linux linux-firmware git intel-ucode sudo
## Locale gen
uncomment en and es
## User config
passwd
useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash jonathan
passwd jonathan
EDITOR=VIM visudo
Uncomment wheel
## Reflector
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
## Install packages

chmod +x base.sh
install base.sh

## Config grub

run: grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
modify /etc/default/grub
grub timeout to 20
uncomment disable os_prober

run: grub-mkconfig -o /boot/grub/grub.cfg
reboot

## Connect to internet

check enable networkd and resolved 
create symlink:
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
iwctl
device list
device name set-property Powered on
adapter adapter set-property Powered on
station name scane
station name get-networks
station name connect SSID
station name show
station device disconnect

create /etc/systemd/network/20-wired.network
[Match]
Name=en*

[Network]
DHCP=yes

if you get a dhcp error on iwctl, make the file /etc/iwd/main.conf with those 2 lines;

[General]
EnableNetworkConfiguration=true

## Install nvidia
run nvidia.sh

## Install xmonad

run xmonad.sh
enable lightdm service
config lightdm greeter-session=lightdm-yourgreeter-greeter in /etc/lightdm/lightdm.conf
recompile xmonad

## Config

check xrandr monitor names and configure xmonad.hs
install nerdfonts:
- create /usr/local/share/fonts
- paste ttf fonts to dir
- fc-cache
increase laptop monitor backlight
install acpilight and remove xorg-xbacklight
xbacklight -set 100
set color to pacman by uncomment Color in /etc/pacman.conf

## Instal AUR

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
install paru and run paru.sh
xdg-settings set default-web-browser brave.desktop

## Set fish

chsh -s /bin/fish
install oh my fish
set them bobthefish




