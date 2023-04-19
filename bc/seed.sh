NAME="bc"
DESC="Arbitrary precision numeric processing language"
VERSION="6.5.0"
SOURCE="https://github.com/gavinhoward/bc/releases/download/${VERSION}/bc-${VERSION}.tar.xz"
CHECKSUM="e4757f48340dfe74af0d5be7ea56f7c7"
DEPS="readline"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	CC=gcc ./configure --prefix=$FAKEROOT/$NAME/usr -G -O3 -r

	make -j$(nproc)
	make test
}

_install()
{
	make install
}
