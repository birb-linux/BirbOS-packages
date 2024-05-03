NAME="birb-utils"
DESC="Miscellaneous utility scripts and programs made for BirbOS"
VERSION="0.7.0"
SOURCE="https://github.com/Toasterbirb/birb-utils/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="2414df825dd3f7d08a0eb37f301480c7"
DEPS="file wget curl sudo gnupg"
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
