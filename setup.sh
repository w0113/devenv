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
	runm_cmd_out="$($@ 2>&1)"
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
		runm "Removing old link '$1'" rm -f "$1"
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
# Install ruby neovim gem.
#
function install_gem_nvim() {
	if command -v gem &> /dev/null; then
		runm "Installing/updating ruby neovim module" gem install neovim
	fi
}


#
# Install node neovim module.
#
function install_npm_nvim() {
	if command -v npm &> /dev/null; then
		if npm ls neovim &> /dev/null; then
			runm "Updating node neovim module" npm update -g neovim
		else
			runm "Installing node neovim module" npm install -g neovim
		fi
	fi
}

#
# Check if the python pip module for neovim is installed.
#
# $1: pip command
#
function install_pip_nvim_worker() {
	local result=1
	if command -v $1 &> /dev/null; then
		if $1 list | grep -E '^neovim[[:space:]]'; then
			if $1 install --user --upgrade neovim; then
				local result=0
			fi
		else
			if $1 install --user neovim; then
				local result=0
			fi
		fi
	fi
	return $result
}


#
# Install python pip module for neovim.
#
function install_pip_nvim() {
	for c in pip pip3; do
		runm "Installing/updating $c neovim module" install_pip_nvim_worker "$c"
	done
}


#
# Install solargraph and create documentation
#
function install_solargraph_worker() {
	local result=0
	local cmds=(
		"gem install -N solargraph"
		"gem install -N yard"
		"yard gems"
		)

	for i in ${!cmds[*]}; do
		if ! ${cmds[i]}; then
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
		runm "Installing/updating solargraph" install_solargraph_worker
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

	runm "Installing vim-plug" wget -O "$install_file" "$install_url"
}


#
# Create all links
#
function install_vim_files() {
	mkdir -p "${HOME}/.config/nvim/"
	lnwb "${DIR}/vim/init.vim" "${HOME}/.config/nvim/init.vim"
	lnwb "${DIR}/vim/init.vim" "${HOME}/.vimrc"
	lnwb "${HOME}/.config/nvim/" "${HOME}/.vim"
	lnwb "${DIR}/config/coc-settings.json" "${HOME}/.config/nvim/coc-settings.json"
}


#
# Initialize nvim.
#
function init_nvim() {
	if command -v nvim &> /dev/null; then
		runm "Installing neovim plugins" nvim --headless +PlugInstall +qall
		runm "Building neovim coc plugin" \
			nvim --headless "+call coc#util#build()" +qall
	fi
}


#
# Install all files.
#
function install() {
	link_config_files
	install_vim_files
	install_vim_plug
	install_gem_nvim
	install_npm_nvim
	install_pip_nvim
	install_solargraph
	init_nvim
}


#
# Update files.
#
function update() {
	install_vim_plug
	install_gem_nvim
	install_npm_nvim
	install_pip_nvim
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

