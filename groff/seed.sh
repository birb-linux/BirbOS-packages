NAME="groff"
DESC="Programs for processing and formatting text and images"
VERSION="1.22.4"
SOURCE="https://ftp.gnu.org/gnu/groff/groff-${VERSION}.tar.gz"
CHECKSUM="08fb04335e2f5e73f23ea4c3adbf0c5f"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PAGE=A4 ./configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)
}

_install()
{
	make install
}
