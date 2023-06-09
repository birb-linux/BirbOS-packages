NAME="nvidia-cuda-toolkit"
DESC="GPU-accelerated libraries, a compiler, development tools and the CUDA runtime"
VERSION="12.1.1"
NVIDIA_DRIVER_VERSION="530.30.02"
SOURCE="https://developer.download.nvidia.com/compute/cuda/${VERSION}/local_installers/cuda_${VERSION}_${NVIDIA_DRIVER_VERSION}_linux.run"
CHECKSUM="2f0a4127bf797bf4eab0be2a547cb8d0"
DEPS="nvidia-drivers which mofed"
FLAGS="wip proprietary"

_setup()
{
	chmod +x $DISTFILES/$(basename $SOURCE)

	# Check if X is running
	if [ -n "$(pgrep -x Xorg)" ]
	then
		echo "This package can only be installed in the TTY. Please close Xorg before proceeding"
		exit 1
	fi
}

_build()
{
	printf "Proprietary blob, nothing to build...\n"
}

_install()
{
	mkdir -p $FAKEROOT/$NAME/usr/local/cuda-${VERSION}
	$DISTFILES/$(basename $SOURCE) --installpath=$FAKEROOT/$NAME/usr/local/cuda-${VERSION} --silent --kernelobjects --toolkit --kernel-source-path=/usr/src/linux
}
