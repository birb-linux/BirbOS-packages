NAME="poppler-data"
DESC="Encoding files for use with Poppler. They enable Poppler to render CJK and Cyrillic properly"
VERSION="0.4.12"
SOURCE="https://poppler.freedesktop.org/poppler-data-${VERSION}.tar.gz"
CHECKSUM="67ee4a40aa830b1f6e2560ce5f6471ba"
DEPS=""
FLAGS=""

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
	make DESTDIR=$FAKEROOT/$NAME prefix=/usr install
}
