NAME="pfetch"
DESC="A pretty system information tool written in POSIX sh"
VERSION="0.6.0"
SOURCE="https://github.com/dylanaraps/pfetch/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="934e54f1bad59bc53cd97bd799ed830c"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Patch in support for the birb package manager
	patch -i $PKG_PATH/pfetch_birb_support.patch
}

_install()
{
	# make prefix=$FAKEROOT/$NAME/usr install
	cp -fv pfetch $FAKEROOT/$NAME/usr/bin/
}
