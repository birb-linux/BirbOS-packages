NAME="texinfo"
DESC="Programs for reading, writing, and converting info pages"
VERSION="7.0.3"
SOURCE="https://ftp.gnu.org/gnu/texinfo/texinfo-${VERSION}.tar.xz"
CHECKSUM="37bf94fd255729a14d4ea3dda119f81a"
DEPS=""
FLAGS="test"

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

	# Install the components belonging in a TeX installation
	make TEXMF=$FAKEROOT/$NAME/usr/share/texmf install-tex
}

_test()
{
	make -j$(nproc) check
}
