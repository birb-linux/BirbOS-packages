NAME="libxml2"
DESC="Libraries and utilities for parsing XML files"
VERSION="2.10.4"
SOURCE="https://download.gnome.org/sources/libxml2/$(echo "$VERSION" | awk -F '.' '{print $1 "." $2}')/libxml2-${VERSION}.tar.xz"
CHECKSUM="76808c467a58c31e2dbd511e71d5fd13"
DEPS="icu"
FLAGS="important python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --sysconfdir=/etc       \
            --disable-static        \
            --with-history          \
            --with-icu              \
			--with-python           \
            PYTHON=/usr/bin/python3 \
            --docdir=/usr/share/doc/libxml2-${VERSION}

	make -j${BUILD_JOBS}

	# Build the python module
	cd python
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
	cd ..
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Install the python module
	cd python
	pip3 install --no-index --find-links=$FAKEROOT/$NAME/$PYTHON_DIST wheel
}

#_build32()
#{
#	make distclean
#
#	LD_FLAGS=""
#	PKG_CONFIG_PATH=""
#	./configure --prefix=/usr \
#            --sysconfdir=/etc       \
#            --disable-static        \
#            --with-history          \
#            --with-icu              \
#            PYTHON=/usr/bin/python3 \
#            --docdir=$FAKEROOT/$NAME/usr/share/doc/libxml2-${VERSION}
#
#	make -j${BUILD_JOBS}
#}
#
#_install32()
#{
#	make DESTDIR=$PWD/DESTDIR install
#	cp -Rv DESTDIR/usr/local/lib/* $FAKEROOT/$NAME/usr/lib32
#	rm -rf DESTDIR
#}
