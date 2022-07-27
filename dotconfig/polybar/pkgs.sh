#!/bin/bash


get_package_info() {
	pkg_count=$(get_pkg_count)
	snap_count=$(get_snap_count)
	flatpak_count=$(get_flatpak_count)

	if [ "$pkg_count" -ne 0 ]; then
		echo -n "$pkg_count"
		if [ "$snap_count" -ne 0 ]; then
			echo -n " ($snap_count snaps"
			if [ "$flatpak_count" -ne 0 ]; then
				echo ", $flatpak_count flatpaks)"
			else
				echo ")"
			fi
		elif [ "$flatpak_count" -ne 0 ]; then
			echo " ($flatpak_count flatpaks)"
		else
			echo ""
		fi
	elif [ "$snap_count" -ne 0 ]; then
		echo -n "$snap_count snaps"

		if [ "$flatpak_count" -ne 0 ]; then
			echo ", $flatpak_count flatpaks"
		else
			echo ""
		fi
	elif [ "$flatpak_count" -ne 0 ]; then
		echo "$flatpak_count flatpaks"
	else
		echo "Unknown"
	fi
}

# Get count of packages installed
get_pkg_count() {
	package_managers=('xbps-install' 'apk' 'apt' 'pacman' 'nix' 'dnf' 'rpm' 'emerge')
	for package_manager in "${package_managers[@]}"; do
		if command -v "$package_manager" 2>/dev/null >&2; then
			case "$package_manager" in
			xbps-install) xbps-query -l | wc -l ;;
			apk) apk search | wc -l ;;
			apt) echo $(($(apt list --installed 2>/dev/null | wc -l) - 1)) ;;
			pacman) pacman -Q | wc -l ;;
			nix) nix-env -qa --installed '*' | wc -l ;;
			dnf) dnf list installed | wc -l ;;
			rpm) rpm -qa | wc -l ;;
			emerge) qlist -I | wc -l ;;
			esac

			# if a package manager is found return from the function
			return
		fi
	done
	echo 0
}

# Get count of snaps installed
get_snap_count() {
	if command -v snap 2>/dev/null >&2; then
		count=$(snap list | wc -l)

		# snap list shows a header line
		echo $((count - 1))

		return
	fi

	echo 0
}

# Get count of flatpaks installed
get_flatpak_count() {
	if command -v flatpak 2>/dev/null >&2; then
		flatpak list | wc -l
		return
	fi

	echo 0
}

get_package_info() {
	pkg_count=$(get_pkg_count)
	snap_count=$(get_snap_count)
	flatpak_count=$(get_flatpak_count)

	if [ "$pkg_count" -ne 0 ]; then
		echo -n "$pkg_count"
		if [ "$snap_count" -ne 0 ]; then
			echo -n " ($snap_count snaps"
			if [ "$flatpak_count" -ne 0 ]; then
				echo ", $flatpak_count flatpaks)"
			else
				echo ")"
			fi
		elif [ "$flatpak_count" -ne 0 ]; then
			echo " ($flatpak_count flatpaks)"
		else
			echo ""
		fi
	elif [ "$snap_count" -ne 0 ]; then
		echo -n "$snap_count snaps"

		if [ "$flatpak_count" -ne 0 ]; then
			echo ", $flatpak_count flatpaks"
		else
			echo ""
		fi
	elif [ "$flatpak_count" -ne 0 ]; then
		echo "$flatpak_count flatpaks"
	else
		echo "Unknown"
	fi
}

echo $(get_pkg_count)
