NAME="gawk"
DESC="Programs for manipulating text files"
VERSION="5.2.1"
SOURCE="https://ftp.gnu.org/gnu/gawk/gawk-${VERSION}.tar.xz"
CHECKSUM="02956bc5d117a7437bb4f7039f23b964"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Ensure that some unneeded files don't get installed
	sed -i 's/extras//' Makefile.in

	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)
}

_install()
{
	make LN='ln -f' install

	# Install the documentation
	mkdir -pv                                   $FAKEROOT/$NAME/usr/share/doc/gawk-${VERSION}
	cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} $FAKEROOT/$NAME/usr/share/doc/gawk-${VERSION}
}

_test()
{
	make -j$(nproc) check
}