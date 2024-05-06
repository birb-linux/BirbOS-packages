# shellcheck disable=SC2034
NAME="libglvnd"
DESC="The GL Vendor-Neutral Dispatch library"
VERSION="1.7.0"
SOURCE="https://github.com/NVIDIA/libglvnd/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="bbfdc3e1a2cd33a4a3d3a46498248376"
DEPS="libxext libx11 xorgproto"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
