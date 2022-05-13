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
	mkdir -p "${HOME}/.config/nvim/"
	lnwb "${DIR}/nvim/init.lua" "${HOME}/.config/nvim/init.lua"
	lnwb "${DIR}/nvim/lua" "${HOME}/.config/nvim/lua"
}

# Install terminal font.
function install_font() {
  runm "Installing font" install_font_download
}

# Download and install font.
function install_font_download() {
  local font_dir="${HOME}/.local/share/fonts"
  local font_name_glob="*ubuntu mono*nerd*"
  local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip"

  if [ $(find "$font_dir" -iname "$font_name_glob" | wc -l) -eq 0 ]; then
    local tdir="$(mktemp -d)"
    local font_file="${tdir}/font.zip"

    wget -q -O "$font_file" "$font_url"
    unzip "$font_file" -d "$tdir"
    mv "${tdir}/*.ttf" "$font_dir"
    fc-cache -f
  fi
}

# Install nodenv.
function install_nodenv() {
  runm "Installing nodenv" install_nodenv_worker
}

# Download and configure nodenv.
function install_nodenv_worker() {
  local nodenv_dir="${HOME}/.nodenv"

  if [ ! -e "$nodenv_dir" ]; then
    git clone "https://github.com/nodenv/nodenv.git" "$nodenv_dir"
    $(cd ~/.nodenv && src/configure && make -C src)

    echo '' >> ~/.bashrc
    echo '# nodenv' >> ~/.bashrc
    echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(nodenv init -)"' >> ~/.bashrc

    mkdir -p "${nodenv_dir}/plugins"
    git clone "https://github.com/nodenv/node-build.git" "${nodenv_dir}/plugins/node-build"
  fi
}

# Install rbenv.
function install_rbenv() {
  runm "Installing rbenv" install_rbenv_worker
}

# Download and configure rbenv.
function install_rbenv_worker() {
  local rbenv_dir="${HOME}/.rbenv"

  if [ ! -e "$rbenv_dir" ]; then
    git clone "https://github.com/rbenv/rbenv.git" "$rbenv_dir"
    $(cd ~/.rbenv && src/configure && make -C src)

    echo '' >> ~/.bashrc
    echo '# rbenv' >> ~/.bashrc
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

    mkdir -p "${rbenv_dir}/plugins"
    git clone "https://github.com/rbenv/ruby-build.git" "${rbenv_dir}/plugins/ruby-build"
  fi
}

# Install necessary system dependencies on Fedora.
function install_system_files() {
  echo "Please enter your password to install system dependencies"
  if [[ ! $(sudo echo 0) ]]; then exit; fi

  runm "Installing basic tools" sudo dnf -y install \
    fd-find \
    git \
    ripgrep \
    tmux

  runm "Installing rbenv dependencies" sudo dnf -y install \
    bzip2 \
    gcc \
    gdbm-devel \
    libffi-devel \
    libyaml-devel \
    make \
    ncurses-devel \
    openssl-devel \
    readline-devel \
    zlib-devel

  runm "Installing C dev tools" install_system_files_dev_tools
}

# Install the C Development Tools and Libraries group in Fedora.
function install_system_files_dev_tools() {
  sudo dnf -y group install "C Development Tools and Libraries"
}

#
# Initialize nvim.
#
function install_nvim_plugins() {
	if command -v nvim &> /dev/null; then
		runm "Installing neovim plugins" nvim --headless +PackerSync +qall
  else
    echo "Command 'nvim' not found in PATH. Skip installing plugins!"
	fi
}

#
# Install all files.
#
function install() {
  if [ $option_system -eq 1 ]; then install_system_files; fi
  if [ $option_font -eq 1 ]; then install_font; fi
  if [ $option_rbenv -eq 1 ]; then install_rbenv; fi
  if [ $option_nodenv -eq 1 ]; then install_nodenv; fi
  if [ $option_config -eq 1 ]; then link_config_files; link_nvim_files; fi
  if [ $option_plugins -eq 1 ]; then install_nvim_plugins; fi
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
  echo "    -a  Install all."
  echo ""
  echo "    -c  Install Neovim configuration."
  echo "    -p  Install Neovim plugins."
  echo ""
  echo "    -f  Install terminal font."
  echo "    -s  Install Fedora system dependencies."
  echo ""
  echo "    -n  Install nodenv."
  echo "    -r  Install rbenv."
  echo ""
  echo "    -h  Print this help message."
	echo ""
}

option_config=0
option_plugins=0
option_font=0
option_system=0
option_nodenv=0
option_rbenv=0

# Print usage when no argument was given.
if [ $# -eq 0 ]; then
  usage
  exit 1
fi

# Parse all user arguments.
while getopts "acpfsnrh" opt; do
	case $opt in
    a)
      option_config=1
      option_plugins=1
      option_font=1
      option_system=1
      option_nodenv=1
      option_rbenv=1
      ;;
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
    n)
      option_nodenv=1
      ;;
    p)
      option_plugins=1
      ;;
    r)
      option_rbenv=1
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
