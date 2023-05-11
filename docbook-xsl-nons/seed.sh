NAME="docbook-xsl-nons"
DESC="XSL stylesheets useful for performing transformations on XML DocBook files"
VERSION="1.79.2"
SOURCE="https://github.com/docbook/xslt10-stylesheets/releases/download/release/${VERSION}/docbook-xsl-nons-${VERSION}.tar.bz2"
CHECKSUM="2666d1488d6ced1551d15f31d7ed8c38"
DEPS="libxml2"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a stack overflow bug
	patch -Np1 -i $PKG_PATH/docbook-xsl-nons-1.79.2-stack_fix-1.patch
}

_install()
{
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/xml/docbook/xsl-stylesheets-nons-${VERSION}

	cp -v -R VERSION assembly common eclipse epub epub3 extensions fo        \
			 highlighting html htmlhelp images javahelp lib manpages params  \
			 profiling roundtrip slides template tests tools webhelp website \
			 xhtml xhtml-1_1 xhtml5                                          \
		$FAKEROOT/$NAME/usr/share/xml/docbook/xsl-stylesheets-nons-${VERSION}

	ln -s VERSION $FAKEROOT/$NAME/usr/share/xml/docbook/xsl-stylesheets-nons-${VERSION}/VERSION.xsl

	install -v -m644 -D README \
						$FAKEROOT/$NAME/usr/share/doc/docbook-xsl-nons-${VERSION}/README.txt
	install -v -m644    RELEASE-NOTES* NEWS* \
						$FAKEROOT/$NAME/usr/share/doc/docbook-xsl-nons-${VERSION}
}
