#config vim
ConfigureVim()
{
	if [[ -w ~/.vim/ ]]; then
		if [[ -e ~/.vim/vimrc ]]; then
			echo "Backing up existing vimrc"
			mv ~/.vim/vimrc ~/.vim/vimrc.backup
		fi
		if [[ -e ~/.vim/coc-settings.json ]]; then
			echo "Backing up existing coc-settings.json"
			mv ~/.vim/coc-settings.json ~/.vim/coc-settings.json.backup
		fi
		cp vim/vimrc ~/.vim/
		cp vim/coc-settings.json ~/.vim/coc-settings.json
	else
		echo "Skipping vim setup: ~/.vim not writable"
	fi
}


