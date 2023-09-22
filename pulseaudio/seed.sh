NAME="pulseaudio"
DESC="Sound system for POSIX OSes"
VERSION="16.1"
SOURCE="https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-${VERSION}.tar.xz"
CHECKSUM="2c7b8ceb5d7337565c7314b4d6087ca8"
DEPS="libsndfile alsa-lib dbus elogind glib speex xorg-libs meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=/usr       \
		  --buildtype=release \
		  -Ddatabase=gdbm     \
		  -Ddoxygen=false     \
		  -Dbluez5=disabled   &&
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install

	# Stowing /lib will nuke the system, so use /usr/lib instead
	mv -v $FAKEROOT/$NAME/lib/udev $FAKEROOT/$NAME/usr/lib/

	# Avoid running pulseaudio as a system-wide daemon
	rm -fv $FAKEROOT/$NAME/etc/dbus-1/system.d/pulseaudio-system.conf
}
