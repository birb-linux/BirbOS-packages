NAME="birb-utils"
DESC="Miscellaneous utility scripts and programs made for BirbOS"
VERSION="0.8.1"
SOURCE="https://github.com/Toasterbirb/birb-utils/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="b32cb9c32978d26d837173cf154a3d19"
DEPS="file wget curl sudo gnupg fzf"
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
