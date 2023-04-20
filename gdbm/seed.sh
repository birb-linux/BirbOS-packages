NAME="gdbm"
DESC="GNU Database Manager"
VERSION="1.23"
SOURCE="https://ftp.gnu.org/gnu/gdbm/gdbm-${VERSION}.tar.gz"
CHECKSUM="8551961e36bf8c70b7500d255d3658ec"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static \
            --enable-libgdbm-compat

	make -j$(nproc)
}

_install()
{
	make install
}

_test()
{
	make -j$(nproc) check
}
