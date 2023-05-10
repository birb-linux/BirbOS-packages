NAME="nmap"
DESC="Utility for network exploration and security auditing"
VERSION="7.93"
SOURCE="https://nmap.org/dist/nmap-${VERSION}.tar.bz2"
CHECKSUM="9027eac4b8ca57574012cb061ba9ce4d"
DEPS="libpcap lua pcre liblinear"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${MAKEOPTS}
}

_install()
{
	make install
}
