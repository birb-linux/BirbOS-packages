NAME="shadow"
DESC="Programs for handling passwords in a secure way"
VERSION="4.13"
SOURCE="https://github.com/shadow-maint/shadow/releases/download/${VERSION}/shadow-${VERSION}.tar.xz"
CHECKSUM="b1ab01b5462ddcf43588374d57bec123"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Don't install the "groups" program and its man pages, because Coreutils has
	# a better version of these. This also prevents the installation of duplicate
	# man pages that the man-pages package already provides
	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
	find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
	find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

	# 1. Change the algorithm to SHA-512 and increase the iteration amount
	# 2. Change the mail location to /var/mail
	# 3. Remove bin and sbin from PATH
	sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD SHA512:' \
		-e 's@#\(SHA_CRYPT_..._ROUNDS 5000\)@\100@'       \
		-e 's:/var/spool/mail:/var/mail:'                 \
		-e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                \
		-i etc/login.defs

	touch /usr/bin/passwd
	./configure --sysconfdir=/etc \
				--disable-static  \
				--with-group-name-max-length=32

	make -j${MAKEOPTS}
}

_install()
{
	make exec_prefix=$FAKEROOT/$NAME/usr install
	make -C man install-man

	# Enable shadowed passwords
	pwconv

	# Enable shadowed group passwords
	grpconv
}
