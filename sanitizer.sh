#!/bin/bash

# This script can be used to make sure that a package has
# all of the required variables set.
#
# It also looks for common mistakes in the installation instructions
# to prevent breaking installations

PKG_NAME="$1"

[ ! -d $PKG_NAME ] && echo "Package [$PKG_NAME] doesn't exist..." && exit 1

# Source the seed file (if it even exists)
[ ! -f $PKG_NAME/seed.sh ] && echo "The seed.sh file seems to be missing entirely for this package" && exit 1
source $PKG_NAME/seed.sh

[ -z "$NAME" ] && echo "Package name is missing"
[ -z "$DESC" ] && echo "Description is missing"
[ -z "$VERSION" ] && echo "Version information is missing"
[ -z "$SOURCE" ] && echo "Package source url is missing"
[ -z "$CHECKSUM" ] && echo "Package checksum is missing"

# Prefix mistakes
grep -i "prefix=/usr" $PKG_NAME/seed.sh && echo "Misconfigured prefix path ^"
grep "mv.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured mv command ^"
grep "cp.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured cp command ^"
grep "ln.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured ln command ^"
grep "install.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured install command ^"

# Make sure the version variable is used properly
VERSION_COUNT="$(grep -F "$VERSION" $PKG_NAME/seed.sh | wc -l)" # This command should only return "1"
[ "$VERSION_COUNT" != "1" ] && echo "Found some possibly hardcoded version values in the build instructions"
