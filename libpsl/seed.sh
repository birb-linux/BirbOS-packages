NAME="libpsl"
DESC="A library for accessing and resolving information from the Public Suffix List (PSL)"
VERSION="0.21.5"
SOURCE="https://github.com/rockdaboot/libpsl/releases/download/${VERSION}/libpsl-${VERSION}.tar.gz"
CHECKSUM="870a798ee9860b6e77896548428dba7b"
DEPS="libidn2"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i 's/env python/&3/' src/psl-make-dafsa

	./configure --prefix=/usr --disable-static PYTHON=python3
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}
