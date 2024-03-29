NAME="libinput"
DESC="Library that handles input devices for display servers and other applications"
VERSION="1.23.0"
SOURCE="https://gitlab.freedesktop.org/libinput/libinput/-/archive/${VERSION}/libinput-${VERSION}.tar.gz"
CHECKSUM="1faafdbe54745b5b59305b0764155a15"
DEPS="libevdev mtdev meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

# TODO: This package needs some tweaks to the meson command
# if GNOME or Wacom support is needed
_build()
{
	mkdir build
	cd    build

	meson setup --prefix=$XORG_PREFIX    \
				--buildtype=release      \
				-Ddebug-gui=false        \
				-Dtests=false            \
				-Dlibwacom=false         \
				-Dudev-dir=/usr/lib/udev \
				..
	ninja
}

_install()
{
	ninja install
}
