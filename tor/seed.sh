NAME="tor"
DESC="The Onion Router"
VERSION="0.4.8.8"
SOURCE="https://dist.torproject.org/tor-${VERSION}.tar.gz"
CHECKSUM="3915a039b0889acd946223d299df0cfd"
DEPS="asciidoc libseccomp zstd openssl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-unittests
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
