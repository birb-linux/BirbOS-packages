NAME="libxslt"
DESC="XSLT libraries used for extending libxml2 libraries to support XSLT files"
VERSION="1.1.37"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libxslt/${SHORT_VERSION}/libxslt-${VERSION}.tar.xz"
CHECKSUM="84e86fc8a1b7495674016e05e4c5da44"
DEPS="libxml2 docbook-xml docbook-xsl-nons"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static                 \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/libxslt-${VERSION} \
            PYTHON=/usr/bin/python3

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}
