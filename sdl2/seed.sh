NAME="sdl2"
DESC="Simple DirectMedia Layer Version 2"
VERSION="2.26.3"
SOURCE="https://www.libsdl.org/release/SDL2-${VERSION}.tar.gz"
CHECKSUM="6ff7cbe9f77fc5afa79d54895dc6becc"
DEPS="libxkbcommon xorg-libs wayland-protocols nasm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${MAKEOPTS}
}

_install()
{
	make install

	# Get rid of the static library
	rm -v $FAKEROOT/$NAME/usr/lib/libSDL2*.a
}
