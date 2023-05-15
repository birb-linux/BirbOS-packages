NAME="libdrm"
DESC="Userspace library for accessing the direct rendering manager (DRM)"
VERSION="2.4.115"
SOURCE="https://dri.freedesktop.org/libdrm/libdrm-${VERSION}.tar.xz"
CHECKSUM="5403981a20c964f4c893ff91393652bd"
DEPS="xorg-libs"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson setup  --prefix=$XORG_PREFIX \
				 --buildtype=release   \
				 -Dudev=true           \
				 -Dvalgrind=disabled
	ninja
}

_install()
{
	ninja install
}
