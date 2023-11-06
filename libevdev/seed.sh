NAME="libevdev"
DESC="Common functions for Xorg input drivers"
VERSION="1.13.0"
SOURCE="https://www.freedesktop.org/software/libevdev/libevdev-${VERSION}.tar.xz"
CHECKSUM="5b15b4cf97c4f9f1393e499526a57665"
DEPS="meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}

	kernel_check "CONFIG_INPUT CONFIG_INPUT_EVDEV CONFIG_INPUT_MISC"
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=$XORG_PREFIX    \
		  --buildtype=release      \
		  -Ddocumentation=disabled
	ninja
}

_install()
{
	ninja install
}
