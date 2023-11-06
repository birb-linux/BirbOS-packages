NAME="gnumeric"
DESC="Spreadsheet program"
VERSION="1.12.55"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/gnumeric/${SHORT_VERSION}/gnumeric-${VERSION}.tar.xz"
CHECKSUM="76ab216b25c48b4f5fbf05f73e1ca7d9"
DEPS="goffice itstool"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
