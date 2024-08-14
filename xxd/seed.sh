# shellcheck disable=SC2034
NAME="xxd"
DESC="Make a hexdump or do the reverse"
VERSION="9.0.1452"
SOURCE="https://anduin.linuxfromscratch.org/LFS/vim-${VERSION}.tar.gz"
CHECKSUM="dccf279f33a1df7e4e81941f38306de3"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "vim-${VERSION}" || exit 1
}

_build()
{
	./configure --prefix=/usr

	cd src/xxd || exit 1
	make -j "${BUILD_JOBS}"
}

_install()
{
	cp -v ./xxd "$FAKEROOT/$NAME/usr/bin/"
}
