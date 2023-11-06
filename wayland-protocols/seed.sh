NAME="wayland-protocols"
DESC="Additional Wayland protocols on top of Wayland core"
VERSION="1.31"
SOURCE="https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/${VERSION}/downloads/wayland-protocols-${VERSION}.tar.xz"
CHECKSUM="1584de13eb30a4d1f2cd06c08ee24354"
DEPS="wayland meson ninja"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release
	ninja
}

_install()
{
	ninja install
}

_test()
{
	ninja test
}
