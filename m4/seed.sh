NAME="m4"
DESC="Macro processor"
VERSION="1.4.19"
SOURCE="https://ftp.gnu.org/gnu/m4/m4-${VERSION}.tar.xz"
CHECKSUM="0d90823e1426f1da2fd872df0311298d"
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

	# Run tests
	make -j$(nproc) check
}

_install()
{
	make install
}
