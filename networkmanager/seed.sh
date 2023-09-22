NAME="networkmanager"
DESC="Set of co-operative tools that make networking simple and straightforward"
VERSION="1.42.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/NetworkManager/${SHORT_VERSION}/NetworkManager-${VERSION}.tar.xz"
CHECKSUM="cfe8c33493d8d2a9d97415a7042a6fe2"
DEPS="jansson libndp curl gobject-introspection iptables newt nss polkit pygobject elogind upower vala wpa_supplicant meson ninja"
FLAGS=""
NOTES="Remember to add your normal user to the netdev group to use NetworkManager without root"

_setup()
{
	# FIXME: A kernel option CONFIG_VRF possibly required, but not found in menuconfig
	kernel_check "CONFIG_NET CONFIG_INET CONFIG_NET_IPIP CONFIG_NET_IPGRE_DEMUX CONFIG_NET_IPGRE CONFIG_IPV6 CONFIG_IPV6_SIT CONFIG_IPV6_GRE CONFIG_IPV6_MULTIPLE_TABLES CONFIG_MPTCP CONFIG_MPTCP_IPV6 CONFIG_VLAN_8021Q CONFIG_NET_SCHED CONFIG_NET_SCH_SFQ CONFIG_NET_SCH_TBF CONFIG_NET_SCH_FQ_CODEL CONFIG_NET_SCH_INGRESS CONFIG_NETDEVICES CONFIG_NET_CORE CONFIG_BONDING CONFIG_DUMMY CONFIG_NET_TEAM CONFIG_MACVLAN CONFIG_MACVTAP CONFIG_IPVLAN CONFIG_VXLAN CONFIG_VETH"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd NetworkManager-${VERSION}
}

_build()
{
	# Make sure the python scripts use python3
	grep -rl '^#!.*python$' | xargs sed -i '1s/python/&3/'

	mkdir build
	cd    build

	meson setup                      \
		  --prefix=/usr              \
		  --buildtype=release        \
		  -Dlibaudit=no              \
		  -Dlibpsl=false             \
		  -Dnmtui=true               \
		  -Dovs=false                \
		  -Dppp=false                \
		  -Dselinux=false            \
		  -Dsession_tracking=elogind \
		  -Dmodem_manager=false      \
		  -Dsystemdsystemunitdir=no  \
		  -Dsystemd_journal=false    \
		  -Dqt=false                 \
		  ..

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install

	# Install docs
	mv -v $FAKEROOT/$NAME/usr/share/doc/NetworkManager{,-${VERSION}}

	# Install pregenerated man-pages
	for file in $(echo ../man/*.[1578])
	do
		section=${file##*.} &&
		install -vdm 755 $FAKEROOT/$NAME/usr/share/man/man$section
		install -vm 644 $file $FAKEROOT/$NAME/usr/share/man/man$section/
	done

	# Create a minimal configuration
	mkdir -p $FAKEROOT/$NAME/etc/NetworkManager
	cat >> $FAKEROOT/$NAME/etc/NetworkManager/NetworkManager.conf << "EOF"
[main]
plugins=keyfile
EOF

	mkdir -p $FAKEROOT/$NAME/etc/NetworkManager/conf.d
	cat > $FAKEROOT/$NAME/etc/NetworkManager/conf.d/dhcp.conf << "EOF"
[main]
dhcp=dhclient
EOF

	# Prevent NetworkManager from tampering with the resolv.conf file
	cat > $FAKEROOT/$NAME/etc/NetworkManager/conf.d/no-dns-update.conf << "EOF"
[main]
dns=none
EOF

	# Create a netdev group if one doesn't already exist
	grep "netdev" /etc/group || groupadd -fg 86 netdev

	mkdir -p $FAKEROOT/$NAME/usr/share/polkit-1/rules.d
	cat > $FAKEROOT/$NAME/usr/share/polkit-1/rules.d/org.freedesktop.NetworkManager.rules << "EOF"
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("netdev")) {
        return polkit.Result.YES;
    }
});
EOF
}
