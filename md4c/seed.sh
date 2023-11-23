NAME="md4c"
DESC="C Markdown parser"
VERSION="0.4.8"
SOURCE="https://github.com/mity/md4c/archive/refs/tags/release-${VERSION}.tar.gz"
CHECKSUM="3a3d87255705dd812a679d329638a92d"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-release-${VERSION}
}

_build()
{
	mkdir build
	cd    build
	cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
