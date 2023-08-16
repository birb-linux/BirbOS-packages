NAME="birb-utils"
DESC="Miscellaneous utility scripts and programs made for BirbOS"
VERSION="0.6.2"
SOURCE="https://github.com/Toasterbirb/birb-utils/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="289b2d873dc1b252136bd1936a175a90"
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
