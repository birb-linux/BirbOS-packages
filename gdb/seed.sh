NAME="gdb"
DESC="the GNU Project debugger"
VERSION="13.1"
SOURCE="https://ftp.gnu.org/gnu/gdb/gdb-${VERSION}.tar.xz"
CHECKSUM="4aaad768ff2585464173c091947287ec"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	../configure --prefix=$FAKEROOT/$NAME/usr \
				 --with-system-readline \
				 --with-python=/usr/bin/python3

	 make -j$(nproc)
}

_install()
{
	make -C gdb install
}
