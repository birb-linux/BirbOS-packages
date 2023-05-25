NAME="girara"
DESC="User interface library focused on simplicity and minimalism"
VERSION="0.4.0"
SOURCE="https://git.pwmt.org/pwmt/girara/-/archive/${VERSION}/girara-${VERSION}.tar.gz"
CHECKSUM="2b7931625166e870ddb5d36f68ddd225"
DEPS="gtk+ glib meson gettext pkg-config"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	meson -Djson=disabled --prefix=/usr build

	cd build
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_test()
{
	ninja test
}
