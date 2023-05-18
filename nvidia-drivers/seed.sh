NAME="nvidia-drivers"
DESC="Proprietary nvidia drivers"
VERSION="530.41.03"
SOURCE="https://us.download.nvidia.com/XFree86/Linux-x86_64/${VERSION}/NVIDIA-Linux-x86_64-${VERSION}.run"
CHECKSUM="9049dbe01410eac1e05b249de10f6b91"
DEPS=""
FLAGS=""

_setup()
{
	chmod +x $DISTFILES/$(basename $SOURCE)
	$DISTFILES/$(basename $SOURCE) -x
	cd NVIDIA-Linux-x86_64-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	./nvidia-installer --no-questions
}
