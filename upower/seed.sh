NAME="upower"
DESC="Interface for enumerating power devices, listening to device events and querying history and statistics"
VERSION="1.90.0"
SOURCE="https://gitlab.freedesktop.org/upower/upower/-/archive/v${VERSION}/upower-v${VERSION}.tar.bz2"
CHECKSUM="4fba71838a9ba0db6f140418eddbe2b7"
DEPS="libgudev libusb polkit"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-v${VERSION}
}

_build()
{
	# Remove an unneeded test related dependency
	sed '/parse_version/d' -i src/linux/integration-test.py

	mkdir build
	cd    build

	meson --prefix=/usr                    \
      --buildtype=release                  \
      -Dgtk-doc=false                      \
      -Dman=false                          \
      -Dsystemdsystemunitdir=no            \
      -Dudevrulesdir=/usr/lib/udev/rules.d \
      ..

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
