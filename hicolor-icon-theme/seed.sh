NAME="hicolor-icon-theme"
DESC="A default fallback theme for implementations of the icon theme specification"
VERSION="0.17"
SOURCE="https://icon-theme.freedesktop.org/releases/hicolor-icon-theme-${VERSION}.tar.xz"
CHECKSUM="84eec8d6f810240a069c731f1870b474"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
