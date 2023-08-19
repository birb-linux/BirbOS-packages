NAME="screenshot"
DESC="Screenshotting utility built around scrot"
VERSION="1.0.0"
SOURCE="https://github.com/birb-linux/screenshot/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="b362f3b5acdcb29f34fced293ce3f720"
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
