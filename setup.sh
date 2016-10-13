#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_FILES=(
	"tmux.conf"
	"vimrc"
	)

VIM_FOLDER="${HOME}/.vim"
VIM_PLUGIN_FOLDER="${VIM_FOLDER}/bundle"
VIM_PLUGIN_REPOS=(
	"https://github.com/benmills/vimux.git"
	"https://github.com/bling/vim-airline"
	"https://github.com/ctrlpvim/ctrlp.vim.git"
	"https://github.com/Lokaltog/vim-easymotion"
	"https://github.com/majutsushi/tagbar"
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
	"https://github.com/Valloric/YouCompleteMe.git"
	"https://github.com/vim-ruby/vim-ruby"
	"https://github.com/xolox/vim-easytags"
	"https://github.com/xolox/vim-misc.git"
	)

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

function installed_vim_plugins() {
	if [ -d "$VIM_PLUGIN_FOLDER" ]; then
		local wd="$(pwd)"
		for d in $(ls -1 "${VIM_PLUGIN_FOLDER}"); do cd "${VIM_PLUGIN_FOLDER}/$d"; git remote -v; done | sed -e 's/\s\+/ /g' | cut -d" " -f2 | sort -u 
		cd "$wd"
	fi
}

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

function not_installed_vim_plugins() {
	ip="$(installed_vim_plugins)"
	for p in ${VIM_PLUGIN_REPOS[@]}; do
		if [[ ! ("$ip" =~ "$p") ]]; then
			echo "$p"
		fi
	done
}

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

function update() {
	install_new_vim_plugins
	update_vim_plugins
	custom_plugin_configuration
}

install
