# shellcheck disable=SC2034
NAME="vulkan-loader"
DESC="Vulkan Loader"
VERSION="1.3.283"
SOURCE="https://github.com/KhronosGroup/Vulkan-Loader/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="b33487f0426dbfffbdc0b2118e3b3e6c"
DEPS="libx11 libxcb libxkbcommon wayland libxrandr"
FLAGS="32bit"

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "Vulkan-Loader-${VERSION}" || exit 1
}

_build()
{
	mkdir build
	cd    build || exit 1

	cmake -DUPDATE_DEPS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ..

	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}

_build32()
{
	cd ..
	rm -r build
	mkdir build
	cd build || exit 1

	ASFLAGS="--32" LDFLAGS="-L/usr/lib32" CC="gcc -m32" CXX="g++ -m32" cmake \
		-DUPDATE_DEPS=ON \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DUSE_GAS=OFF \
		..

	make -j "${BUILD_JOBS}"
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib/* "$FAKEROOT/$NAME/usr/lib32"
	rm -rf DESTDIR
}
