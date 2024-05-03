NAME="birb-utils"
DESC="Miscellaneous utility scripts and programs made for BirbOS"
VERSION="0.7.1"
SOURCE="https://github.com/Toasterbirb/birb-utils/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="8379b5ead39e44b7bf8b3a2e11f1c4c5"
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
