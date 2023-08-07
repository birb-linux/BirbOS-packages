NAME="libcap-pam"
DESC="Linux-PAM support for libcap"
VERSION="2.67"
SOURCE="https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${VERSION}.tar.xz"
CHECKSUM="06333f4301657298890fd8d6f1fb4793"
DEPS="linux-pam libcap"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libcap-${VERSION}
}

_build()
{
	make -C pam_cap
}

_install()
{
	mkdir -pv $FAKEROOT/$NAME/usr/lib/security
	mkdir -pv $FAKEROOT/$NAME/etc/security

	install -v -m755 pam_cap/pam_cap.so $FAKEROOT/$NAME/usr/lib/security
	install -v -m644 pam_cap/capability.conf $FAKEROOT/$NAME/etc/security

	# Configure pam
	if [ -z "$(grep "pam_cap.so" /etc/pam.d/system-auth)" ]
	then
		mv -v /etc/pam.d/system-auth{,.bak} &&
	cat > /etc/pam.d/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      optional    pam_cap.so
EOF
		tail -n +3 /etc/pam.d/system-auth.bak >> /etc/pam.d/system-auth
	fi
}
