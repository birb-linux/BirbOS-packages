NAME="tcl"
DESC="Tool Command Language, a robust general-purpose scripting language"
VERSION="8.6.13"
SOURCE="https://downloads.sourceforge.net/tcl/tcl${VERSION}-src.tar.gz"
CHECKSUM="0e4358aade2f5db8a8b6f2f6d9481ec2"
DEPS="zlib"
FLAGS="important test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}${VERSION}
}

_build()
{
	SRCDIR=$(pwd)
	cd unix
	./configure --prefix=$FAKEROOT/$NAME/usr \
				--mandir=$FAKEROOT/$NAME/usr/share/man

	make -j${BUILD_JOBS}

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
}

_test()
{
	# Run the tests
	make -j${BUILD_JOBS} test
}
