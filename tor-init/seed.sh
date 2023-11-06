NAME="tor-init"
DESC="SysVinit bootscripts for BirbOS"
VERSION="1.0.1"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/birb-linux/bootscripts/archive/${VERSION}.tar.gz"
CHECKSUM="eb175e5076e9d774ac85fac3c8aaf5c4"
DEPS="tor"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd bootscripts
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install-tor
}
