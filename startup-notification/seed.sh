NAME="startup-notification"
DESC="Contains libraries for building a consistent manner to notify the user through the cursor that the application is loading"
VERSION="0.12"
SOURCE="https://www.freedesktop.org/software/startup-notification/releases/startup-notification-${VERSION}.tar.gz"
CHECKSUM="2cd77326d4dcaed9a5a23a1232fb38e9"
DEPS="xorg-libs xcb-util"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${MAKEOPTS}
}

_install()
{
	make install
	install -v -m644 -D doc/startup-notification.txt \
		$FAKEROOT/$NAME/usr/share/doc/startup-notification-${VERSION}/startup-notification.txt
}
