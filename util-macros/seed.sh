NAME="util-macros"
DESC="m4 macros used by all of the Xorg packages"
VERSION="1.20.0"
SOURCE="https://www.x.org/pub/individual/util/util-macros-${VERSION}.tar.xz"
CHECKSUM="50135407d81e2c97c2879a2ba3bac688"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
}

_install()
{
	make install
}
