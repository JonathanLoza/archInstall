# ArchLinux Install
## Base Packages
pacstrap /mnt base linux linux-firmware git intel-ucode sudo
## Locale gen
uncomment en and es
## User config
passwd<br>
useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash jonathan <br>
passwd jonathan <br>
EDITOR=VIM visudo <br>
Uncomment wheel <br>
## Reflector
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
## Install packages

chmod +x base.sh<br>
install base.sh

## Config grub

run: grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB<br>
modify /etc/default/grub<br>
grub timeout to 20<br>
uncomment disable os_prober<br>

run: grub-mkconfig -o /boot/grub/grub.cfg<br>
reboot

## Connect to internet

check enable networkd and resolved <br>
create symlink:<br>
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf<br>
iwctl<br>
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




