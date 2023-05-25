NAME="jansson"
DESC="Library used to encode, decode, and manipulate JSON data"
VERSION="2.14"
SOURCE="https://github.com/akheron/jansson/releases/download/v${VERSION}/jansson-${VERSION}.tar.bz2"
CHECKSUM="3f90473d7d54ebd1cb6a2757396641df"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix one of the tests
	sed -e "/DT/s;| sort;| sed 's/@@libjansson.*//' &;" \
		-i test/suites/api/check-exports

	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME/usr install
}

_test()
{
	make -j${BUILD_JOBS} check
}
