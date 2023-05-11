NAME="docbook-xml"
DESC="Document type definitions for verification of XML data files against the DocBook rule set"
VERSION="4.5"
SOURCE="https://www.docbook.org/xml/${VERSION}/docbook-xml-${VERSION}.zip"
CHECKSUM="03083e288e87a7e829e437358da7ef9e"
DEPS="libxml2 sgml-common unzip"
FLAGS=""

_setup()
{
	unzip $DISTFILES/$(basename $SOURCE)
}

_build()
{
	printf ""
}

_install()
{
	install -v -d -m755 $FAKEROOT/$NAME/usr/share/xml/docbook/xml-dtd-${VERSION}
	install -v -d -m755 $FAKEROOT/$NAME/etc/xml
	chown -R root:root .
	cp -v -af docbook.cat *.dtd ent/ *.mod \
		$FAKEROOT/$NAME/usr/share/xml/docbook/xml-dtd-${VERSION}

	# Create and populate the /etc/xml/docbook catalog
	if [ ! -e /etc/xml/docbook ]; then
		xmlcatalog --noout --create $FAKEROOT/$NAME/etc/xml/docbook
	fi

	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V${VERSION}//EN" \
		"http://www.oasis-open.org/docbook/xml/${VERSION}/docbookx.dtd" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML CALS Table Model V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/calstblx.dtd" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/soextblx.dtd" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Information Pool V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbpoolx.mod" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbhierx.mod" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML HTML Tables V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/htmltblx.mod" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Notations V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbnotnx.mod" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Character Entities V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbcentx.mod" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Additional General Entities V${VERSION}//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbgenent.mod" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/${VERSION}" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
		$FAKEROOT/$NAME/etc/xml/docbook
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/${VERSION}" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
		$FAKEROOT/$NAME/etc/xml/docbook


	# Create and populate the /etc/xml/catalog catalog file
	if [ ! -e /etc/xml/catalog ]; then
		xmlcatalog --noout --create $FAKEROOT/$NAME/etc/xml/catalog
	fi

	xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//ENTITIES DocBook XML" \
		"file:///etc/xml/docbook" \
		$FAKEROOT/$NAME/etc/xml/catalog
	xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//DTD DocBook XML" \
		"file:///etc/xml/docbook" \
		$FAKEROOT/$NAME/etc/xml/catalog
	xmlcatalog --noout --add "delegateSystem" \
		"http://www.oasis-open.org/docbook/" \
		"file:///etc/xml/docbook" \
		$FAKEROOT/$NAME/etc/xml/catalog
	xmlcatalog --noout --add "delegateURI" \
		"http://www.oasis-open.org/docbook/" \
		"file:///etc/xml/docbook" \
		$FAKEROOT/$NAME/etc/xml/catalog


	# Add configurations for older versions
	for DTDVERSION in 4.1.2 4.2 4.3 4.4
	do
	  xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V$DTDVERSION//EN" \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
		$FAKEROOT/$NAME/etc/xml/docbook
	  xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
		$FAKEROOT/$NAME/etc/xml/docbook
	  xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
		"file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
		$FAKEROOT/$NAME/etc/xml/docbook
	  xmlcatalog --noout --add "delegateSystem" \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
		"file:///etc/xml/docbook" \
		$FAKEROOT/$NAME/etc/xml/catalog
	  xmlcatalog --noout --add "delegateURI" \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
		"file:///etc/xml/docbook" \
		$FAKEROOT/$NAME/etc/xml/catalog
	done
}
