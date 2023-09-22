NAME="elogind"
DESC="systemd project's 'logind', extracted to be a standalone daemon"
VERSION="246.10"
SOURCE="https://github.com/elogind/elogind/archive/v${VERSION}/elogind-${VERSION}.tar.gz"
CHECKSUM="32ab2201281f14738d9c045f3669c14d"
DEPS="dbus linux-pam eudev meson ninja"
FLAGS="32bit test"

_setup()
{
	# Make sure that the kernel is compatible
	kernel_check "CONFIG_CGROUPS CONFIG_INOTIFY_USER CONFIG_TMPFS_POSIX_ACL"

	# Some extra options if running tests
	if [ "$ENABLE_TESTS" == "yes" ]
	then
		kernel_check "CONFIG_CRYPTO CONFIG_CRYPTO_USER CONFIG_CRYPTO_USER_API_HASH"
	fi

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Polkit is a runtime dependency, so it doesn't have to be installed yet
	sed -i '/Disable polkit/,+8 d' meson.build

	sed '/request_name/i\
	r = sd_bus_set_exit_on_disconnect(m->bus, true);\
	if (r < 0)\
		return log_error_errno(r, "Failed to set exit on disconnect: %m");' \
		-i src/login/logind.c &&

	mkdir build
	cd    build

	meson --prefix=$FAKEROOT/$NAME/usr         \
          --bindir=$FAKEROOT/$NAME/usr/bin     \
		  --buildtype=release                  \
		  -Dcgroup-controller=elogind          \
		  -Ddbuspolicydir=/etc/dbus-1/system.d \
		  -Dman=false                          \
		  ..
	ninja
}

_install()
{
	ninja install
	ln -sfv  libelogind.pc $FAKEROOT/$NAME/usr/lib/pkgconfig/libsystemd.pc
	ln -sfvn elogind $FAKEROOT/$NAME/usr/include/systemd

	# Configure pam
	cat >> /etc/pam.d/system-session << "EOF" &&
# Begin elogind addition

session  required    pam_loginuid.so
session  optional    pam_elogind.so

# End elogind addition
EOF

	# Remove any existing elogind rules
	rm -fv /etc/pam.d/elogind-user

	mkdir -p $FAKEROOT/$NAME/etc/pam.d
	cat > $FAKEROOT/$NAME/etc/pam.d/elogind-user << "EOF"
# Begin /etc/pam.d/elogind-user

account  required    pam_access.so
account  include     system-account

session  required    pam_env.so
session  required    pam_limits.so
session  required    pam_unix.so
session  required    pam_loginuid.so
session  optional    pam_keyinit.so force revoke
session  optional    pam_elogind.so

auth     required    pam_deny.so
password required    pam_deny.so

# End /etc/pam.d/elogind-user
EOF

	println "Clawing some escaped elogind files back into the fakeroot..."
	#mv -v /lib/elogind $FAKEROOT/$NAME/lib/
	#mv -v /etc/elogind $FAKEROOT/$NAME/etc/
	#mv -v /usr/lib/libelogind.so* $FAKEROOT/$NAME/lib/
	#mv -v /usr/bin/{elogind-inhibit,loginctl} $FAKEROOT/$NAME/usr/bin/
}

_test()
{
	ninja test
}

_build32()
{
	cd ..
	rm -r build
	mkdir build
	cd    build

	meson --prefix=$FAKEROOT/$NAME/usr         \
          --bindir=$FAKEROOT/$NAME/usr/bin     \
		  --buildtype=release                  \
		  -Dcgroup-controller=elogind          \
		  -Ddbuspolicydir=/etc/dbus-1/system.d \
		  -Dman=false                          \
		  ..
	ninja
}

_install32()
{
	DESTDIR=$PWD/DESTDIR ninja install
	cp -Rv DESTDIR/usr/lib/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
