NAME="ppsspp"
DESC="A PSP emulator"
VERSION="1.16.2"
SOURCE="https://github.com/hrydgard/ppsspp/releases/download/v${VERSION}/ppsspp-${VERSION}.tar.xz"
CHECKSUM="e7bb4ead6f7c0855a1390b3dcc478d30"
DEPS="snappy glu curl fontconfig sdl2 libzip libpng"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Build the bundled ffmpeg version
	cd ffmpeg
	./linux_x86-64.sh
	cd ..

	mkdir build
	cd    build

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DUSE_SYSTEM_FFMPEG=Off -DUSE_SYSTEM_LIBZIP=On -DUSE_SYSTEM_LIBSDL2=On -DUSE_SYSTEM_LIBPNG=On -DUSE_SYSTEM_ZSTD=On
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
