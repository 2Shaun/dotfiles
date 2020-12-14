#!/bin/bash
FILES=~/dotfiles/*
configDir="$HOME/.config"

shopt -s dotglob

for target in $FILES
do
	targetBasename=$(basename -- $target)
	# can't expand `~` in quotes, use `$HOME`
	homeLinkName="$HOME/$targetBasename"

	# if the target is a swapfile
	if [[ "$target" == *".swp"* ]]; then
		continue
	fi

	# for when default config location is not home
	case $targetBasename in
		kitty)
			confLinkName="$configDir/kitty"

			if [[ -e "$confLinkName" ]]; then
				echo "removing $confLinkName"
				rm -r $confLinkName
			fi

			echo "linking $confLinkName to $target"
			ln -s $target $confLinkName
			continue
			;;
		User)
			confLinkName="$configDir/Code/User"
			
			if [[ -e "$confLinkName" ]]; then
				echo "removing $confLinkName"
				rm -r $confLinkName
			fi

			echo "linking $confLinkName to $target"
			ln -s $target $confLinkName
			continue
			;;

		*)
			;;
	esac


	if [[ -e "$homeLinkName" ]]; then
		echo "removing $homeLinkName"
		rm -r $homeLinkName
	fi

	
	echo "linking $homeLinkName to $target"
	ln -s $target $homeLinkName
done
