#!/bin/bash

# Helper script for figuring out what to package next
#
# Simply add needed packages to the ./package_wishlist file and
# this script will scan for packages that haven't been yet packaged
# and then print out a package that should be packaged
#
# When adding packages with dependencies, add the packages to the list
# in the dependency tree order from top to down. This script will return
# the last line in the wishlist file

WISHLIST_FILE="$(dirname $0)/package_wishlist"

# Check if the wishlist file exists
if [ ! -f "$WISHLIST_FILE" ]
then
	echo "Can't locate the wishlist file at $WISHLIST_FILE!"
	echo "Please create it and add packages that you want to package into it"
	exit 1
fi

# Prune out packages that have already been packaged
while read package
do
	# Use birb_pkg_search to figure out if the package exists
	birb_pkg_search $package &>/dev/null && sed -i "/^$package$/d" "$WISHLIST_FILE" && echo "Pruned $package"
done < "$WISHLIST_FILE"

# Check if the wishlist is empty
if [ ! -s "$WISHLIST_FILE" ]
then
	echo "The wishlist is empty! Go look for packages to package ;)"
	exit 0
fi

# Print out the last line in the file
echo "Package: $(tail -n1 "$WISHLIST_FILE")"
