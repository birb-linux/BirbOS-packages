NAME="libxfce4ui"
DESC="GTK+ 2 widgets that are used by Xfce applications"
VERSION="4.18.2"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://archive.xfce.org/src/xfce/libxfce4ui/${SHORT_VERSION}/libxfce4ui-${VERSION}.tar.bz2"
CHECKSUM="3ed8f18681ee811e41a01c5511f9d86f"
DEPS="gtk+ xfconf startup-notification"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --sysconfdir=/etc
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
