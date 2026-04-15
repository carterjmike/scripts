#!/bin/bash
set -euo pipefail

# -------------------------------------------------------
# A script to automate the installation of flatpaks that is
# distro agnostic
#
# Written by Michael Carter
#
# Some ideas and code adapted from other sources, mainly the ArchLabs
# installer (https://www.archlabslinux.com) and the Arch Wiki
# -------------------------------------------------------

# Flatpaks to install {
declare -a FLATPAKS=(
"com.github.tchx84.Flatseal"
#"com.obsproject.Studio"
"com.slack.Slack"
"com.spotify.Client"
#"com.super_productivity.SuperProductivity"
"dev.edfloreshz.CosmicTweaks"
"com.github.xournalpp.xournalpp"
#"io.github.wiiznokes.fan-control"
#"org.blender.Blender"
"org.gnome.World.PikaBackup"
#"org.jamovi.jamovi"
#"org.jaspstats.JASP"
#"org.localsend.localsend_app"
"org.onlyoffice.desktopeditors"
"org.zotero.Zotero"
"org.zulip.Zulip"
"us.zoom.Zoom"
) # }


echo "Installing flatpaks from flathub"
flatpak install flathub ${FLATPAKS[@]} -y
echo

# Refresh font cache to jamovi
#echo "Refresh font cache for jamovi"
#flatpak run --command=fc-cache org.jamovi.jamovi -f -v
#echo


echo
echo "Installation completed succesfully."
sleep 2
echo "Exiting..."
sleep 1
exit 0
