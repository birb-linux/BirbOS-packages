NAME="libxslt"
DESC="XSLT libraries used for extending libxml2 libraries to support XSLT files"
VERSION="1.1.38"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libxslt/${SHORT_VERSION}/libxslt-${VERSION}.tar.xz"
CHECKSUM="7d6e43db810177ddf9818ef394027019"
DEPS="libxml2 docbook-xml docbook-xsl-nons"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --disable-static                 \
            --docdir=/usr/share/doc/libxslt-${VERSION} \
            PYTHON=/usr/bin/python3

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}

_test()
{
	make -j${BUILD_JOBS} check
}
