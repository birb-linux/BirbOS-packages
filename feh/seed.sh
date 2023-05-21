NAME="feh"
DESC="Fast, lightweight image viewer which uses Imlib2"
VERSION="3.9.1"
SOURCE="https://feh.finalrewind.org/feh-${VERSION}.tar.bz2"
CHECKSUM="d83f1731515d31069908d4bda5f3489b"
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
	make PREFIX=$FAKEROOT/$NAME/usr -j${BUILD_JOBS}
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr install
}
