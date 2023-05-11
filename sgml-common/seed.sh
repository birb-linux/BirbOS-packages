NAME="sgml-common"
DESC="Contains the install-catalog program that is used for creating and maintaining centralized SGML catalogs"
VERSION="0.6.3"
SOURCE="https://sourceware.org/ftp/docbook-tools/new-trials/SOURCES/sgml-common-${VERSION}.tgz"
CHECKSUM="103c9828f24820df86e55e7862e28974"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a build issue with modern automake
	patch -Np1 -i $PKG_PATH/sgml-common-0.6.3-manpage-1.patch
	autoreconf -f -i

	./configure --prefix=$FAKEROOT/$NAME/usr --sysconfdir=/etc

	make -j${MAKEOPTS}
}

_install()
{
	make docdir=$FAKEROOT/$NAME/usr/share/doc install

	# TODO: These commands may need to be changed when updating
	# this package
	$FAKEROOT/$NAME/usr/bin/install-catalog --add /etc/sgml/sgml-ent.cat \
		$FAKEROOT/$NAME/usr/share/sgml/sgml-iso-entities-8879.1986/catalog

	$FAKEROOT/$NAME/usr/bin/install-catalog --add /etc/sgml/sgml-docbook.cat \
		/etc/sgml/sgml-ent.cat
}
