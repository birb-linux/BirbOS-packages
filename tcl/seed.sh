NAME="tcl"
DESC="Tool Command Language, a robust general-purpose scripting language"
VERSION="8.6.13"
SOURCE="https://downloads.sourceforge.net/tcl/tcl${VERSION}-html.tar.gz"
CHECKSUM="4452f2f6d557f5598cca17b786d6eb68"
DEPS="zlib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	SRCDIR=$(pwd)
	cd unix
	./configure --prefix=$FAKEROOT/$NAME/usr \
				--mandir=/usr/share/man

	make -j$(nproc)

	# Remove references to the build directory from the configuration files
	# and replace them with the install directory
	sed -e "s|$SRCDIR/unix|/usr/lib|" \
		-e "s|$SRCDIR|/usr/include|"  \
		-i tclConfig.sh

	sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.5|/usr/lib/tdbc1.1.5|" \
		-e "s|$SRCDIR/pkgs/tdbc1.1.5/generic|/usr/include|"    \
		-e "s|$SRCDIR/pkgs/tdbc1.1.5/library|/usr/lib/tcl8.6|" \
		-e "s|$SRCDIR/pkgs/tdbc1.1.5|/usr/include|"            \
		-i pkgs/tdbc1.1.5/tdbcConfig.sh

	sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.3|/usr/lib/itcl4.2.3|" \
		-e "s|$SRCDIR/pkgs/itcl4.2.3/generic|/usr/include|"    \
		-e "s|$SRCDIR/pkgs/itcl4.2.3|/usr/include|"            \
		-i pkgs/itcl4.2.3/itclConfig.sh

	unset SRCDIR

	# Run the tests
	make -j$(nproc) test
}

_install()
{
	make install

	# Make it possible to remove the debugging symbols later on
	chmod -v u+w $FAKEROOT/$NAME/usr/lib/libtcl8.6.so

	# Install headers that the expect package requires
	make install-private-headers

	ln -sfv tclsh8.6 $FAKEROOT/$NAME/usr/bin/tclsh

	# Avoid a man page name conflict with the perl package
	mv $FAKEROOT/$NAME/usr/share/man/man3/{Thread,Tcl_Thread}.3

	# Install documentation
	cd ..
	tar -xf ../tcl8.6.13-html.tar.gz --strip-components=1
	mkdir -v -p $FAKEROOT/$NAME/usr/share/doc/tcl-8.6.13
	cp -v -r  ./html/* $FAKEROOT/$NAME/usr/share/doc/tcl-8.6.13
}
