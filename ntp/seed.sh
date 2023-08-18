NAME="ntp"
DESC="Client and server to keep the time synchronized between various computers over a network"
VERSION="4.2.8p15"
MAJOR_VERSION="$(major_version $VERSION)"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://www.eecis.udel.edu/~ntp/ntp_spool/ntp${MAJOR_VERSION}/ntp-${SHORT_VERSION}/ntp-${VERSION}.tar.gz"
CHECKSUM="e1e6b23d2fc75cced41801dbcd6c2561"
DEPS="io-socket-ssl libcap libevent"
FLAGS=""
NOTES="You can run 'ntpd -q' in the root crontab if you want to keep the clock up-to-date"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Createa dedicated user for ntp
	groupadd -g 87 ntp &&
	useradd -c "Network Time Protocol" -d /var/lib/ntp -u 87 \
			-g ntp -s /bin/false ntp

	# Fix an issue with the update-leap command
	sed -e 's/"(\\S+)"/"?([^\\s"]+)"?/' \
		-i scripts/update-leap/update-leap.in

	# Fix an issue introduced with glibc-2.34
	sed -e 's/#ifndef __sun/#if !defined(__sun) \&\& !defined(__GLIBC__)/' \
		-i libntp/work_thread.c


	./configure --prefix=$FAKEROOT/$NAME/usr         \
            --bindir=$FAKEROOT/$NAME/usr/sbin    \
            --sysconfdir=/etc     \
            --enable-linuxcaps    \
            --with-lineeditlibs=readline \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/ntp-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	install -v -o ntp -g ntp -d /var/lib/ntp

	# Configure ntp
	cat > $FAKEROOT/$NAME/etc/ntp.conf << "EOF"
# Asia
server 0.asia.pool.ntp.org

# Australia
server 0.oceania.pool.ntp.org

# Europe
server 0.europe.pool.ntp.org

# North America
server 0.north-america.pool.ntp.org

# South America
server 2.south-america.pool.ntp.org

driftfile /var/lib/ntp/ntp.drift
pidfile   /run/ntpd.pid

leapfile  /var/lib/ntp/ntp.leapseconds
EOF

	# Add a "security session"
	cat >> $FAKEROOT/$NAME/etc/ntp.conf << "EOF"
# Security session
restrict    default limited kod nomodify notrap nopeer noquery
restrict -6 default limited kod nomodify notrap nopeer noquery

restrict 127.0.0.1
restrict ::1
EOF
}
