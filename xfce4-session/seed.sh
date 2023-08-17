NAME="xfce4-session"
DESC="Session manager for Xfce"
VERSION="4.18.1"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://archive.xfce.org/src/xfce/xfce4-session/${SHORT_VERSION}/xfce4-session-${VERSION}.tar.bz2"
CHECKSUM="3f6e20b6f528adcd62085dce7a153297"
DEPS="libwnck libxfce4ui xfdesktop"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr     \
				--sysconfdir=/etc \
				--disable-legacy-sm

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
