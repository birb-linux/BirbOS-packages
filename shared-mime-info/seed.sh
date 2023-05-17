NAME="shared-mime-info"
DESC="MIME database"
VERSION="2.2"
SOURCE="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${VERSION}/shared-mime-info-${VERSION}.tar.gz"
CHECKSUM="06cb9e92e4211dc53fd52b7bfd586c78"
DEPS="glib libxml2"
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

	meson --prefix=/usr --buildtype=release -Dupdate-mimedb=true ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
