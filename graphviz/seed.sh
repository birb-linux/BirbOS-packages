NAME="graphviz"
DESC="Graph visualization software"
VERSION="7.1.0"
SOURCE="https://gitlab.com/graphviz/graphviz/-/archive/${VERSION}/graphviz-${VERSION}.tar.bz2"
CHECKSUM="495f7da354be58309d91a2e0d377ae3b"
DEPS="pango cairo xorg-libs fontconfig libpng libjpeg-turbo"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i '/LIBPOSTFIX="64"/s/64//' configure.ac

	./autogen.sh
	./configure --prefix=$FAKEROOT/$NAME/usr \
				--docdir=$FAKEROOT/$NAME/usr/share/doc/graphviz-${VERSION}

	# Fix the build date
	sed -i "s/0/$(date +%Y%m%d)/" builddate.h

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
