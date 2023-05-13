NAME="xcb-util-wm"
DESC="Libraries which provide client and window-manager helpers for EWMH and ICCCM"
VERSION="0.4.2"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-wm-${VERSION}.tar.xz"
CHECKSUM="581b3a092e3c0c1b4de6416d90b969c3"
DEPS="libxcb"
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
