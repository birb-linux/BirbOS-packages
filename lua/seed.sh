NAME="lua"
DESC="Powerful light-weight programming language"
VERSION="5.4.4"
SOURCE="https://www.lua.org/ftp/lua-${VERSION}.tar.gz"
CHECKSUM="bd8ce7069ff99a400efd14cf339a727b"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Create a pkg-config file
	cat > lua.pc << "EOF"
V=5.4
R=5.4.4

prefix=/usr
INSTALL_BIN=${prefix}/bin
INSTALL_INC=${prefix}/include
INSTALL_LIB=${prefix}/lib
INSTALL_MAN=${prefix}/share/man/man1
INSTALL_LMOD=${prefix}/share/lua/${V}
INSTALL_CMOD=${prefix}/lib/lua/${V}
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: Lua
Description: An Extensible Extension Language
Version: ${R}
Requires:
Libs: -L${libdir} -llua -lm -ldl
Cflags: -I${includedir}
EOF

	patch -Np1 -i $PKG_PATH/lua-5.4.4-shared_library-2.patch

	make -j${MAKEOPTS} linux
}

_install()
{
	VERSION_SHORT="$(echo "${VERSION}" | awk -F'.' '{print $1 "." $2}')"

	make INSTALL_TOP=$FAKEROOT/$NAME/usr \
     INSTALL_DATA="cp -d"                \
     INSTALL_MAN=$FAKEROOT/$NAME/usr/share/man/man1 \
     TO_LIB="liblua.so liblua.so.${VERSION_SHORT} liblua.so.${VERSION}" \
     install

	mkdir -pv                      $FAKEROOT/$NAME/usr/share/doc/lua-${VERSION}
	cp -v doc/*.{html,css,gif,png} $FAKEROOT/$NAME/usr/share/doc/lua-${VERSION}

	install -v -m644 -D lua.pc $FAKEROOT/$NAME/usr/lib/pkgconfig/lua.pc
}
