NAME="fcitx"
DESC="A Flexible Input Method Framework"
VERSION="4.2.9.9"
SOURCE="https://github.com/fcitx/fcitx/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="633ea15f5fd98cc132ae55dd08acb398"
DEPS="extra-cmake-modules iso-codes libx11 glib cairo dbus pango libxcb gtk+ gobject-introspection"
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

	cmake ..                        \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DENABLE_QT=Off             \
		-DENABLE_GTK2_IM_MODULE=Off \
		-DENABLE_GTK3_IM_MODULE=On

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
