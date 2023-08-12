NAME="libxpresent"
DESC="Xlib-based library for the X Present Extension"
VERSION="1.0.1"
SOURCE="https://gitlab.freedesktop.org/xorg/lib/libxpresent/-/archive/libXpresent-${VERSION}/libxpresent-libXpresent-${VERSION}.tar.gz"
CHECKSUM="1dcfd82d7296afd12b6ab5e343b220d8"
DEPS="xorgproto libxext libxfixes libxrandr libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libxpresent-libXpresent-${VERSION}
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc \
		--localstatedir=/var --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
