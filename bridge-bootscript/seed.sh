NAME="bridge-bootscript"
DESC="blfs-bootscript for automating bridge creation and configuration during boot"
VERSION="20230101"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-${VERSION}.tar.xz"
CHECKSUM="05d7f58fdcdcd0dcedd81086589222b9"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd blfs-bootscripts-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install-service-bridge

	# Avoid nuking the system
	mv $FAKEROOT/$NAME/lib/* $FAKEROOT/$NAME/usr/lib/

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
