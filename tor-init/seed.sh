NAME="tor-init"
DESC="SysVinit bootscripts for BirbOS"
VERSION="1.0.2"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/birb-linux/bootscripts/archive/${VERSION}.tar.gz"
CHECKSUM="8c52df0a5dc09e7683756285ec050323"
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
