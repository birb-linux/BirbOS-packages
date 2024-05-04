NAME="libnotify"
DESC="The libnotify library is used to send desktop notifications to a notification daemon"
VERSION="0.8.3"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libnotify/${SHORT_VERSION}/libnotify-${VERSION}.tar.xz"
CHECKSUM="952e55f45067b6a5b9eab4310c9cd658"
DEPS="gtk+ notification-daemon meson ninja"
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
		  -Ddocbook_docs=disabled \
		  -Dman=false ..

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
	#mv -v $FAKEROOT/$NAME/usr/share/doc/libnotify{,-${VERSION}}
}
