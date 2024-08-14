NAME="tcl"
DESC="Tool Command Language, a robust general-purpose scripting language"
VERSION="8.6.14"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://downloads.sourceforge.net/tcl/tcl${VERSION}-src.tar.gz"
CHECKSUM="c30b57c6051be28fa928d09aca82841e"
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

	readonly TDBC_VERSION="1.1.7"
	readonly ITCL_VERSION="4.2.4"

	sed -e "s|$SRCDIR/unix/pkgs/tdbc${TDBC_VERSION}|/usr/lib/tdbc${TDBC_VERSION}|" \
		-e "s|$SRCDIR/pkgs/tdbc${TDBC_VERSION}/generic|/usr/include|"    \
		-e "s|$SRCDIR/pkgs/tdbc${TDBC_VERSION}/library|/usr/lib/tcl${SHORT_VERSION}|" \
		-e "s|$SRCDIR/pkgs/tdbc${TDBC_VERSION}|/usr/include|"            \
		-i pkgs/tdbc${TDBC_VERSION}/tdbcConfig.sh

	sed -e "s|$SRCDIR/unix/pkgs/itcl${ITCL_VERSION}|/usr/lib/itcl${ITCL_VERSION}|" \
		-e "s|$SRCDIR/pkgs/itcl${ITCL_VERSION}/generic|/usr/include|"    \
		-e "s|$SRCDIR/pkgs/itcl${ITCL_VERSION}|/usr/include|"            \
		-i pkgs/itcl${ITCL_VERSION}/itclConfig.sh

	unset SRCDIR
}

_install()
{
	make install

	# Make it possible to remove the debugging symbols later on
	chmod -v u+w $FAKEROOT/$NAME/usr/lib/libtcl${SHORT_VERSION}.so

	# Install headers that the expect package requires
	make install-private-headers

	ln -sfv tclsh${SHORT_VERSION} $FAKEROOT/$NAME/usr/bin/tclsh

	# Avoid a man page name conflict with the perl package
	mv $FAKEROOT/$NAME/usr/share/man/man3/{Thread,Tcl_Thread}.3
}

_test()
{
	# Run the tests
	make -j${BUILD_JOBS} test
}
