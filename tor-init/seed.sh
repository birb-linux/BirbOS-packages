NAME="tor-init"
DESC="SysVinit bootscripts for BirbOS"
VERSION="1.0.0"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/birb-linux/bootscripts/archive/${VERSION}.tar.gz"
CHECKSUM="111919956481bc89f71c91941cfe2e79"
DEPS="tor"
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
	make DESTDIR=$FAKEROOT/$NAME install
}
