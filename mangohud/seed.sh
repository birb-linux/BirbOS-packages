NAME="mangohud"
DESC="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more"
VERSION="0.6.9-1"
SOURCE="https://github.com/flightlessmango/MangoHud/releases/download/v${VERSION}/MangoHud-v${VERSION}-Source.tar.xz"
CHECKSUM="2f8ca049584f404b7807d730c861c31a"
DEPS="meson ninja glslang mesa xorgproto dbus mako"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd MangoHud-v$(echo ${VERSION} | grep -o "[0-9]\.[0-9]\.[0-9]")
}

_build()
{
	meson -Dwith_xnvctrl=disabled --prefix=/usr build
	ninja -C build
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja -C build install install
}

_build32()
{
	C="gcc -m32" \
	CXX="g++ -m32" \
	PKG_CONFIG_PATH="/usr/lib32/pkgconfig:/usr/lib/i386-linux-gnu/pkgconfig:/usr/lib/pkgconfig" \
	meson build32 --libdir lib32 --prefix=/usr
}

_install32()
{
	DESTDIR=$FAKEROOT/$NAME ninja -C build32 install
}
