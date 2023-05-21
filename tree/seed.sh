NAME="tree"
DESC="Display a dictionary tree's contents, including files, directories, and links"
VERSION="2.1.0"
SOURCE="https://mama.indstate.edu/users/ice/tree/src/tree-${VERSION}.tgz"
CHECKSUM="50aa5cdb28df6340ef67a3a3ec953ffc"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr MANDIR=$FAKEROOT/$NAME/usr/share/man install
	chmod -v 644 $FAKEROOT/$NAME/usr/share/man/man1/tree.1
}
