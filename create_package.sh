#!/bin/sh

# Create a template package from a package name
PKG_NAME="$1"

[ -d $PKG_NAME ] && echo "A package with name [$PKG_NAME] has already been created!" && exit 1

mkdir -pv $PKG_NAME

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
	# Build the package here
}

_install()
{
	# make prefix=$FAKEROOT/$NAME/usr install
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{

}

_install32()
{

}
EOF

# Update the package name
sed -i "s/|PACKAGE_NAME|/$PKG_NAME/g" $PKG_NAME/seed.sh

# Open the package seed.sh file in vim at the end
# to make life a bit easier
vim $PKG_NAME/seed.sh
