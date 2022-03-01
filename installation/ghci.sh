#config ghci
ConfigureGhci()
{
	if $(hash ghci 2>/dev/null); then
		if [[ -w ~/.ghc ]]; then
			if [[ -e ~/.ghc/ghci.conf ]]; then
				echo "Backing up ghci"
				mv ~/.ghc/ghci.conf ~/.ghc/.ghci.conf.backup
			fi
			cp tmux.conf ~/.tmux.conf
		else
			echo "Skipping ghci setup: ~/.ghc not writable"
		fi
	else
		echo "Skipping tmux setup: tmux not found"
	fi
}


