NAME="glibc"
DESC="The main C library"
VERSION="2.37"
SOURCE="https://ftp.gnu.org/gnu/glibc/glibc-${VERSION}.tar.xz"
CHECKSUM="e89cf3dcb64939d29f04b4ceead5cc4e"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	FAKEROOT_PREFIX="$FAKEROOT/$NAME"

	patch -Np1 -i /var/db/pkg/${NAME}/glibc-2.37-fhs-1.patch

	# Fix some security issue
	sed '/width -=/s/workend - string/number_length/' \
    -i stdio-common/vfprintf-process-arg.c

	mkdir -v build
	cd       build

	echo "rootsbindir=/usr/sbin" > configparms

	../configure --prefix=$FAKEROOT_PREFIX/usr        \
             --disable-werror                         \
             --enable-kernel=3.2                      \
             --enable-stack-protector=strong          \
             --with-headers=/usr/include              \
             --enable-multi-arch                      \
             libc_cv_slibdir=/usr/lib

	make -j$(nproc)

	# Prevent a warning that might happen during glibc install
	mkdir -p $FAKEROOT_PREFIX/etc
	touch $FAKEROOT_PREFIX/etc/ld.so.conf

	# Skip a sanity check that will fail in the partial LFS environment
	sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile
}

_install()
{
	make install

	# Fix a hardcoded path to the executable loader in the ldd script
	sed '/RTLDLIST=/s@/usr@@g' -i $FAKEROOT_PREFIX/usr/bin/ldd

	# Install the configuration file and runtime dir for nscd
	cp -v ../nscd/nscd.conf $FAKEROOT_PREFIX/etc/nscd.conf
	mkdir -pv $FAKEROOT_PREFIX/var/cache/nscd

	# Generate the minimum amount of locales needed
	echo "Generating locales... This part can't be reversed when uninstalling glibc (not that you'd do that anyway :/)"
	mkdir -pv /usr/lib/locale
	localedef -i POSIX -f UTF-8 C.UTF-8 2> /dev/null || true
	localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
	localedef -i de_DE -f ISO-8859-1 de_DE
	localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
	localedef -i de_DE -f UTF-8 de_DE.UTF-8
	localedef -i el_GR -f ISO-8859-7 el_GR
	localedef -i en_GB -f ISO-8859-1 en_GB
	localedef -i en_GB -f UTF-8 en_GB.UTF-8
	localedef -i en_HK -f ISO-8859-1 en_HK
	localedef -i en_PH -f ISO-8859-1 en_PH
	localedef -i en_US -f ISO-8859-1 en_US
	localedef -i en_US -f UTF-8 en_US.UTF-8
	localedef -i es_ES -f ISO-8859-15 es_ES@euro
	localedef -i es_MX -f ISO-8859-1 es_MX
	localedef -i fa_IR -f UTF-8 fa_IR
	localedef -i fr_FR -f ISO-8859-1 fr_FR
	localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
	localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
	localedef -i is_IS -f ISO-8859-1 is_IS
	localedef -i is_IS -f UTF-8 is_IS.UTF-8
	localedef -i it_IT -f ISO-8859-1 it_IT
	localedef -i it_IT -f ISO-8859-15 it_IT@euro
	localedef -i it_IT -f UTF-8 it_IT.UTF-8
	localedef -i ja_JP -f EUC-JP ja_JP
	localedef -i ja_JP -f SHIFT_JIS ja_JP.SJIS 2> /dev/null || true
	localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
	localedef -i nl_NL@euro -f ISO-8859-15 nl_NL@euro
	localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
	localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
	localedef -i se_NO -f UTF-8 se_NO.UTF-8
	localedef -i ta_IN -f UTF-8 ta_IN.UTF-8
	localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
	localedef -i zh_CN -f GB18030 zh_CN.GB18030
	localedef -i zh_HK -f BIG5-HKSCS zh_HK.BIG5-HKSCS
	localedef -i zh_TW -f UTF-8 zh_TW.UTF-8

	# Install ALL of the locales. This could be optimized
	# a bit to save time, but this will do for now ;)
	make localedata/install-locales

	# Create two locales that aren't listed in the glibc localedata supported list
	localedef -i POSIX -f UTF-8 C.UTF-8 2> /dev/null || true
	localedef -i ja_JP -f SHIFT_JIS ja_JP.SJIS 2> /dev/null || true

	cat > $FAKEROOT_PREFIX/etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

	echo "Installing timezone data. This part also can't be reversed (and probably shouldn't be)"
	tar -xf ../../tzdata2023c.tar.gz

	ZONEINFO=/usr/share/zoneinfo
	mkdir -pv $ZONEINFO/{posix,right}

	for tz in etcetera southamerica northamerica europe africa antarctica  \
			  asia australasia backward; do
		zic -L /dev/null   -d $ZONEINFO       ${tz}
		zic -L /dev/null   -d $ZONEINFO/posix ${tz}
		zic -L leapseconds -d $ZONEINFO/right ${tz}
	done

	cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
	zic -d $ZONEINFO -p America/New_York
	unset ZONEINFO

	echo "Pick a timezone"
	TIMEZONE="$(tzselect)"
	ln -sfv /usr/share/zoneinfo/$TIMEZONE /etc/localtime

	# Create the ld.so.conf file
	cat > $FAKEROOT_PREFIX/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

	# Now build for 32bit
	rm -rf ./*
	find .. -name "*.a" -delete

	CC="gcc -m32" CXX="g++ -m32" \
	../configure                             \
		  --prefix=$FAKEROOT_PREFIX/usr      \
		  --host=i686-pc-linux-gnu           \
		  --build=$(../scripts/config.guess) \
		  --enable-kernel=3.2                \
		  --with-headers=/usr/include        \
		  --enable-multi-arch                \
		  --libdir=/usr/lib32                \
		  --libexecdir=/usr/lib32            \
		  libc_cv_slibdir=/usr/lib32

	make -j$(nproc)

	make DESTDIR=$PWD/DESTDIR install
	cp -a DESTDIR/usr/lib32/* $FAKEROOT_PREFIX/usr/lib32/
	install -vm644 DESTDIR/usr/include/gnu/{lib-names,stubs}-32.h \
				   $FAKEROOT_PREFIX/usr/include/gnu/

	# Add the library name to the dynamic loader config
	echo "/usr/lib32" >> /etc/ld.so.conf

	# Test compiling and linking. Quit if something goes wrong
	#echo 'int main(){}' > dummy.c
	#gcc -m32 dummy.c || exit 1
	#readelf -l a.out | grep '/ld-linux' || exit 1
	#rm -v dummy.c a.out

	# Build for x32bit
	rm -rf ./*
	find .. -name "*.a" -delete

	CC="gcc -mx32" CXX="g++ -mx32" \
	../configure                             \
		  --prefix=$FAKEROOT_PREFIX/usr      \
		  --host=x86_64-pc-linux-gnux32      \
		  --build=$(../scripts/config.guess) \
		  --enable-kernel=3.2                \
		  --with-headers=/usr/include        \
		  --enable-multi-arch                \
		  --libdir=/usr/libx32               \
		  --libexecdir=/usr/libx32           \
		  libc_cv_slibdir=/usr/libx32

	make -j$(nproc)

	make DESTDIR=$PWD/DESTDIR install
	cp -a DESTDIR/usr/libx32/* $FAKEROOT_PREFIX/usr/libx32/
	install -vm644 DESTDIR/usr/include/gnu/{lib-names,stubs}-x32.h \
					$FAKEROOT_PREFIX/usr/include/gnu/

	# Add the library name to the dynamic loader config
	echo "/usr/libx32" >> /etc/ld.so.conf

	# Make sure that the compiler still works and quit if something goes wrong
	#echo 'int main(){}' > dummy.c
	#gcc -mx32 dummy.c
	#readelf -l a.out | grep '/ld-linux-x32'
	#rm -v dummy.c a.out
}
