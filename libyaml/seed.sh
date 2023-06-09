NAME="libyaml"
DESC="C library for parsing and emitting YAML code"
VERSION="0.2.5"
SOURCE="https://github.com/yaml/libyaml/releases/download/${VERSION}/yaml-${VERSION}.tar.gz"
CHECKSUM="bb15429d8fb787e7d3f1c83ae129a999"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd yaml-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}
