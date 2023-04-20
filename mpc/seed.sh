NAME="mpc"
DESC="Library for the airthmetic of complex numbers with arbitrarily high precision and correct rounding of the result"
VERSION="1.3.1"
SOURCE="https://ftp.gnu.org/gnu/mpc/mpc-${VERSION}.tar.gz"
CHECKSUM="5c9bc658c9fd0f940e8e3e0f09530c62"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static \
            --docdir=/usr/share/doc/mpc-${VERSION}

	make -j$(nproc)
	make html

	# Run tests
	make -j$(nproc) check
}

_install()
{
	make install
	make install-html
}
