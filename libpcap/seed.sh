NAME="libpcap"
DESC="Functions for user-level packet capture"
VERSION="1.10.4"
SOURCE="https://www.tcpdump.org/release/libpcap-${VERSION}.tar.gz"
CHECKSUM="0322e28dd76cda8066bb6d00fee5969b"
DEPS=""
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
	# Skip installing the static libraries
	sed -i '/INSTALL_DATA.*libpcap.a\|RANLIB.*libpcap.a/ s/^/#/' Makefile

	make DESTDIR=$FAKEROOT/$NAME install
}
