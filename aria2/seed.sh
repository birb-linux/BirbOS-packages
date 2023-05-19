NAME="aria2"
DESC="Lightweight multi-protocol & multi-source command-line download utility"
VERSION="1.36.0"
SOURCE="https://github.com/aria2/aria2/releases/download/release-${VERSION}/aria2-${VERSION}.tar.xz"
CHECKSUM="f11ff410bbe00385b4a1b20d22aa2598"
DEPS="autoconf openssl libssh2 zlib libxml2 c-ares pkg-config gmp"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	autoreconf -i
	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
