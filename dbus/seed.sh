NAME="dbus"
DESC="Message bus system"
VERSION="1.14.6"
SOURCE="https://dbus.freedesktop.org/releases/dbus/dbus-${VERSION}.tar.xz"
CHECKSUM="e809d7aa905ad82adeaf1d59db5445b1"
DEPS="dbus-daemon"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr     \
            --sysconfdir=/etc                    \
            --localstatedir=/var                 \
            --runstatedir=/run                   \
            --enable-user-session                \
            --disable-doxygen-docs               \
            --disable-xml-docs                   \
            --disable-static                     \
            --with-systemduserunitdir=no         \
            --with-systemdsystemunitdir=no       \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/dbus-${VERSION} \
            --with-system-socket=/run/dbus/system_bus_socket

	make -j${MAKEOPTS}
}

_install()
{
	make install

	# Make it possible to compile stuff depending on dbus
	# whilst in chroot
	./tools/dbus-uuidgen --ensure

	# Create a symlink needed for elogind support
	ln -sfv /var/lib/dbus/machine-id /etc
}

_build32()
{
	make distclean

	./configure                                  \
            --sysconfdir=/etc                    \
            --localstatedir=/var                 \
            --runstatedir=/run                   \
            --enable-user-session                \
            --disable-doxygen-docs               \
            --disable-xml-docs                   \
            --disable-static                     \
            --with-systemduserunitdir=no         \
            --with-systemdsystemunitdir=no       \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/dbus-${VERSION} \
            --with-system-socket=/run/dbus/system_bus_socket

	make -j${MAKEOPTS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
