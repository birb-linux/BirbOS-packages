NAME="man-pages"
DESC="The Man-pages package contains over 2,400 man pages."
VERSION="6.04"
SOURCE="https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${VERSION}.tar.xz"
CHECKSUM="bbce1456edfa75a66c189cc594af6c4d"
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
