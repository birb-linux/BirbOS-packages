NAME="pycairo"
DESC="Python bindings for Cairo"
VERSION="1.23.0"
SOURCE="https://github.com/pygobject/pycairo/releases/download/v${VERSION}/pycairo-${VERSION}.tar.gz"
CHECKSUM="7a3729d21659098e1b9a411b62e88966"
DEPS="cairo meson ninja"
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

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
