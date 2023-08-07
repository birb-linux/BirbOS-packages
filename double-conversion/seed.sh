NAME="double-conversion"
DESC="A library that facilitates binary-to-decimal and decimal-to-binary routines for IEEE doubles"
VERSION="3.2.1"
SOURCE="https://github.com/google/double-conversion/archive/v${VERSION}/double-conversion-${VERSION}.tar.gz"
CHECKSUM="ccdcf76f6df822fb5488425e85707e55"
DEPS="cmake"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake -DCMAKE_INSTALL_PREFIX=/usr \
		  -DBUILD_SHARED_LIBS=ON      \
		  -DBUILD_TESTING=ON          \
		  ..

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make test
}
