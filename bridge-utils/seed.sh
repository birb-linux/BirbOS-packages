NAME="bridge-utils"
DESC="A utility needed to create and manage bridge devices. Useful for setting up networks for a hosted virtual machine"
VERSION="1.7.1"
SOURCE="https://www.kernel.org/pub/linux/utils/net/bridge-utils/bridge-utils-${VERSION}.tar.xz"
CHECKSUM="3e1fee4dc22cac5457c2f6ffb990a518"
DEPS="bridge-bootscript"
FLAGS=""
NOTES="Configure the network device you want to use by editing /etc/sysconfig/ifconfig.br0"

_setup()
{
	kernel_check "CONFIG_NET CONFIG_BRIDGE"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	autoconf
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
