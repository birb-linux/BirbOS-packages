NAME="sudo"
DESC="Allows users or groups to run commands as other users"
VERSION="1.9.15p5"
SOURCE="https://www.sudo.ws/dist/sudo-${VERSION}.tar.gz"
CHECKSUM="4166279cb188ecb6641c7a2ba5f68270"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --libexecdir=/usr/lib      \
            --with-secure-path         \
            --with-all-insults         \
            --with-env-editor          \
            --without-pam              \
            --docdir=/usr/share/doc/sudo-${VERSION} \
            --with-passprompt="[sudo] password for %p: "

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	ln -sfv libsudo_util.so.0.0.0 $FAKEROOT/$NAME/usr/lib/sudo/libsudo_util.so.0

	# Allow the members of the wheel group to run commands as the root user
	mkdir -p $FAKEROOT/$NAME/etc/sudoers.d
	cat > $FAKEROOT/$NAME/etc/sudoers.d/00-sudo << "EOF"
Defaults secure_path="/usr/sbin:/usr/bin"
%wheel ALL=(ALL) ALL
EOF

	# Create a default config file for linux-pam, in case its installed
	mkdir -p $FAKEROOT/$NAME/etc/pam.d
	cat > $FAKEROOT/$NAME/etc/pam.d/sudo << "EOF"
# Begin /etc/pam.d/sudo

# include the default auth settings
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/sudo
EOF
	chmod 644 $FAKEROOT/$NAME/etc/pam.d/sudo
}

_test()
{
	env LC_ALL=C make check 2>&1 | tee make-check.log
}
