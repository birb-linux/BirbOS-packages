NAME="intel-vaapi-driver"
DESC="VA-API user mode driver for Intel GEN Graphics family"
VERSION="2.4.1"
SOURCE="https://github.com/intel/intel-vaapi-driver/releases/download/${VERSION}/intel-vaapi-driver-${VERSION}.tar.bz2"
CHECKSUM="073fce0f409559109ad2dd0a6531055d"
DEPS="libva"
FLAGS=""
NOTES="To remove this driver, you need to uninstall libva"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
