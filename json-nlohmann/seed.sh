NAME="json-nlohmann"
DESC="JSON for Modern C++"
VERSION="3.11.2"
SOURCE="https://github.com/nlohmann/json/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="e8d56bc54621037842ee9f0aeae27746"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd json-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake .. -DJSON_BuildTests=OFF -DCMAKE_INSTALL_PREFIX=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
