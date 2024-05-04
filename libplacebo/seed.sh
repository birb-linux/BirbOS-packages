NAME="libplacebo"
DESC="Library for processing image and video primitives and shaders"
VERSION="6.338.2"
SOURCE="https://github.com/haasn/libplacebo/archive/refs/tags/v${VERSION}/libplacebo-${VERSION}.tar.gz"
CHECKSUM="4f5b743ec43c684e6da0d56efed3891c"
DEPS="ffmpeg glad glslang meson"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson setup ..            \
		  --prefix=/usr       \
		  --buildtype=release \
		  -Dtests=true        \
		  -Dvulkan=disabled   \
		  -Ddemos=false

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_test()
{
	ninja test
}
