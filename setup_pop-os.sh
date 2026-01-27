#!/bin/bash
#set -e

# -------------------------------------------------------
# A script to automate personal package installation after a fresh
# Pop!_OS installation using the rust based COSMIC desktop
#
# Written by Michael Carter
#
# Some ideas and code adapted from other sources, mainly the ArchLabs
# installer (https://www.archlabslinux.com) and the Arch Wiki
# -------------------------------------------------------

echo "[*] ADDING SOURCES FOR SOME PROGRAMS"

# R
echo
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
echo
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Zulip
echo
sudo curl -fL -o /etc/apt/trusted.gpg.d/zulip-desktop.asc \
    https://download.zulip.com/desktop/apt/zulip-desktop.asc
echo "deb https://download.zulip.com/desktop/apt stable main" | sudo tee /etc/apt/sources.list.d/zulip-desktop.list
echo

# Zotero
echo
curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
echo

# Spotify
echo
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Setup to use r-rig to manage R installations
#echo
#`which sudo` curl -L https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg
#echo
#`which sudo` sh -c 'echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list'

# Check if there are any packages to upgrade
echo
echo "[*] CHECKING FOR UPDATES..."
sudo apt update && sudo apt upgrade

# Packages to install {
declare -a MAIN_PKGS=(
"biber"
"clang"
"cmake"
"exfatprogs"
"ffmpeg"
"fzf"
"gir1.2-gtop-2.0"
#"hplip"
"imagemagick"
"jags"
"just"
"libcairo2-dev"
"libclang-dev"
"libcurl4-openssl-dev"
"libfftw3-dev"
"libfontconfig1-dev"
"libfribidi-dev"
"libgdal-dev"
"libgit2-dev"
"libgmp-dev"
"libgmp3-dev"
"libgsl-dev"
"libharfbuzz-dev"
"libmagick++-dev"
"libmpfr-dev"
"libnlopt-dev"
"libnode-dev"
"libopenblas-dev"
"libpoppler-cpp-dev"
"librust-xkbcommon-dev"
"libsecret-1-dev"
"libssl-dev"
"libudunits2-dev"
"libxt-dev"
"meld"
"mpv"
"ninja-build"
"nvme-cli"
#"nodejs"
#"npm"
"nvme-cli"
"pdftk-java"
"python3-pynvim"
"qt5ct"
"qt6ct"
"r-base"
#"r-rig"
"ripgrep"
#"sane"
"smartmontools"
"spotify-client"
"stow"
"system76-keyboard-configurator"
"texlive-full"
#"ttf-mscorefonts-installer"
"wl-clipboard"
"zotero"
"zulip"
) # }

# Install repo packages
echo
echo "[*] INSTALLING PACKAGES..."
sudo apt install ${MAIN_PKGS[*]} -y


# Make personal directories
#echo "Create personal directories"
mkdir -p $HOME/Documents/{1_projects,2_areas,3_resources,4_archives}
mkdir -p $HOME/.local/{bin,build}
mkdir -p $HOME/.local/share/{applications,fonts,icons}
#mkdir -p $HOME/.themes

# Create .gitignore
cat << 'EOF' > "$HOME/.gitignore"
.Rproj.user
.Rhistory
.Rdata
.httr-oauth
.DS_Store
.quarto
EOF

# Systemd services, sockets, timers
sudo systemctl enable --now fstrim.timer
#sudo systemctl disable --now cups.service
#sudo systemctl enable --now cups.socket
#sudo systemctl restart cups-browsed.service  # can fix printer issue

# Disable these applications from search
echo "NoDisplay=true" | sudo tee -a \
/usr/share/applications/vim.desktop \
/usr/share/applications/prerex.desktop \
/usr/share/applications/vprerex.desktop \
/usr/share/applications/texdoctk.desktop \
/usr/share/applications/display-im6.q16.desktop > /dev/null

# Make libsecret for git credentials
cd /usr/share/doc/git/contrib/credential/libsecret && sudo make

echo
echo
echo "[*] ALL SYSTEMS GO!"
sleep 2
sleep 1
exit 0


# SOME NOTES...
# for lm-sensors
#sudo sensors-detect

# Syncthing after downloading from website - updated instructions to stable v2
# check website for any changes: https://apt.syncthing.net/
#sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
#echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable-v2" | sudo tee /etc/apt/sources.list.d/syncthing.list
#sudo apt update
#sudo apt install syncthing
#printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing.pref
#wget https://raw.githubusercontent.com/syncthing/syncthing/refs/heads/main/etc/linux-systemd/system/syncthing%40.service
#sudo chown root: syncthing@.service
#sudo mv syncthing@.service /etc/systemd/system/
#sudo systemctl daemon-reload
#sudo systemctl enable --now syncthing@mjc
# then go to localhost:8384/

# Notes on Julia install
# OLD way but keeping incase juliaup development ends
# tar zxvf julia-X.X.X-linux-x86_64.tar.gz
# sudo cp -r julia-X.X.X /opt/
# sudo ln -s /opt/julia-X.X.X/bin/julia /usr/local/bin/julia

# How to revert a package back to automatically installed if the status
# switches to manually installed
# sudo apt-mark auto PACKAGE

# tree-sitter CLI for neovim
#cargo install --locked tree-sitter-cli
