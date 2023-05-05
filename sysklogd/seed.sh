NAME="sysklogd"
DESC="Programs for logging system messages"
VERSION="1.5.1"
SOURCE="https://www.infodrom.org/projects/sysklogd/download/sysklogd-${VERSION}.tar.gz"
CHECKSUM="c70599ab0d037fde724f7210c2c8d7f8"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a problem that causes a segfault in some conditions
	# Also fix an obsolete program construct
	sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
	sed -i 's/union wait/int/' syslogd.c

	make -j$(nproc)
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr BINDIR=$FAKEROOT/$NAME/sbin install

	# Do some basic configuration
	cat > $FAKEROOT/$NAME/etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF
}
