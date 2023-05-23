NAME="xinit"
DESC="Script that starts the xserver"
VERSION="1.4.2"
SOURCE="https://www.x.org/pub/individual/app/xinit-${VERSION}.tar.xz"
CHECKSUM="0e9a1b9a82b84ab229c709c0f939c113"
DEPS="xorg-libs"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG \
		--with-xinitdir=$FAKEROOT/$NAME/etc/X11/app-defaults \
		--with-xserver=/usr/bin/X
	make -j${BUILD_JOBS}
}

_install()
{
	make install
	ldconfig
}
