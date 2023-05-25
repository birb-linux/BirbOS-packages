NAME="zathura-pdf-mupdf"
DESC="PDF support (mupdf backend) for zathura"
VERSION="0.3.9"
SOURCE="https://git.pwmt.org/pwmt/zathura-pdf-mupdf/-/archive/${VERSION}/zathura-pdf-mupdf-${VERSION}.tar.gz"
CHECKSUM="42fbef0dd6d90d91168dfeefefa9f21b"
DEPS="zathura girara mupdf meson"
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
