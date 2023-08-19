NAME="screenshot"
DESC="Screenshotting utility built around scrot"
VERSION="1.0.1"
SOURCE="https://github.com/birb-linux/screenshot/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="f298797dc61337c73df6b5c10320b3c8"
DEPS="scrot dragon"
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
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
