#!/bin/bash

# Get the directory this script is located in.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# All config files which should be linked into $HOME.
CONFIG_FILES=(
	"gitconfig"
	"tmux.conf"
	"vimrc"
	)

# The vim configuration folder.
VIM_FOLDER="${HOME}/.vim"
# The vim plugin folder.
VIM_PLUGIN_FOLDER="${VIM_FOLDER}/bundle"
# Put each plugin git repository here. All this plugins will be installed,
# when updating/installing.
VIM_PLUGIN_REPOS=(
	"https://github.com/airblade/vim-gitgutter.git"
	"https://github.com/benmills/vimux.git"
	"https://github.com/christoomey/vim-tmux-navigator.git"
	"https://github.com/ctrlpvim/ctrlp.vim.git"
	"https://github.com/gregsexton/gitv.git"
	"https://github.com/jiangmiao/auto-pairs.git"
	"https://github.com/kana/vim-textobj-entire.git"
	"https://github.com/kana/vim-textobj-line.git"
	"https://github.com/kana/vim-textobj-user.git"
	"https://github.com/Lokaltog/vim-easymotion"
	"https://github.com/majutsushi/tagbar"
	"https://github.com/mbbill/undotree.git"
	"https://github.com/powerline/fonts.git"
	"https://github.com/scrooloose/nerdtree.git"
	"https://github.com/scrooloose/syntastic.git"
	"https://github.com/terryma/vim-expand-region.git"
	"https://github.com/terryma/vim-multiple-cursors"
	"https://github.com/tpope/vim-bundler.git"
	"https://github.com/tpope/vim-endwise"
	"https://github.com/tpope/vim-fugitive"
	"https://github.com/tpope/vim-pathogen.git"
	"https://github.com/tpope/vim-rails"
	"https://github.com/tpope/vim-surround.git"
	"https://github.com/Valloric/YouCompleteMe.git"
	"https://github.com/vim-airline/vim-airline.git"
	"https://github.com/vim-airline/vim-airline-themes.git"
	"https://github.com/vim-ruby/vim-ruby"
	"https://github.com/w0113/vim-textobj-rubyblock.git"
	"https://github.com/xolox/vim-easytags"
	"https://github.com/xolox/vim-misc.git"
	)

#
# Configure/compile installed plugins.
#
function custom_plugin_configuration() {
	echo -n "Configuring fonts... "
	if ${VIM_PLUGIN_FOLDER}/fonts/install.sh &> /dev/null; then
		echo "done"
	else
		echo "failed"
	fi

	echo -n "Compiling YouCompleteMe... "
	if ${VIM_PLUGIN_FOLDER}/YouCompleteMe/install.py &> /dev/null; then
		echo "done"
	else
		echo "failed"
	fi
}

#
# Install all plugins from VIM_PLUGIN_REPOS, which are not already installed.
#
function install_new_vim_plugins() {
	if [ -d "$VIM_PLUGIN_FOLDER" ]; then
		local wd="$(pwd)"
		cd "$VIM_PLUGIN_FOLDER"
		for p in $(not_installed_vim_plugins); do
			echo -n "Installing new plugin '$p'... "
			if git clone "$p" &> /dev/null; then
				echo "done"
			else
				echo "failed"
			fi
		done
		cd "$wd"
	fi
}

#
# Echo all installed vim plugin repositories.
#
function installed_vim_plugins() {
	if [ -d "$VIM_PLUGIN_FOLDER" ]; then
		local wd="$(pwd)"
		for d in $(ls -1 "${VIM_PLUGIN_FOLDER}"); do cd "${VIM_PLUGIN_FOLDER}/$d"; git remote -v; done | sed -e 's/\s\+/ /g' | cut -d" " -f2 | sort -u 
		cd "$wd"
	fi
}

#
# Link all config files listed in CONFIG_FILES to $HOME.
#
function link_config_files() {
	for c in ${CONFIG_FILES[@]}; do
		target="${DIR}/${c}"
		link_name="${HOME}/.${c}"

		if [ -h "$link_name" ]; then
			echo -n "Removing old link '$link_name'... "
			if rm -f "$link_name" &> /dev/null; then
				echo "done"
			else
				echo "failed"
			fi
		elif [ -e "$link_name" ]; then
			echo -n "Moving old file '$link_name' to '${link_name}.old'... "
			if mv -f "$link_name" "$link_name.old" &> /dev/null; then
				echo "done"
			else
				echo "failed"
			fi
		fi

		echo -n "Creating link '$link_name' to '$target'... "
		if ln -s "$target" "$link_name" &> /dev/null; then
			echo "done"
		else
			echo "failed"
		fi
	done
}

#
# Echo all plugins from VIM_PLUGIN_REPOS which are not already installed.
#
function not_installed_vim_plugins() {
	ip="$(installed_vim_plugins)"
	for p in ${VIM_PLUGIN_REPOS[@]}; do
		if [[ ! ("$ip" =~ "$p") ]]; then
			echo "$p"
		fi
	done
}

#
# Git pull all plugins and their submodules.
#
function update_vim_plugins() {
	if [ -d "$VIM_PLUGIN_FOLDER" ]; then
		local wd="$(pwd)"
		for p in $(ls -1 "${VIM_PLUGIN_FOLDER}"); do
			cd "${VIM_PLUGIN_FOLDER}/$p"

			echo -n "Updating plugin '$p'... "
			if git pull &> /dev/null && git submodule update --init --recursive &> /dev/null; then
				echo "done"
			else
				echo "failed"
			fi
		done
		cd "$wd"
	fi
}

#
# Make a fresh install.
# Backups all old folders and configuration files and installs them new.
#
function install() {
	if [ -d "$VIM_FOLDER" ]; then
		local old="${VIM_FOLDER}.old"

		if [ -d "$old" ]; then
			echo -n "Removing old backup folder '$old'... "
			if rm -rf "$old" &> /dev/null; then
				echo "done"
			else
				echo "failed"
			fi
		fi

		echo -n "Moving current vim folder '$VIM_FOLDER' to '$old'... "
		if mv -f "$VIM_FOLDER" "$old" &> /dev/null; then
			echo "done"
		else
			echo "failed"
		fi
	fi

	mkdir -p "$VIM_PLUGIN_FOLDER"

	install_new_vim_plugins
	update_vim_plugins
	custom_plugin_configuration
	link_config_files
}

#
# Update plugins/configuration.
#
function update() {
	install_new_vim_plugins
	update_vim_plugins
	custom_plugin_configuration
}

#
# Print usage information.
#
function usage() {
	echo ""
	echo "  Install my development environment (vim + tmux)."
	echo ""
	echo "  Usage: $0 [OPTIONS]"
	echo ""
	echo "  Options:"
	echo "    -h  Print this help message."
	echo "    -i  Backup the current configuration and create a new one."
	echo "    -n  Only install new plugins."
	echo "    -u  Update the current configuration."
	echo ""
	echo "  Don't forget to install those packages:"
	echo "    build-essential cmake python-dev python3-dev exuberant-ctags"
	echo ""
	echo "  Set your terminal to use this font (size 12):"
	echo "    Liberation Mono for Powerline Regular"
	echo ""
}

# Store the user set options.
opt_install=0
opt_new=0
opt_update=0

# Parse all user arguments.
while getopts "hinu" opt; do
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
		n)
			opt_new=1
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
elif [ $opt_new -eq 1 ]; then
	install_new_vim_plugins
else
	usage
	exit 1
fi

