NAME="qt5"
DESC="Cross-platform application framework"
VERSION="5.15.8"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.qt.io/archive/qt/${SHORT_VERSION}/${VERSION}/single/qt-everywhere-opensource-src-${VERSION}.tar.xz"
CHECKSUM="86b7b496735df3973a390b0d515c1a0f"
DEPS="xorg-libs alsa-lib make-ca double-conversion glib gst-plugins-base harfbuzz icu jasper libjpeg-turbo libmng libpng libtiff libwebp libxkbcommon mesa mtdev pcre2 sqlite wayland xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd qt-everywhere-src-${VERSION}
}

_build()
{
	export QT5PREFIX=/usr
	export QT5BINDIR=$QT5PREFIX/bin

	# Apply a patch curated by KDE
	patch -Np1 -i $PKG_PATH/qt-everywhere-opensource-src-5.15.8-kf5-1.patch

	# The patch is supposed to be used in a git directory
	mkdir -pv qtbase/.git

	./configure -prefix $QT5PREFIX                      \
            -sysconfdir /etc/xdg                        \
            -confirm-license                            \
            -opensource                                 \
            -dbus-linked                                \
            -openssl-linked                             \
            -system-harfbuzz                            \
            -system-sqlite                              \
            -nomake examples                            \
            -no-rpath                                   \
            -syslog                                     \
            -skip qtwebengine                           \
			-archdatadir    /usr/lib/qt5                \
            -bindir         /usr/bin                    \
            -plugindir      /usr/lib/qt5/plugins        \
            -importdir      /usr/lib/qt5/imports        \
            -headerdir      /usr/include/qt5            \
            -datadir        /usr/share/qt5              \
            -docdir         /usr/share/doc/qt5          \
            -translationdir /usr/share/qt5/translations \
            -examplesdir    /usr/share/doc/qt5/examples

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Remove references to the build directory
	find $FAKEROOT/$NAME/$QT5PREFIX/ -name \*.prl \
	   -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \;


	# Make QT5DIR available to the super user
	mkdir -p $FAKEROOT/$NAME/etc/sudoers.d
	cat > $FAKEROOT/$NAME/etc/sudoers.d/qt << "EOF"
Defaults env_keep += QT5DIR
EOF

	# Some applications look for the binaries with -qt5 suffix
	for file in moc uic rcc qmake lconvert lrelease lupdate; do
		ln -sfrvn $QT5BINDIR/$file $FAKEROOT/$NAME/usr/bin/$file-qt5
	done

	# Let packages know where to find qt5
	mkdir -p $FAKEROOT/$NAME/etc/profile.d
	cat > $FAKEROOT/$NAME/etc/profile.d/qt5.sh << "EOF"
# Begin /etc/profile.d/qt5.sh

QT5DIR=/usr
export QT5DIR
pathappend $QT5DIR/bin

# End /etc/profile.d/qt5.sh
EOF
}
