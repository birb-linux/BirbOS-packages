NAME="intltool"
DESC="Internationalization tool used for extracting translatable strings from source files"
VERSION="0.51.0"
SOURCE="https://launchpad.net/intltool/trunk/${VERSION}/+download/intltool-${VERSION}.tar.gz"
CHECKSUM="12e517cac2b57a0121cda351570f1e63"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a perl warning
	sed -i 's:\\\${:\\\$\\{:' intltool-update.in

	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${MAKEOPTS}
}

_install()
{
	make install
	mkdir -p $FAKEROOT/$NAME/usr/share/doc/intltool-${VERSION}
	install -v -Dm644 doc/I18N-HOWTO $FAKEROOT/$NAME/usr/share/doc/intltool-${VERSION}/I18N-HOWTO
}

_test()
{
	make -j${MAKEOPTS} check
}
