NAME="tor-init"
DESC="SysVinit bootscripts for BirbOS"
VERSION="1.0.3"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/birb-linux/bootscripts/archive/${VERSION}.tar.gz"
CHECKSUM="1647de021da9e6a71ce1ce3b98a4420a"
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
