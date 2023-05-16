NAME="xkeyboard-config"
DESC="Keyboard configuration database for the X Window System"
VERSION="2.38"
SOURCE="https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-${VERSION}.tar.xz"
CHECKSUM="c89fb974e8f1ba14c64d1bcf3a0f8d11"
DEPS="xorg-libs"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=$XORG_PREFIX \
		--buildtype=release \
		--datadir=/usr/share ..

	ninja
}

_install()
{
	ninja install
}
