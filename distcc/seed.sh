# shellcheck disable=SC2034
NAME="distcc"
DESC="Distributed builds for C, C++ and Objective C"
VERSION="3.4"
SOURCE="https://github.com/distcc/distcc/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="00523fd05f4cd9dd968e4e0ec09d774d"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr --without-libiberty
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
