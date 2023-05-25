NAME="json-c"
DESC="A reference counting object model that allows you to easily construct JSON objects in C"
VERSION="0.16"
SOURCE="https://s3.amazonaws.com/json-c_releases/releases/json-c-${VERSION}.tar.gz"
CHECKSUM="8110782cb2a996da5517f1f27a4bed8e"
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
		  -DCMAKE_BUILD_TYPE=Release \
		  -DBUILD_STATIC_LIBS=OFF    \
		  ..

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} test
}
