NAME="valgrind"
DESC="Instrumentation framework for building dynamic analysis tools"
VERSION="3.20.0"
SOURCE="https://sourceware.org/pub/valgrind/valgrind-${VERSION}.tar.bz2"
CHECKSUM="e3ca8e03c6c527e80e7da5135a1b6beb"
DEPS=""
FLAGS=""

# TODO: Add an option to use lto

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i 's|/doc/valgrind||' docs/Makefile.in

	./configure --prefix=$FAKEROOT/$NAME/usr \
				--datadir=$FAKEROOT/$NAME/usr/share/doc/valgrind-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install
}
