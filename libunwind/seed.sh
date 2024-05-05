# shellcheck disable=SC2034
NAME="libunwind"
DESC="Portable and efficient C programming interface (API) to determine the call-chain of a program"
VERSION="1.6.2"
SOURCE="https://download.savannah.nongnu.org/releases/libunwind/libunwind-${VERSION}.tar.gz"
CHECKSUM="f625b6a98ac1976116c71708a73dc44a"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	./configure --prefix=/usr --disable-static
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
