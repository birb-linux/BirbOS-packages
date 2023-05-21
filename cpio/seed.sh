NAME="cpio"
DESC="Tools for archiving"
VERSION="2.13"
SOURCE="https://ftp.gnu.org/gnu/cpio/cpio-${VERSION}.tar.bz2"
CHECKSUM="f3438e672e3fa273a7dc26339dd1eed6"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a build issue with modern versions of GCC
	sed -i '/The name/,+2 d' src/global.c

	./configure --prefix=$FAKEROOT/$NAME/usr \
            --enable-mt   \
            --with-rmt=/usr/libexec/rmt

	make -j${BUILD_JOBS}
	makeinfo --html            -o doc/html      doc/cpio.texi
	makeinfo --html --no-split -o doc/cpio.html doc/cpio.texi
	makeinfo --plaintext       -o doc/cpio.txt  doc/cpio.texi
}

_install()
{
	make install
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/cpio-${VERSION}/html
	install -v -m644    doc/html/* \
						$FAKEROOT/$NAME/usr/share/doc/cpio-${VERSION}/html
	install -v -m644    doc/cpio.{html,txt} \
						$FAKEROOT/$NAME/usr/share/doc/cpio-${VERSION}
}

_test()
{
	make -j${BUILD_JOBS} check
}
