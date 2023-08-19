NAME="iptables"
DESC="Userspace command line program used to configure the Linux 2.4 and later kernel packet filtering ruleset"
VERSION="1.8.9"
SOURCE="https://www.netfilter.org/projects/iptables/files/iptables-${VERSION}.tar.xz"
CHECKSUM="ffa00f68d63e723c21b8a091c5c0271b"
DEPS=""
FLAGS=""

_setup()
{
	kernel_check "CONFIG_NET CONFIG_NETFILTER CONFIG_NETFILTER_ADVANCED CONFIG_NF_CONNTRACK CONFIG_NETFILTER_XTABLES CONFIG_NETFILTER_XT_TARGET_LOG CONFIG_IP_NF_IPTABLES"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr  \
            --disable-nftables \
            --enable-libipq

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Fix an absolute symlink
	ln -srfv $FAKEROOT/$NAME/usr/sbin/xtables-legacy-multi $FAKEROOT/$NAME/usr/bin/iptables-xml
}
