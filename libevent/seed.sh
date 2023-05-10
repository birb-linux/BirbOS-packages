NAME="libevent"
DESC="asynchronous event notification software library"
VERSION="2.1.12-stable"
SOURCE="https://github.com/libevent/libevent/releases/download/release-${VERSION}/libevent-${VERSION}.tar.gz"
CHECKSUM="b5333f021f880fe76490d8a799cd79f4"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix an issue with event_rpcgen.py
	sed -i 's/python/&3/' event_rpcgen.py

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j$(nproc)
}

_install()
{
	make install
}

_test()
{
	make verify
}
