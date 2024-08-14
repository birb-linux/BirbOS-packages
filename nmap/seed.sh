NAME="nmap"
DESC="Utility for network exploration and security auditing"
VERSION="7.94"
SOURCE="https://nmap.org/dist/nmap-${VERSION}.tar.bz2"
CHECKSUM="4f65e08148d1eaac6b1a1482e7185e1d"
DEPS="libpcap lua pcre liblinear"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
