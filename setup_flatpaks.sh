#!/bin/bash
#set -e

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
typeset -a FLATPAKS=(
"com.github.tchx84.Flatseal"
"com.obsproject.Studio"
"com.slack.Slack"
"com.spotify.Client"
"com.super_productivity.SuperProductivity"
#"dev.edfloreshz.Tasks"
"dev.edfloreshz.CosmicTweaks"
#"io.github.elevenhsoft.WebApps"
#"io.github.JakubMelka.Pdf4qt"
#"io.github.wiiznokes.fan-control"
#"org.gnome.DejaDup"
"org.gnome.World.PikaBackup"
#"org.jamovi.jamovi"
#"org.jaspstats.JASP"
"org.localsend.localsend_app"
"org.onlyoffice.desktopeditors"
"org.zotero.Zotero"
"org.zulip.Zulip"
) # }


echo "Installing flatpaks from flathub"
flatpak install flathub ${FLATPAKS[*]} -y
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
