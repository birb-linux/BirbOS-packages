NAME="desmune"
DESC="Nintendo DS emulator"
VERSION="0_9_13"
SOURCE="https://github.com/TASEmulators/desmume/archive/refs/tags/release_${VERSION}.tar.gz"
CHECKSUM="d6c9bb4dd1dcaee9c0a5064663e66658"
DEPS="alsa-lib gtk+ ninja meson sdl2"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-release_${VERSION}
}

_build()
{
	cd desmume/src/frontend/posix
	meson build --buildtype=release --prefix=/usr
	ninja -C build
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
