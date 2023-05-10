NAME="linux-pam"
DESC="Pluggable Authentication Modules"
VERSION="1.5.2"
SOURCE="https://github.com/linux-pam/linux-pam/releases/download/v${VERSION}/Linux-PAM-${VERSION}.tar.xz"
CHECKSUM="895e8adfa14af334f679bbeb28503f66"
DEPS="shadow"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Prevent the installation of an unneeded systemd file
	sed -e /service_DATA/d \
		-i modules/pam_namespace/Makefile.am

	autoreconf

	./configure --prefix=$FAKEROOT/$NAME/usr     \
            --sbindir=$FAKEROOT/$NAME/usr/sbin   \
            --sysconfdir=/etc                    \
            --libdir=$FAKEROOT/$NAME/usr/lib     \
            --enable-securedir=/usr/lib/security \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/Linux-PAM-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
	chmod -v 4755 $FAKEROOT/$NAME/usr/sbin/unix_chkpwd

	# Generate some generic configuration files
	install -vdm755 /etc/pam.d

	if [ ! -f /etc/pam.d/system-account ]
	then
		cat > /etc/pam.d/system-account << "EOF"
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF
	fi

	if [ ! -f /etc/pam.d/system-auth ]
	then
		cat > /etc/pam.d/system-auth << "EOF"
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF
	fi

	if [ ! -f /etc/pam.d/system-session ]
	then
		cat > /etc/pam.d/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF
	fi

	if [ ! -f /etc/pam.d/system-password ]
	then
		cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use sha512 hash for encryption, use shadow, and try to use any previously
# defined authentication token (chosen password) set by any prior module.
# Use the same number of rounds as shadow.
password  required    pam_unix.so       sha512 shadow try_first_pass \
                                        rounds=500000

# End /etc/pam.d/system-password
EOF
	fi


	if [ ! -f /etc/pam.d/other ]
	then
		# Create a restrictive /etc/pam.d/other file
		cat > /etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth        required        pam_warn.so
auth        required        pam_deny.so
account     required        pam_warn.so
account     required        pam_deny.so
password    required        pam_warn.so
password    required        pam_deny.so
session     required        pam_warn.so
session     required        pam_deny.so

# End /etc/pam.d/other
EOF
	fi

	read -p "NOTE: To finish the installation of linux-pam, you must reinstall the [shadow] package! Hit ENTER to continue"
}

_test()
{
	install -v -m755 -d /etc/pam.d

	# Create the /etc/pam.d/other file if it doesn't exist
	if [ ! -f /etc/pam.d/other ]
	then
		cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF

		make -j${MAKEOPTS} check

		rm -fv /etc/pam.d/other
	else
		# Run the tests with the existing /etc/pam.d/other file
		make -j${MAKEOPTS} check
	fi
}
