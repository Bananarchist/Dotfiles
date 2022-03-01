#config zsh
ConfigureZsh()
{
	if [[ -e ~/.zshrc ]]; then
		echo "Found existing zshrc"
		if [[ -w ~/.zshrc ]]; then
			mv ~/.zshrc ~/.zshrc.orig
			cp zshrc ~/.zshrc
			echo "source ~/.zshrc.orig" >> ~/.zshrc
		else 
			echo "Skipping zshrc setup: ~/.zshrc not writable"
		fi
	fi
}


