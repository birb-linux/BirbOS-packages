NAME="luajit"
DESC="Just-In-Time Compiler for Lua"
VERSION="2.0.5"
SOURCE="https://luajit.org/download/LuaJIT-${VERSION}.tar.gz"
CHECKSUM="48353202cbcacab84ee41a5a70ea0a2c"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd LuaJIT-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
