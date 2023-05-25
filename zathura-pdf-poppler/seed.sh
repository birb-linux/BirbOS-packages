NAME="zathura-pdf-poppler"
DESC="PDF support (poppler backend) for zathura"
VERSION="0.3.0"
SOURCE="https://git.pwmt.org/pwmt/zathura-pdf-poppler/-/archive/${VERSION}/zathura-pdf-poppler-${VERSION}.tar.gz"
CHECKSUM="c500be47cfac0e76e81309cfa7847353"
DEPS="zathura girara poppler"
FLAGS=""

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
