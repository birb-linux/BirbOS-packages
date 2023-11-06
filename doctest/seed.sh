NAME="doctest"
DESC="The fastest feature-rich C++11/14/17/20/23 single-header testing framework"
VERSION="2.4.11"
SOURCE="https://github.com/doctest/doctest/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="a457ba0e8c8f670bfd4aafaa3d9f5e4d"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	cmake -DCMAKE_INSTALL_PREFIX=/usr -DDOCTEST_WITH_TESTS=Off -DDOCTEST_NO_INSTALL=Off .
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
