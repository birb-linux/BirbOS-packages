NAME="libpipeline"
DESC="Library for manipulating pipelines of subprocesses in a flexible and convenient way"
VERSION="1.5.7"
SOURCE="https://download.savannah.gnu.org/releases/libpipeline/libpipeline-${VERSION}.tar.gz"
CHECKSUM="1a48b5771b9f6c790fb4efdb1ac71342"
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
}

_test()
{
	make -j$(nproc) check
}
