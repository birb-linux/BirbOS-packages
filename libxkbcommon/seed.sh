NAME="libxkbcommon"
DESC="Keymap compiler and support library which processes a reduced subset of keymaps as defined by the XKB specification"
VERSION="1.5.0"
SOURCE="https://xkbcommon.org/download/libxkbcommon-${VERSION}.tar.xz"
CHECKSUM="40f0486b4eb491928ec6616c2ff85120"
DEPS="xkeyboard-config libxcb"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	# TODO: Make it possible to enable wayland via a useflag
	meson --prefix=/usr       \
		  --buildtype=release \
		  -Denable-wayland=false \
		  -Denable-docs=false ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_test()
{
	ninja test
}
