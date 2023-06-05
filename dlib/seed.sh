NAME="dlib"
DESC="Modern C++ toolkit containing machine learning algorithms and tools for creating complex software in C++ to solve real world problems"
VERSION="19.24"
SOURCE="http://dlib.net/files/dlib-${VERSION}.tar.bz2"
CHECKSUM="8a98957a73eebd3cd7431c2bac79665f"
DEPS="libjpeg-turbo libpng libice libwebp openblas"
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

	cmake ..
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	if [ -n "$(birb_db --is-installed "nvidia-drivers")" == "yes" ]
	then
		if [ -n "$(birb_db --is-installed "nvidia-cuda-toolkit")" == "yes" ]
		then
			NOTES="The NVIDIA drivers seem to be installed, but you are missing the nvidia-cuda-toolkit package. If you need CUDA support, please install the nvidia-cuda-toolkit package and then reinstall this package"
		fi
	fi
}
