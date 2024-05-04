NAME="feh"
DESC="Fast, lightweight image viewer which uses Imlib2"
VERSION="3.10.2"
SOURCE="https://feh.finalrewind.org/feh-${VERSION}.tar.bz2"
CHECKSUM="0a780bf321c0653d03e3e18410f4d1ba"
DEPS="libpng imlib2 libjpeg-turbo curl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i "s:doc/feh:&-${VERSION}:" config.mk
	make PREFIX=/usr -j${BUILD_JOBS}
}

_install()
{
	make PREFIX=/usr DESTDIR="$FAKEROOT/$NAME" install
}
