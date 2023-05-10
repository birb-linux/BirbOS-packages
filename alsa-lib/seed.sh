NAME="alsa-lib"
DESC="ALSA library used by programs (including ALSA Utilities) requiring access to the ALSA sound interface"
VERSION="1.2.8"
SOURCE="https://www.alsa-project.org/files/pub/lib/alsa-lib-${VERSION}.tar.bz2"
CHECKSUM="ab32de4b6054d7ab23723f8d85e50a27"
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
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make check
}
