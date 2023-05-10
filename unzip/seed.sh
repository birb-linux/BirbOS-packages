NAME="unzip"
DESC="ZIP extraction utilities"
VERSION="60"
SOURCE="https://downloads.sourceforge.net/infozip/unzip${VERSION}.tar.gz"
CHECKSUM="62b490407489521db863b523a7f86375"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}${VERSION}
}

_build()
{
	# Apply some upstream fixes etc.
	patch -Np1 -i $PKG_PATH/unzip-6.0-consolidated_fixes-1.patch

	make -f unix/Makefile generic
}

_install()
{
	make -j${MAKEOPTS} prefix=$FAKEROOT/$NAME/usr MANDIR=$FAKEROOT/$NAME/usr/share/man/man1 \
		 -f unix/Makefile install
}
