NAME="texinfo"
DESC="Programs for reading, writing, and converting info pages"
VERSION="7.1"
SOURCE="https://ftp.gnu.org/gnu/texinfo/texinfo-${VERSION}.tar.xz"
CHECKSUM="edd9928b4a3f82674bcc3551616eef3b"
DEPS="ncurses perl intltool gettext"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Install the components belonging in a TeX installation
	make TEXMF=$FAKEROOT/$NAME/usr/share/texmf install-tex
}

_test()
{
	make -j${BUILD_JOBS} check
}
