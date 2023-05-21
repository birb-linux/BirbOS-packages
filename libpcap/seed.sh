NAME="libpcap"
DESC="Functions for user-level packet capture"
VERSION="1.10.3"
SOURCE="https://www.tcpdump.org/release/libpcap-${VERSION}.tar.gz"
CHECKSUM="c42fde2eb75a5075f19116f8c9768573"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	# Skip installing the static libraries
	sed -i '/INSTALL_DATA.*libpcap.a\|RANLIB.*libpcap.a/ s/^/#/' Makefile

	make install
}
