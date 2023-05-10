NAME="wayland"
DESC="Compositor protocol"
VERSION="1.21.0"
SOURCE="https://gitlab.freedesktop.org/wayland/wayland/-/releases/${VERSION}/downloads/wayland-${VERSION}.tar.xz"
CHECKSUM="f2653a2293bcd882d756c6a83d278903"
DEPS="libxml2"
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

	meson --prefix=$FAKEROOT/$NAME/usr \
		  --buildtype=release \
		  -Ddocumentation=false

	ninja
}

_install()
{
	ninja install
}

_test()
{
	env -u XDG_RUNTIME_DIR ninja test
}
