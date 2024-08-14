# shellcheck disable=SC2034
NAME="mold"
DESC="A Modern Linker"
VERSION="2.31.0"
SOURCE="https://github.com/rui314/mold/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="fdfcddefc039071f5a7611c051a8f5ea"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	mkdir build
	cd    build || exit 1

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
