#!/bin/bash

# Get the directory this script is located in.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# All config files which should be linked into $HOME.
CONFIG_FILES=(
	"gitconfig"
	"inputrc"
	"tmux.conf"
	)


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
		echo -n "Removing old link '$1'... "
		if rm -f "$1" &> /dev/null; then
			echo "done"
		else
			echo "failed"
		fi
	# Add extension ".old" to files/folders.
	elif [ -e "$1" ]; then
		echo -n "Moving old data '$1' to '${1}.old'... "
		if mv -f "$1" "$1.old" &> /dev/null; then
			echo "done"
		else
			echo "failed"
		fi
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
	echo -n "Creating link '$2' to '$1'... "
	if ln -s "$1" "$2" &> /dev/null; then
		echo "done"
	else
		echo "failed"
	fi
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
# Install solargraph and create documentation
#
function install_solargraph_worker() {
	local result=0
	local cmds=(
		"gem install solargraph"
		"gem install yard"
		"yard gems"
		)

	for i in ${!cmds[*]}; do
		if ! ${cmds[i]} &> /dev/null; then
			result=1
			break
		fi
	done

	return $result
}


#
# Install solargraph
#
function install_solargraph() {
	if command -v gem &> /dev/null; then
		echo -n "Installing/updating solargraph... "
		if install_solargraph_worker; then
			echo "done"
		else
			echo "failed"
		fi
	fi
}


#
# Install vim-plug plugin manager.
#
function install_vim_plug() {
	local install_path="${HOME}/.config/nvim/autoload/"
	local install_file="${install_path}plug.vim"
	local install_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	mkdir -p "$install_path"
	backup "$install_file"

	echo -n "Installing vim-plug... "
	if wget -O "$install_file" "$install_url" &> /dev/null; then
		echo "done"
	else
		echo "failed"
	fi
}


#
# Create all links
#
function install_vim_files() {
	mkdir -p "${HOME}/.config/nvim/"
	lnwb "${DIR}/vim/init.vim" "${HOME}/.config/nvim/init.vim"
	lnwb "${DIR}/vim/init.vim" "${HOME}/.vimrc"
	lnwb "${HOME}/.config/nvim/" "${HOME}/.vim"
}


#
# Install all files.
#
function install() {
	link_config_files
	install_vim_files
	install_vim_plug
	install_solargraph
}


#
# Update files.
#
function update() {
	install_solargraph
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
	echo "    -h  Print this help message."
	echo "    -i  Backup the current configuration and create a new one."
	echo "    -u  Update the current configuration."
	echo ""
	echo "  Don't forget to install those packages:"
	echo "    exuberant-ctags silversearcher-ag"
	echo ""
	echo "  Set your terminal to use this font (size 11):"
	echo "    Source Code Pro for Powerline Regular"
	echo ""
}


# Store the user set options.
opt_install=0
opt_update=0

# Parse all user arguments.
while getopts "hiu" opt; do
	case $opt in
		h)
			usage
			exit 0
			;;
		i)
			opt_install=1
			;;
		u)
			opt_update=1
			;;
		*)
			usage
			exit 1
			;;
	esac
done

# Execute...
if [ $opt_install -eq 1 ]; then
	install
elif [ $opt_update -eq 1 ]; then
	update
else
	usage
	exit 1
fi

