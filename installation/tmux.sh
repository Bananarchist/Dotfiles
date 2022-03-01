#config tmux
ConfigureTmux()
{
	if $(hash tmux 2>/dev/null); then
		if [[ -e ~/.tmux.conf ]]; then
			echo "Backing up tmux"
			mv ~/.tmux.conf ~/.tmux.conf.backup
		fi
		cp tmux.conf ~/.tmux.conf
	else
		echo "Skipping tmux setup: tmux not found"
	fi
}

