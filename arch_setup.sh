#!/bin/bash
#set -e

# -------------------------------------------------------
# A script to automate personal package installation 
# after a fresh Arch Linux installation
#
# Some ideas and code adapted from other sources, mainly 
# the Arch Wiki and the ArchLabs Linux installer
# (https://bitbucket.org/archlabslinux/installer) 
#
# Written by Michael Carter
# -------------------------------------------------------

# Run any updates if needed
echo
echo "Running any available updates..."
sudo pacman -Syu

# System, window manger, and program packages to install {
typeset -a MAIN_PKGS=(
"arandr"
"autorandr"
"bash-completion"
"bat"
"blas-openblas"
"blas64-openblas"
"bluez"
"bluez-utils"
"brightnessctl"
"btop"
"curl"
#"dconf-editor"
"dunst"
"e2fsprogs"
"efibootmgr"
"efivar"
#"evince"
"exfatprogs"
"exfat-utils"
"ffmpeg"
"firefox"
"fzf"
"gcc-fortran"
"gnome-disk-utility"
"gnome-themes-extra"
"gpick"
"gtk-engine-murrine"
"gvfs"
"hunspell-en_ca"
"hunspell-en_us"
"imagemagick"
"inkscape"
"kitty"
#"ldns"
"libgit2"
"libreoffice-fresh"
"libsecret"
"linux-headers"
"lm_sensors"
"lsb-release"
"meld"
"mesa"
"mpv"
"network-manager-applet"
"noto-fonts"
"noto-fonts-cjk"
"noto-fonts-emoji"
"openssh"
"pacman-contrib"
"pavucontrol"
"picom"
"pipewire"
"pipewire-alsa"
"pipewire-jack"
"pipewire-pulse"
"playerctl"
"polkit-gnome"
"python-dbus-next"
"python-iwlib"
"python-pip"
"python-psutil"
"python-setproctitle"
"python-pyxdg"
"python-wheel"
"qt5ct"
"qt6ct"
"qtile"
"r"
"reflector"
"rofi"
"rust"
"scrot"
"seahorse"
"stow"
#"sxhkd"
"system76-firmware"
"texlive-meta"
"thunar"
"thunar-archive-plugin"
"thunar-media-tags-plugin"
"thunar-volman"
"tk"
"ttf-dejavu"
"ttf-font-awesome"
"ttf-jetbrains-mono"
"ttf-joypixels"
"ttf-roboto"
"tumbler"
"wget"
"wireplumber"
"wmctrl"
"xarchiver"
"xcb-proto"
"xcb-util"
"xcb-util-keysyms"
"xcb-util-cursor"
"xcb-util-wm"
"xclip"
"xdg-user-dirs"
"xdg-utils"
"xdotool"
"xf86-input-libinput"
#"xf86-video-amdgpu"
#"xf86-video-intel"
"xorg"
"xorg-xinit"
"zathura"
"zathura-pdf-mupdf"
) # }

# Printer packages to install {
#typeset -a PRINT_PKGS=(
#"cups"
#"cups-filters"
#"cups-pdf"
#"cups-pk-helper"
#"ghostscript"
#"gsfonts"
#"gutenprint"
#"hplip"
#"simple-scan"
#"system-config-printer"
#) # }

# Install packages
echo
echo "Installing main packages..."
sudo pacman -S ${MAIN_PKGS[*]} --needed
echo
#echo "Installing packages for printing..."
#sudo pacman -S ${PRINT_PKGS[*]} --needed
#sudo systemctl enable --now cups.socket
#echo

# Enable some services
echo
echo "Enabling some services..."
sudo systemctl enable --now bluetooth.service
#sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
sudo systemctl enable --now avahi-daemon.service
sudo systemtl enable --now system76-firmware-daemon.service
echo

# Create, modify, or overwrite some files
echo "Creating, modifying, or overwriting some files..."

# /etc/pam.d/login
sudo sed -i \
'/auth       include      system-local-login/a auth       optional     pam_gnome_keyring.so' \
/etc/pam.d/login

sudo sed -i \
'/session    include      system-local-login/a session    optional     pam_gnome_keyring.so auto_start' \
/etc/pam.d/login

# Exit
echo
echo "Installation completed succesfully!"
sleep 2
echo "Exiting..."
sleep 1
exit 0
