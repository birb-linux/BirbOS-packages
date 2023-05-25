NAME="zathura-pdf-mupdf"
DESC="EPUB, PDF and XPS support based on MuPDF"
VERSION="0.3.9"
SOURCE="https://git.pwmt.org/pwmt/zathura-pdf-mupdf/-/archive/${VERSION}/zathura-pdf-mupdf-${VERSION}.tar.gz"
CHECKSUM="42fbef0dd6d90d91168dfeefefa9f21b"
DEPS="zathura girara glib cairo mupdf meson"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Ignore the mupdf-third dependency, since mupdf doesn't provide
	# a shared libarry for it anymore and it doesn't seem to be necessary
	# anyway
	sed -i '/mupdfthird/d' meson.build

	meson --prefix=/usr build
	cd build

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
