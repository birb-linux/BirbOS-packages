NAME="bc"
DESC="Arbitrary precision numeric processing language"
VERSION="6.7.5"
SOURCE="https://github.com/gavinhoward/bc/releases/download/${VERSION}/bc-${VERSION}.tar.xz"
CHECKSUM="e249b1f86f886d6fb71c15f72b65dd3d"
DEPS="readline"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	CC=gcc ./configure --prefix=$FAKEROOT/$NAME/usr -G -O3 -r

	make -j${BUILD_JOBS}
}

_test()
{
	make test
}

_install()
{
	make install
}
