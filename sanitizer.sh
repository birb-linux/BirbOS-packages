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
[ -n "$(echo "$NAME" | grep "[[:space:]]")" ] && echo "Whitespace isn't allowed in package names"

# Prefix mistakes
grep -i "prefix=/usr" $PKG_NAME/seed.sh && echo "Misconfigured prefix path ^"
grep -i "bindir=/usr" $PKG_NAME/seed.sh && echo "Misconfigured bindir path ^"
grep -i "\-w dist" $PKG_NAME/seed.sh && echo "Misconfigured pip3 build command ^"
grep -i "\--find-links dist" $PKG_NAME/seed.sh && echo "Misconfigured pip3 install command ^"
grep -i "\--find-links=dist" $PKG_NAME/seed.sh && echo "Misconfigured pip3 install command ^"
grep "mv.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured mv command ^"
grep "rm.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured rm command ^"
grep "cp.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured cp command ^"
grep "ln.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured ln command ^"
grep "install.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured install command ^"
grep "sed.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured sed command ^"
grep "echo.* /[A-Za-z]" $PKG_NAME/seed.sh && echo "Possibly misconfigured echo command ^"


# Make sure the version variable is used properly
VERSION_COUNT="$(grep -F "$VERSION" $PKG_NAME/seed.sh | wc -l)" # This command should only return "1"
[ "$VERSION_COUNT" != "1" ] && echo "Found some possibly hardcoded version values in the build instructions"

# Args:
# $1 : function name ( ex. _func() )
# $2 : flag name ( ex. 32bit )
match_function_flag()
{
	if [ -n "$(grep "$1" $PKG_NAME/seed.sh)" ]
	then
		if [ -n "$(echo "$FLAGS" | grep -w "$2")" ]
		then
			# The flag was found
			echo "SUCCESS"
		else
			# The flag was missing
			echo "MISSING"
		fi
	fi
}

# Make sure that the test flag is set if the _test() function is specified
if [ "$(match_function_flag "_test()" "test")" == "MISSING" ]
then
	echo "Testing instructions have been specified, but the 'test' flag is missing"
fi

# Make sure that the 32bit flag is specified if there are 32bit functions
if [ "$(match_function_flag "_build32()" "32bit")" == "MISSING" ]
then
	echo "32bit installation instructions have been specified, but the '32bit' flag is missing"
fi

# Make sure that the test32 flag is specified if there is test32 function
# for 32bit testing
if [ "$(match_function_flag "_test32()" "test32")" == "MISSING" ]
then
	echo "32bit test instructions have been specified, but the 'test32' flag is missing"
fi

# Make sure that the python flag is specified if the package is
# installed with pip3
if [ "$(match_function_flag "pip3 install" "python")" == "MISSING" ]
then
	echo "The package is installed with pip3, but the 'python' flag is missing"
fi
