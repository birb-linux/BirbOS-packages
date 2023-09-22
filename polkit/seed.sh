NAME="polkit"
DESC="Toolkit for defining and handling authorizations"
VERSION="122"
SOURCE="https://gitlab.freedesktop.org/polkit/polkit/-/archive/${VERSION}/polkit-${VERSION}.tar.gz"
CHECKSUM="bbe3e745fc5bc1a41f1b5044f09a0f26"
DEPS="glib duktape linux-pam gobject-introspection meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Polkit needs its own user
	set +e
	groupadd -fg 27 polkitd
	useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 \
			-g polkitd -s /bin/false polkitd
	set -e

	mkdir build
	cd    build

	meson --prefix=$FAKEROOT/$NAME/usr  \
		  --buildtype=release           \
		  -Dman=false                   \
		  -Dsession_tracking=libelogind \
		  -Dsystemdsystemunitdir=/tmp   \
		  -Dtests=false                 \
		  -Djs_engine=duktape           \
		  ..

	ninja

	# Configure linux-pam
	mkdir -p $FAKEROOT/$NAME/etc/pam.d
	cat > $FAKEROOT/$NAME/etc/pam.d/polkit-1 << "EOF"
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF
}

_install()
{
	ninja install
	rm -v /tmp/*.service
}
