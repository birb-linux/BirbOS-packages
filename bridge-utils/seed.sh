NAME="bridge-utils"
DESC="A utility needed to create and manage bridge devices. Useful for setting up networks for a hosted virtual machine"
VERSION="1.7.1"
SOURCE="https://www.kernel.org/pub/linux/utils/net/bridge-utils/bridge-utils-${VERSION}.tar.xz"
CHECKSUM="3e1fee4dc22cac5457c2f6ffb990a518"
DEPS=""
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

	# Create the default configuration file
	mkdir -p $FAKEROOT/$NAME/etc/sysconfig
	cat > $FAKEROOT/$NAME/etc/sysconfig/ifconfig.br0 << "EOF"
#ONBOOT=yes
#IFACE=br0
#VIRTINT=yes
#SERVICE="bridge ipv4-static"  # Space separated
#IP=192.168.1.32
#GATEWAY=192.168.1.1
#PREFIX=24
#BROADCAST=192.168.1.255
#CHECK_LINK=no                 # Don't check before bridge is created
#STP=no                        # Spanning tree protocol, default no
#INTERFACE_COMPONENTS="eth0"   # Add to IFACE, space separated devices
#IP_FORWARD=true
EOF
}
