#!/bin/bash

# Get the directory this script is located in.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# All config files which should be linked into $HOME.
CONFIG_FILES=(
	"gitconfig"
	"tmux.conf"
)

#
# Run a command and print a message line.
# Runs the given command and prints a status line to notify the user whether the
# command failed or not.
#
# $1: The message which should be printed.
# $2...: The command to run.
#
function runm() {
	# Print the run message.
	echo -n "${1}... "
	shift
	# Run the command. We can't use a local variable for the output here,
	# because the local variable declaration resets the last return code ($?).
	runm_cmd_out="$($* 2>&1)"
	local cmd_rc=$?

	# Print the status.
	if [ $cmd_rc -eq 0 ]; then
		echo -e "\e[1;32mdone\e[0m"
	else
		echo -e "\e[1;31mfailed\e[0m"
		echo "- ERROR --------------------------------"
		echo "$runm_cmd_out"
		echo "----------------------------------------"
	fi
	return $cmd_rc
}

#
# Backup a given path.
# This methods adds the extension ".old" to the file name, or deletes it, if the
# given path is a link.
#
# $1: A path to the file which should be backed up.
#
function backup() {
	# Remove links.
	if [ -h "$1" ]; then
		rm -f "$1"
	# Add extension ".old" to files/folders.
	elif [ -e "$1" ]; then
		runm "Moving old data '$1' to '${1}.old'" mv -f "$1" "$1.old"
	fi
}

#
# Create link, after creating backups of target path file/folder.
#
# $1: Target path
# $2: Link path
#
function lnwb() {
	# Create backup of link path.
	backup "$2"
	# Create link.
	runm "Creating link '$2' to '$1'" ln -s "$1" "$2"
}

#
# Link all config files listed in CONFIG_FILES to $HOME.
#
function link_config_files() {
	for c in ${CONFIG_FILES[@]}; do
		target="${DIR}/config/${c}"
		link_name="${HOME}/.${c}"

		lnwb "$target" "$link_name"
	done
}

#
# Create all links needed for nvim configuration.
#
function link_nvim_files() {
	lnwb "${DIR}/nvim" "${HOME}/.config/nvim"
}

#
# Install terminal font.
#
function install_font() {
	runm "Installing font" install_font_download
}

#
# Download and install font.
#
function install_font_download() {
	local font_dir="${HOME}/.local/share/fonts"
	local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip"
	local tdir="$(mktemp -d)"
	local font_file="${tdir}/font.zip"

	wget -q -O "$font_file" "$font_url" &&
		unzip "$font_file" -d "$tdir" &&
		mkdir -p "$font_dir" &&
		mv -f "${tdir}"/*.ttf "$font_dir" &&
		rm -r "$tdir" &&
		fc-cache -f
}

#
# Install necessary system dependencies.
#
function install_system_dependencies() {
	echo "Please enter your password to install system dependencies"
	if [[ ! $(sudo echo 0) ]]; then exit; fi

	if command -v dnf &>/dev/null; then
		runm "Installing system dependencies with dnf" install_system_dependencies_dnf
	elif command -v apt &>/dev/null; then
		runm "Installing system dependencies with apt" install_system_dependencies_apt
	else
		echo -e "\e[1;31mERROR: No supported package manager was found!\e[0m"
	fi
}

#
# Install system dependencies using the apt package manager.
#
function install_system_dependencies_apt() {
	sudo apt-get -y install alacritty build-essential fd-find git ripgrep tmux
}

#
# Install system dependencies using the dnf package manager.
#
function install_system_dependencies_dnf() {
	sudo dnf -y install alacritty fd-find git ripgrep tmux
	sudo dnf -y group install "C Development Tools and Libraries"
}

#
# Run installation.
#
function install() {
	if [ $option_system -eq 1 ]; then install_system_files; fi
	if [ $option_font -eq 1 ]; then install_font; fi
	if [ $option_config -eq 1 ]; then
		link_config_files
		link_nvim_files
	fi
}

#
# Print usage information.
#
function usage() {
	echo ""
	echo "  Install my development environment."
	echo ""
	echo "  Usage: $0 [OPTIONS]"
	echo ""
	echo "  Options:"
	echo "    -c  Install Neovim configuration."
	echo "    -f  Install terminal font."
	echo "    -s  Install system dependencies."
	echo "    -h  Print this help message."
	echo ""
}

option_config=0
option_font=0
option_system=0

# Print usage when no argument was given.
if [ $# -eq 0 ]; then
	usage
	exit 1
fi

# Parse all user arguments.
while getopts "acpfsnrh" opt; do
	case $opt in
	c)
		option_config=1
		;;
	f)
		option_font=1
		;;
	h)
		usage
		exit 0
		;;
	s)
		option_system=1
		;;
	*)
		usage
		exit 1
		;;
	esac
done

# Execute...
install
