NAME="vulkan-headers"
DESC="Vulkan header files and API registry"
VERSION="1.3.261"
SOURCE="https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="58ca8e891dd68aa3afc5ea18f9d64aa8"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd Vulkan-Headers-${VERSION}
}

_build()
{
	cmake -S . -B build/
}

_install()
{
	cmake --install build --prefix $FAKEROOT/$NAME/usr
}
