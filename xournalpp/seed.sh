NAME="xournalpp"
DESC="Handwriting notetaking software"
VERSION="1.2.2"
SOURCE="https://github.com/xournalpp/xournalpp/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="64b14cd491b1abf5a232f168941a44bc"
DEPS="papirus-icon-theme glib gtk+ poppler libxml2 libzip portaudio libsndfile librsvg"
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
	cmake -DCMAKE_INSTALL_PREFIX=/usr ..
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
