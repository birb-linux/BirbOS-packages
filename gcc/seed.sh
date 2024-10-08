NAME="gcc"
DESC="GNU compiler collection, which includes the C and C++ compilers"
VERSION="14.1.0"
SOURCE="https://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.xz"
CHECKSUM="24195dca80ded5e0551b533f46a4481d"
DEPS="gmp mpfr mpc zlib"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}

	# Change the default directory name for 64-bit libraries to "lib"
	sed -e '/m64=/s/lib64/lib/' \
		-e '/m32=/s/m32=.*/m32=..\/lib32$(call if_multiarch,:i386-linux-gnu)/' \
		-i.orig gcc/config/i386/t-linux64
}

_build()
{
	disable_lto

	mkdir -v build
	cd       build

	multilib_args="--disable-multilib"
	if has_use "abi_x86_32"; then
	  multilib_args="--enable-multilib --with-multilib-list=m64,m32"
	fi
	../configure --prefix=/usr \
				 LD=ld                        \
				 --enable-languages=c,c++     \
				 --enable-default-pie         \
				 --enable-default-ssp         \
				 --disable-fixincludes        \
				 --disable-bootstrap          \
				 --with-system-zlib           \
				 ${multilib_args}

	make -j${BUILD_JOBS}
}

_test()
{
	# Ignore errors during the tests, because there are a few
	# known to fail for i386 architecture
	set +e

	ulimit -s 32768
	chown -Rv tester .
	su tester -c "PATH=$PATH make -j${BUILD_JOBS} -k check"

	# Extract summary of the test suite results
	../contrib/test_summary grep -A7 Summ
	set -e
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Symlink required by the FHS for "historical" reasons
	ln -sfvr $FAKEROOT/$NAME/usr/bin/cpp $FAKEROOT/$NAME/usr/lib

	# Compatibility symlink to enable building programs with LTO
	ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/${VERSION}/liblto_plugin.so \
        $FAKEROOT/$NAME/usr/lib/bfd-plugins/


	# Move a misplaced file
	mkdir -pv $FAKEROOT/$NAME/usr/share/gdb/auto-load/usr/lib
	mv -v $FAKEROOT/$NAME/usr/lib/*gdb.py $FAKEROOT/$NAME/usr/share/gdb/auto-load/usr/lib
}

_post_install()
{
	echo "Sanity checks are disabled temporarily"
	# # Perform a sanity check
	# echo "Peforming some sanity checks..."

	# echo 'int main(){}' > dummy.c
	# cc dummy.c -v -Wl,--verbose &> dummy.log
	# readelf -l a.out | grep ': /lib'

	# # Make sure that the start files exist
	# grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log

	# # Verify that the compiler is search for the correct header files
	# grep -B4 '^ /usr/include' dummy.log

	# # Verify that the new linker is being used with the correct search paths
	# grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

	# # Make sure that we're using the correct libc
	# grep "/lib.*/libc.so.6 " dummy.log

	# # Make sure GCC is using the correct dynamic linker
	# grep found dummy.log
}
