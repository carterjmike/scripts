#!/bin/bash
set -euo pipefail

# ------------------------------------------------
# A script to automate package installation
# after a fresh Arch Linux installation
# ------------------------------------------------

# Update system if needed
echo
echo "[*] CHECKING FOR UPDATES..."
sudo pacman -Syu

# Main packages to install {
declare -a MAIN_PKGS=(
"7zip"
"bash-completion"
"blas-openblas"
"blas64-openblas"
"bluez"
"bluez-utils"
#"bob"
"brightnessctl"
"cliphist"
"clang"
"cmake"
"easyeffects"
"fd"
"ffmpeg"
"firefox"
"flatpak"
"fwupd"
"fzf"
"gcc-fortran"
"gdal"
"gnome-disk-utility"
"gnome-keyring"
"gnome-themes-extra"
"grim"
"gvfs"
"hunspell-en_ca"
"hunspell-en_us"
"imagemagick"
"inkscape"
"kanshi"
"kitty"
#"ldns"
"libgit2"
"libreoffice-fresh"
"libsecret"
"libxml2"
"llvm"
"lm_sensors"
"lsb-release"
"meld"
"mpv"
"network-manager-applet"
"noto-fonts"
"noto-fonts-cjk"
"noto-fonts-emoji"
"nvme-cli"
"nwg-look"
"openssh"
"openssl"
"pacman-contrib"
"pamixer"
"pavucontrol"
"pdftk"
"pipewire"
"pipewire-alsa"
"pipewire-jack"
"pipewire-pulse"
"playerctl"
"polkit-gnome"
"python-dbus-fast"
"python-dbus-next"
"python-iwlib"
"python-pynvim"
"python-pyxdg"
"qt5ct"
"qt6ct"
"qtile"
"r"
"ripgrep"
"rofi"
"rust"
"satty"
"slurp"
"sox"
#"swaybg"
"swayidle"
"swaync"
"swayosd"
#"seahorse"
"stow"
"syncthing"
"system76-firmware"
"system76-scheduler"
"tesseract-data-eng"
"texlive-meta"
"thunar"
"thunar-archive-plugin"
"thunar-media-tags-plugin"
"thunar-volman"
"timeshift"
"tk"
"ttf-agave-nerd"
"ttf-dejavu"
"ttf-font-awesome"
"ttf-roboto"
"ttf-zed-mono-nerd"
"tumbler"
"udiskie"
"udisks2"
"uv"
"waybar"
"wireplumber"
"wl-clipboard"
"wl-clip-persist"
"wlr-randr"
"wlr-protocols"
"xarchiver"
"xdg-desktop-portal"
"xdg-desktop-portal-gtk"
"xdg-desktop-portal-wlr"
"xdg-user-dirs"
"xdg-utils"
"xorg-xwayland"
"yazi"
"zathura"
"zathura-pdf-mupdf"
"zed"
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
echo "[*] INSTALLING MAIN PACKAGES..."
sudo pacman -S --needed "${MAIN_PKGS[@]}"
echo
#echo "Installing packages for printing..."
#sudo pacman -S ${PRINT_PKGS[*]} --needed
#sudo systemctl enable --now cups.socket
#echo


# Create, modify, or overwrite some files
echo "Creating, modifying, or overwriting some files..."

# /etc/pam.d/login
sudo sed -i \
'/^[[:space:]]*auth[[:space:]]\+include[[:space:]]\+system-local-login$/{
  /pam_gnome_keyring\.so/!a auth       optional     pam_gnome_keyring.so
}' /etc/pam.d/login

sudo sed -i \
'/^[[:space:]]*session[[:space:]]\+include[[:space:]]\+system-local-login$/{
  /pam_gnome_keyring\.so/!a session    optional     pam_gnome_keyring.so auto_start
}' /etc/pam.d/login


# Enable some services for main packages
echo
echo "[*] ENABLING SOME SERVICES..."
sudo systemctl enable --now bluetooth.service
#sudo sed -i 's/^#\?AutoEnable=false/AutoEnable=true/' /etc/bluetooth/main.conf
#sudo systemctl enable --now avahi-daemon.service
sudo systemctl enable --now system76-firmware-daemon.service
echo

# Make personal directories
echo "[*] CREATE SOME DIRECTORIES..."
mkdir -p "$HOME"/Documents/{1_projects,2_areas,3_resources,4_archives}
mkdir -p "$HOME"/.local/{bin,build}
mkdir -p "$HOME"/.local/share/{applications,fonts,icons}
mkdir -p "$HOME"/.themes

# Create .gitignore
cat << 'EOF' > "$HOME/.gitignore"
.Rproj.user
.Rhistory
.Rdata
.httr-oauth
.DS_Store
.quarto
EOF

# Syncthing
wget https://raw.githubusercontent.com/syncthing/syncthing/refs/heads/main/etc/linux-systemd/system/syncthing%40.service
sudo chown root: syncthing@.service
sudo mv syncthing@.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now syncthing@$USER

#-- AUR Packages
echo "[*] INSTALLING PARU AS AUR HELPER..."
cd "$HOME"/.local/build && git clone https://aur.archlinux.org/paru.git
echo
cd paru && makepkg -si
cd "$HOME"

# AUR S76 packages and MangoWC dependencies to install {
declare -a AUR_PKGS=(
"system76-driver"
#"system76-dkms"
#"system76-io-dkms"
"system76-power"
"system76-keyboard-configurator"
"firmware-manager"
"qtile-extras"
"swaylock-effects"
"udunits"
#"wdisplays-persistent"
#"wlogout"
) # }

echo "[*] INSTALLING AUR PACKAGES..."
paru -S "${AUR_PKGS[@]}"
echo

echo "[*] ENABLING SOME S76 SERVICES..."
sudo systemctl enable --now system76.service
sudo systemctl enable --now com.system76.PowerDaemon.service
sudo systemctl enable --now charge-thresholds.service

echo "[*] CREATE USER DIRECTORIES"
xdg-user-dirs-update
echo

# Exit
echo "[*] ALL SYSTEMS GO!"
sleep 2
sleep 1
exit 0
