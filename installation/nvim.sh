#config nvim
ConfigureNvim()
{
	if $(hash nvim 2>/dev/null); then
		if [[ -w ~/.config/nvim/ ]]; then
			if [[ -e ~/.config/nvim/init.lua ]]; then
				echo "Backing up existing init.lua"
				mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.backup
			elif [[ -e ~/.config/nvim/init.vim ]]; then
				echo "Backing up existing init.vim"
				mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
			fi
			cp config/nvim/init.lua ~/.config/nvim/
		else
			echo "Skipping nvim setup: ~/.config/nvim not writable"
		fi
	else
		echo "Skipping nvim setup: nvim not found"
	fi
}


