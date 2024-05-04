NAME="man-pages"
DESC="The Man-pages package contains over 2,400 man pages."
VERSION="6.7"
SOURCE="https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${VERSION}.tar.xz"
CHECKSUM="1bd39d60e741f37b550d27f9d4fb1656"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make prefix=$FAKEROOT/$NAME/usr install
}
