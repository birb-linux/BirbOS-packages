NAME="xorgproto"
DESC="Header files required to build the X Window system"
VERSION="2022.2"
SOURCE="https://xorg.freedesktop.org/archive/individual/proto/xorgproto-${VERSION}.tar.xz"
CHECKSUM="3fdb11d75f7023db273f7b3e34b58338"
DEPS="util-macros"
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

	meson --prefix=$XORG_PREFIX -Dlegacy=true ..
	ninja
}

_install()
{
	ninja install
	mv -v $XORG_PREFIX/share/doc/xorgproto{,-${VERSION}}
}
