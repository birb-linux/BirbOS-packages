NAME="gawk"
DESC="Programs for manipulating text files"
VERSION="5.3.0"
SOURCE="https://ftp.gnu.org/gnu/gawk/gawk-${VERSION}.tar.xz"
CHECKSUM="97c5a7d83f91a7e1b2035ebbe6ac7abd"
DEPS=""
FLAGS="test important"

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

	make -j${BUILD_JOBS}
}

_install()
{
	make LN='ln -f' install

	# Point the awk binary to the fakeroot gawk
	rm -v $FAKEROOT/$NAME/usr/bin/awk
	ln -srfv $FAKEROOT/$NAME/usr/bin/gawk /usr/bin/awk

	# Install the documentation
	mkdir -pv                                   $FAKEROOT/$NAME/usr/share/doc/gawk-${VERSION}
	cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} $FAKEROOT/$NAME/usr/share/doc/gawk-${VERSION}
}

_test()
{
	make -j${BUILD_JOBS} check
}
