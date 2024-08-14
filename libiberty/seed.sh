# shellcheck disable=SC2034
NAME="libiberty"
DESC="A collection of subroutines used by various GNU programs"
VERSION="14.1.0"
SOURCE="https://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.xz"
CHECKSUM="24195dca80ded5e0551b533f46a4481d"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "gcc-${VERSION}" || exit 1
}

_build()
{
	cd libiberty || exit 1
	./configure --prefix=/usr
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
