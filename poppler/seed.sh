NAME="poppler"
DESC="PDF rendering library and command line tools used to manipulate PDF files"
VERSION="23.02.0"
SOURCE="https://poppler.freedesktop.org/poppler-${VERSION}.tar.xz"
CHECKSUM="ce7eef12c40dcd78998a43422c2c71ef"
DEPS="cmake fontconfig gobject-introspection boost cairo little-cms libjpeg-turbo libpng nss openjpeg"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	# qt flag enables qt5 support needed for okular
	cmake  -DCMAKE_BUILD_TYPE=Release                     \
		   -DCMAKE_INSTALL_PREFIX=/usr                \
		   -DTESTDATADIR=$PWD/testfiles               \
		   -DENABLE_QT5=$(expand_use "qt" "ON" "OFF") \
		   -DENABLE_QT6=off                           \
		   -DBUILD_QT5_TESTS=off                      \
		   -DBUILD_QT6_TESTS=off                      \
		   -DBUILD_GTK_TESTS=off                      \
		   -DBUILD_CPP_TESTS=off                      \
		   -DBUILD_MANUAL_TESTS=off                   \
		   -DENABLE_UNSTABLE_API_ABI_HEADERS=ON       \
		   ..

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Install the documentation
	install -v -m755 -d           $FAKEROOT/$NAME/usr/share/doc/poppler-${VERSION}
	cp -vr ../glib/reference/html $FAKEROOT/$NAME/usr/share/doc/poppler-${VERSION}
}
