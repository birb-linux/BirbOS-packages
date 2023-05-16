NAME="xf86-video-fbdev"
DESC="X.Org Video Driver for framebuffer devices"
VERSION="0.5.0"
SOURCE="https://www.x.org/pub/individual/driver/xf86-video-fbdev-${VERSION}.tar.bz2"
CHECKSUM="f07475655376be5a124d8187aacd87b6"
DEPS="xorg-server"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
