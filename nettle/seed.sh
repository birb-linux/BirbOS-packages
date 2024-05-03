NAME="nettle"
DESC="Low-level cryptographic library that is designed to fit easily in many contexts"
VERSION="3.9.1"
SOURCE="https://ftp.gnu.org/gnu/nettle/nettle-${VERSION}.tar.gz"
CHECKSUM="29fcd2dec6bf5b48e5e3ffb3cbc4779e"
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
	make -j${BUILD_JOBS}
}

_install()
{
	make install
	chmod   -v   755 $FAKEROOT/$NAME/usr/lib/lib{hogweed,nettle}.so
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/nettle-${VERSION}
	install -v -m644 nettle.html $FAKEROOT/$NAME/usr/share/doc/nettle-${VERSION}
}
