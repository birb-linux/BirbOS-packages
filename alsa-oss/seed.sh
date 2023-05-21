NAME="alsa-oss"
DESC="alsa-oss compatibility library for programs that use alsa-oss sound interface"
VERSION="1.1.8"
SOURCE="https://www.alsa-project.org/files/pub/oss-lib/alsa-oss-${VERSION}.tar.bz2"
CHECKSUM="9ec4bb783fdce19032aace086d65d874"
DEPS="alsa-lib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --disable-static --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
