NAME="shared-mime-info"
DESC="MIME database"
VERSION="2.2"
SOURCE="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${VERSION}/shared-mime-info-${VERSION}.tar.gz"
CHECKSUM="06cb9e92e4211dc53fd52b7bfd586c78"
DEPS="glib libxml2"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix an issue with xmlto (basically just don't use it)
	sed -i 's/build_by_default: true/build_by_default: false/' data/meson.build

	mkdir build
	cd    build

	meson --prefix=/usr --buildtype=release -Dupdate-mimedb=false ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_build32()
{
	cd ..
	rm -r build
	mkdir build
	cd    build

	meson --prefix=/usr --buildtype=release -Dupdate-mimedb=false ..

	# meson is stubborn and doesn't want to link against 32bit
	sed -i 's/\/usr\/lib\//\/usr\/lib32\//g' ./build.ninja

	ninja
}

_install32()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
