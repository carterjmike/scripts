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


# Check if any updates are available
echo
echo "Checking if any updates are available..."
sudo pacman -Syu


# Packages to install {
typeset -a USER_PKGS=(
"arandr"
"autorandr"
"bash-completion"
"bat"
"blas-openblas"
"blas64-openblas"
"bluez"
"bluez-utils"
"brightnessctl"
"curl"
"dconf-editor"
"dunst"
#"evince"
"ffmpeg"
"firefox"
"fzf"
"gcc-fortran"
"gnome-disk-utility"
"gnome-themes-extra"
"gpick"
"gvfs"
"htop"
"hunspell-en_ca"
"hunspell-en_us"
"imagemagick"
"inkscape"
"libgit2"
"libreoffice-fresh"
"libsecret"
"linux-headers"
#"lxappearance-gtk3"
"mpv"
"noto-fonts"
"noto-fonts-cjk"
"noto-fonts-emoji"
"pavucontrol"
"picom"
"playerctl"
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
"rofi"
"rust"
"scrot"
"seahorse"
"stow"
#"sxhkd"
"texlive-meta"
"thunar"
"thunar-archive-plugin"
"thunar-media-tags-plugin"
"thunar-volman"
"tk"
"ttf-font-awesome"
"ttf-jetbrains-mono"
"ttf-joypixels"
"ttf-roboto"
"tumbler"
"wezterm"
"wget"
"wmctrl"
"xarchiver"
"xcb-proto"
"xcb-util"
"xcb-util-keysyms"
"xcb-util-cursor"
"xcb-util-wm"
"xclip"
"xdotool"
"zathura"
"zathura-pdf-mupdf"
#"zsh"
#"zsh-autosuggestions"
#"zsh-completions"
#"zsh-history-substring-search"
#"zsh-syntax-highlighting"
) # }


# Packages to install {
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


# Packages to install {
typeset -a FLATPAKS=(
"com.github.tchx84.Flatseal"
#"com.google.Chrome"
#"com.obsproject.Studio"
#"com.slack.Slack"
#"com.spotify.Client"
#"org.audacityteam.Audacity"
#"org.gnome.DejaDup"
#"org.gnome.GTG"
#"org.gnome.World.PikaBackup"
"org.jamovi.jamovi"
#"org.olivevideoeditor.Olive"
#"org.zotero.Zotero"
#"us.zoom.Zoom"
) # }


# Install packages
echo
echo "Installing packages from arch repo..."
sudo pacman -S ${USER_PKGS[*]} --needed
echo
#echo "Installing packages for printing..."
#sudo pacman -S ${PRINT_PKGS[*]} --needed
#sudo systemctl enable --now cups.socket
#echo
echo "Installing flatpaks from flathub"
flatpak install flathub ${FLATPAKS[*]} -y
echo
echo "Refresh font cache for jamovi"
flatpak run --command=fc-cache org.jamovi.jamovi -f -v


# Enable some services
echo
echo "Enabling bluetooth support..."
sudo systemctl enable --now bluetooth.service
#sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
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


# Change shell to zsh
#echo
#echo "Changing shell to zsh"
#chsh -s $(which zsh)


# Exit
echo
echo "Installation completed succesfully!"
sleep 2
echo "Exiting..."
sleep 1
exit 0
