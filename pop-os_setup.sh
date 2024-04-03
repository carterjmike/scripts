#!/bin/bash
#set -e

# -------------------------------------------------------
# A script to automate personal package installation after a fresh
# Pop!_OS installation
#
# Written by Michael Carter
#
# Some ideas and code adapted from other sources, mainly the ArchLabs
# installer (https://www.archlabslinux.com) and the Arch Wiki
# -------------------------------------------------------

# Setup to use most up-to-date version of R
echo
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
echo
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Check if there are any packages to upgrade
echo
echo "Checking for and installing any updates..."
sudo apt update && sudo apt upgrade

# Packages to install {
typeset -a REPO_PKGS=(
"adwaita-qt"
#"bash-completion" # already installed in Pop!
"biber"
"cmake"
"dconf-editor"
"ffmpeg"
"fzf"
"gettext"
"gir1.2-gtop-2.0"
"gnome-sushi"
"gnome-tweaks"
"gpick"
"hplip"
"imagemagick"
"jags"
"libcairo2-dev"
"libcurl4-openssl-dev"
"libfftw3-dev"
"libfontconfig1-dev"
"libfribidi-dev"
"libgconf-2-4"
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
"libsecret-1-dev"
"libssl-dev"
"libudunits2-dev"
"libxt-dev"
#"lm-sensors" # already installed in Pop!
"ninja-build"
"nodejs"
"npm"
"nvme-cli"
"pdftk"
#"python3-nautilus"
"qt5ct"
"r-base"
"ripgrep"
"sane"
"smartmontools"
"stow"
"synaptic"
"system76-keyboard-configurator"
"texlive-full"
"tree"
"ttf-mscorefonts-installer"
"webp-pixbuf-loader"
#"zsh"
) # }

# Flatpaks to install {
typeset -a FLATPAKS=(
"com.github.tchx84.Flatseal"
"com.google.Chrome"
"com.mattjakeman.ExtensionManager"
"com.obsproject.Studio"
"com.slack.Slack"
"com.spotify.Client"
"io.github.alainm23.planify"
"io.mpv.Mpv"
#"net.codeindustry.MasterPDFEditor"
"org.audacityteam.Audacity"
"org.blender.Blender"
#"org.flameshot.Flameshot"
#"org.mozilla.firefox"
"org.gnome.DejaDup"
"org.gnome.meld"
"org.gnome.World.PikaBackup"
"org.inkscape.Inkscape"
"org.jamovi.jamovi"
#"org.libreoffice.LibreOffice"
"org.localsend.localsend_app"
"org.onlyoffice.desktopeditors"
"org.zotero.Zotero"
"org.zulip.Zulip"
) # }

# Install rep packages and flatpaks
echo
echo "Installing packages from repository"
sudo apt install ${REPO_PKGS[*]} -y
echo
echo "Installing flatpaks from flathub"
flatpak install flathub ${FLATPAKS[*]} -y
echo

# Refresh font cache to jamovi
echo "Refresh font cache for jamovi"
flatpak run --command=fc-cache org.jamovi.jamovi -f -v
echo

# Setup preferred keyboard shortcuts for workspaces
echo "Change keyboard shortcuts for workspaces"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['<Super>7']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['<Super>8']"
dconf write \
/org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "['<Super>9']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-1  "['<Super><Shift>1']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-2  "['<Super><Shift>2']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-3  "['<Super><Shift>3']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-4  "['<Super><Shift>4']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-5  "['<Super><Shift>5']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-6  "['<Super><Shift>6']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-7  "['<Super><Shift>7']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-8  "['<Super><Shift>8']"
dconf write \
/org/gnome/desktop/wm/keybindings/move-to-workspace-9  "['<Super><Shift>9']"

# Change nautilus preference to show option to create links
echo "Enable option to create links in nautilus"
dconf write \
/org/gnome/nautilus/preferences/show-create-link true

# Change touchpad to be natural scrolling
echo "Enable natural scrolling with touchpad"
dconf write \
/org/gnome/desktop/peripherals/touchpad/natural-scroll true

# Make personal directories
#echo "Create personal directories"
mkdir -p $HOME/Documents/{1_projects,2_areas,3_resources,4_archives}
mkdir -p $HOME/.local/{bin,build}
mkdir -p $HOME/.local/share/{fonts,icons,pop-launcher/scripts}
mkdir -p $HOME/.themes

# Create .gitignore
cat > $HOME/.gitignore <<EOF
.Rproj.user
.Rhistory
.Rdata
.httr-oauth
.DS_Store
.quarto

EOF

# Disable these applications from search
echo "NoDisplay=true" | sudo tee -a \
/usr/share/applications/vim.desktop \
/usr/share/applications/debian-uxterm.desktop \
/usr/share/applications/debian-xterm.desktop \
/usr/share/applications/prerex.desktop \
/usr/share/applications/vprerex.desktop \
/usr/share/applications/texdoctk.desktop \
/usr/share/applications/display-im6.q16.desktop > /dev/null

# Make libsecret for git credentials
cd /usr/share/doc/git/contrib/credential/libsecret && sudo make

echo
echo "Installation completed succesfully."
sleep 2
echo "Exiting..."
sleep 1
exit 0


# SOME NOTES...
#
# Change shell to zsh
#echo
#echo "Changing shell to zsh"
#chsh -s $(which zsh)

# Fix login to be on primary monitor
#sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/
#sudo chown gdm:gdm /var/lib/gdm3/.config/monitors.xml

# Syncthing after downloading from website
# check website for any changes: https://apt.syncthing.net/
#sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
#echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
#sudo apt update
#sudo apt install syncthing
#printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing.pref
#wget https://raw.githubusercontent.com/syncthing/syncthing/main/etc/linux-systemd/system/syncthing%40.service
#sudo chown root: syncthing@.service
#sudo mv syncthing@.service /etc/systemd/system/
#sudo systemctl daemon-reload
#sudo systemctl enable syncthing@mjc
#sudo systemctl start syncthing@mjc
# then go to localhost:8384/

# Notes on Julia install
# OLD way but keeping incase juliaup development ends
# tar zxvf julia-X.X.X-linux-x86_64.tar.gz
# sudo cp -r julia-X.X.X /opt/
# sudo ln -s /opt/julia-X.X.X/bin/julia /usr/local/bin/julia

# wget https://raw.githubusercontent.com/qtile/qtile/master/resources/qtile.desktop
# Move qtile desktop file to /usr/share/xsessions/

# How to revert a package back to automatically installed if the status
# switches to manually installed
# sudo apt-mark auto PACKAGE


# OLD STUFF...
#
# Packages to remove {
#typeset -a RM_PKGS=(
#"firefox"
#"gedit"
#"totem"
#) # }

# Remove some packages
#echo
#echo "Removing some packages"
#sudo apt remove ${RM_PKGS[*]} -y
#echo
#echo "Clean up packages no longer needed"
#sudo apt autoremove -y

# Create various files in home folder
#echo "Create some files..."
# Create shutdown script for pop-launcher but make poweroff
# rather than power off a keyword
#cat > ~/.local/share/pop-launcher/scripts/poweroff.sh <<EOF
#!/bin/sh
#
# name: Power off
# icon: system-shutdown
# description: Power off the system
# keywords: poweroff shutdown

#gnome-session-quit --power-off

#EOF

#chmod +x ~/.local/share/pop-launcher/scripts/poweroff.sh

