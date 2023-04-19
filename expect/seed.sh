NAME="expect"
DESC="Tools for automating, via scripted dialogues and interactive applications"
VERSION="5.45.4"
SOURCE="https://prdownloads.sourceforge.net/expect/expect${VERSION}.tar.gz"
CHECKSUM="00fce8de158422f5ccd2666512329bd2"
DEPS="tcl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=$FAKEROOT/$NAME/usr/share/man \
            --with-tclinclude=/usr/include

	make -j$(nproc)

	# Run tests
	make -j$(nproc) test
}

_install()
{
	make install
	ln -svf expect5.45.4/libexpect5.45.4.so $FAKEROOT/$NAME/usr/lib
}
