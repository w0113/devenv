#!/bin/bash

# Create temp file.
file="$(mktemp)"
chmod 0600 "$file"

# Start vim.
cmd="tmux -2 new vim $file"
gnome-terminal --hide-menubar --window --maximize \
	-e "env TERM='xterm-256color' $cmd"

# Wait for vim to finish.
for i in $(seq 1 3); do
	if [ $(pgrep -fc "$cmd") -gt 0 ]; then
		tail -f --pid=$(pgrep -f "$cmd" | head -n1) /dev/null
		break
	fi
	sleep 1
done

# Copy content of file into clipboard.
xclip -selection c -i "$file"
rm "$file"

