NAME="wpa_supplicant"
DESC="Wi-Fi Protected Access (WPA) client and IEEE 802.1X supplicant"
VERSION="2.10"
SOURCE="https://w1.fi/releases/wpa_supplicant-${VERSION}.tar.gz"
CHECKSUM="d26797fcb002898d4ee989179346e1cc"
DEPS="libnl dbus libxml2"
FLAGS=""

_setup()
{
	kernel_check "CONFIG_NET CONFIG_WIRELESS CONFIG_CFG80211 CONFIG_CFG80211_WEXT CONFIG_MAC80211 CONFIG_NETDEVICES CONFIG_WLAN"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Create the base build config
	cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
EOF

	# Add a few more options to make wpa_supplicant usable with NetworkManager
	cat >> wpa_supplicant/.config << "EOF"
CONFIG_CTRL_IFACE_DBUS=y
CONFIG_CTRL_IFACE_DBUS_NEW=y
CONFIG_CTRL_IFACE_DBUS_INTRO=y
EOF

	cd wpa_supplicant &&
	make BINDIR=/usr/sbin LIBDIR=/usr/lib -j${BUILD_JOBS}
}

_install()
{
	# Install wpa_supplicant
	install -v -m755 wpa_{cli,passphrase,supplicant} $FAKEROOT/$NAME/usr/sbin/
	install -v -m644 doc/docbook/wpa_supplicant.conf.5 $FAKEROOT/$NAME/usr/share/man/man5/
	install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 $FAKEROOT/$NAME/usr/share/man/man8/

	# Install dbus configuration files
	mkdir -p $FAKEROOT/$NAME/usr/share/dbus-1/system-services
	install -v -m644 dbus/fi.w1.wpa_supplicant1.service \
                 $FAKEROOT/$NAME/usr/share/dbus-1/system-services/
	install -v -d -m755 $FAKEROOT/$NAME/etc/dbus-1/system.d
	install -v -m644 dbus/dbus-wpa_supplicant.conf \
					 $FAKEROOT/$NAME/etc/dbus-1/system.d/wpa_supplicant.conf
}
