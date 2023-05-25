#!/bin/sh

# Create a template package from a package name
PKG_NAME="$1"

# Don't accept empty package names
[ -z "$PKG_NAME" ] && echo "Can't create a package with empty name" && exit 1

# Don't allow packages with whitespace in the name
[ -n "$(echo "$PKG_NAME" | grep "[[:space:]]")" ] && echo "Whitespace isn't allowed in package names" && exit 1

[ -d $PKG_NAME ] && echo "A package with name [$PKG_NAME] has already been created!" && exit 1

mkdir -pv $PKG_NAME

# Create different package templates depending on the second argument
case $2 in
	python)
		cat > $PKG_NAME/seed.sh << "EOF"
NAME="|PACKAGE_NAME|"
DESC=""
VERSION=""
SOURCE=""
CHECKSUM=""
DEPS=""
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}
EOF
		;;

	*)
		cat > $PKG_NAME/seed.sh << "EOF"
NAME="|PACKAGE_NAME|"
DESC=""
VERSION=""
SOURCE=""
CHECKSUM=""
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# make -j${BUILD_JOBS}
}

_install()
{
	# make DESTDIR=$FAKEROOT/$NAME install
}

# If the package has any tests, run them here
# To enable this function, specify the 'test' flag
#
# Also, birb needs to be run with special arguments to run tests
# when installing packages
_test()
{

}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{

}

# This function gets called if the 'test32' flag has been specified
_test32()
{

}

_install32()
{

}
EOF
		;;
esac

# Update the package name
sed -i "s/|PACKAGE_NAME|/$PKG_NAME/g" $PKG_NAME/seed.sh

# Open the package seed.sh file in vim at the end
# to make life a bit easier
vim $PKG_NAME/seed.sh

# Run the package sanitizer to find any mistakes
./sanitizer.sh $PKG_NAME
