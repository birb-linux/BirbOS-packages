NAME="fcron"
DESC="A periodical command scheduler which aims at replacing Vixie Cron"
VERSION="3.2.1"
SOURCE="http://fcron.free.fr/archives/fcron-${VERSION}.src.tar.gz"
CHECKSUM="bd4996e941a40327d11efc5e3fd1f839"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Make a necessary modification to the /etc/syslog.conf file, if it hasn't
	# already been done before
	if [ -z "$(grep "# Begin fcron addition to /etc/syslog.conf" /etc/syslog.conf)" ]
	then
		cat >> /etc/syslog.conf << "EOF"
# Begin fcron addition to /etc/syslog.conf

cron.* -/var/log/cron.log

# End fcron addition
EOF

		# Reload the sysklogd daemon
		/etc/rc.d/init.d/sysklogd reload
	fi

	# Create an unprivileged user and a group for fcron
	groupadd -g 22 fcron &&
	useradd -d /dev/null -c "Fcron User" -g fcron -s /bin/false -u 22 fcron

	# Fix some hard coded locations in the docs
	find doc -type f -exec sed -i 's:/usr/local::g' {} \;

	./configure --prefix=/usr \
            --sysconfdir=/etc      \
            --localstatedir=/var   \
            --without-sendmail     \
            --with-boot-install=no \
			--with-editor=/usr/bin/vim \
            --with-systemdsystemunitdir=no

	make -j${BUILD_JOBS}
}

_install()
{
	# Ensure that the pam configuration directory exists in the fakeroot
	mkdir -p $FAKEROOT/$NAME/etc/pam.d

	make DESTDIR=$FAKEROOT/$NAME install
}
