NAME="libvdpau"
DESC="Library which implements the VDPAU library"
VERSION="1.5"
SOURCE="https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/${VERSION}/libvdpau-${VERSION}.tar.bz2"
CHECKSUM="148a192110e7a49d62c0bf9ef916c099"
DEPS="xorg-libs mesa"
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

	meson --prefix=$XORG_PREFIX ..
	ninja
}

_install()
{
	ninja install
}
