NAME="libnotify"
DESC="The libnotify library is used to send desktop notifications to a notification daemon"
VERSION="0.8.1"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/libnotify/${SHORT_VERSION}/libnotify-${VERSION}.tar.xz"
CHECKSUM="1495f279b255b4493ac3588559823158"
DEPS="gtk+ notification-daemon"
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

	meson --prefix=/usr       \
		  --buildtype=release \
		  -Dgtk_doc=false     \
		  -Dman=false ..

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
	mv -v $FAKEROOT/$NAME/usr/share/doc/libnotify{,-${VERSION}}
}
