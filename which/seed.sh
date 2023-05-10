NAME="which"
DESC="Prints out the location of a given executable"
VERSION="2.21"
SOURCE="https://ftp.gnu.org/gnu/which/which-${VERSION}.tar.gz"
CHECKSUM="097ff1a324ae02e0a3b0369f07a7544a"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)
}

_install()
{
	make install
}
