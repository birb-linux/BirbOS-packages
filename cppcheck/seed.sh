NAME="cppcheck"
DESC="Static source code analysis tool for C and C++ code"
VERSION="2.10"
SOURCE="https://sourceforge.net/projects/cppcheck/files/cppcheck/${VERSION}/cppcheck-${VERSION}.tar.gz"
CHECKSUM="584b5114ca903c7e4739493586825c18"
DEPS=""
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
