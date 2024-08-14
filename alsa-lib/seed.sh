NAME="alsa-lib"
DESC="ALSA library used by programs (including ALSA Utilities) requiring access to the ALSA sound interface"
VERSION="1.2.11"
SOURCE="https://www.alsa-project.org/files/pub/lib/alsa-lib-${VERSION}.tar.bz2"
CHECKSUM="1c5870770047b6a520d18a43f49e42ea"
DEPS=""
FLAGS="test"

# TODO: Add checks for required kernel options

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}

_test()
{
	make check
}
