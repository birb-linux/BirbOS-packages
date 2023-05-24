NAME="zathura"
DESC="Highly customizable and functional document viewer"
VERSION="0.5.1"
SOURCE="https://git.pwmt.org/pwmt/zathura/-/archive/${VERSION}/zathura-${VERSION}.tar.gz"
CHECKSUM="ebff8233b2e588def137a33a632b1c91"
DEPS="gtk+ glib girara file sqlite libseccomp meson gettext pkg-config sphinx"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	meson --prefix=/usr build
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
