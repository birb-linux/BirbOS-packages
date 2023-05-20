NAME="nettle"
DESC="Low-level cryptographic library that is designed to fit easily in many contexts"
VERSION="3.8.1"
SOURCE="https://ftp.gnu.org/gnu/nettle/nettle-${VERSION}.tar.gz"
CHECKSUM="e15c5fd5cc901f5dde6a271d7f2320d1"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${MAKEOPTS}
}

_install()
{
	make install
	chmod   -v   755 $FAKEROOT/$NAME/usr/lib/lib{hogweed,nettle}.so
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/nettle-${VERSION}
	install -v -m644 nettle.html $FAKEROOT/$NAME/usr/share/doc/nettle-${VERSION}
}
