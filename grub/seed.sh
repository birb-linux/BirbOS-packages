NAME="grub"
DESC="GRand Unified Bootloader"
VERSION="2.06"
UNIFONT_VERSION="15.0.01"
SOURCE="https://ftp.gnu.org/gnu/grub/grub-${VERSION}.tar.xz"
CHECKSUM="cf0fd928b1e5479c8108ee52cb114363"
DEPS="efibootmgr freetype"
FLAGS=""

_setup()
{
	println "Downloading a required font"
	wget https://unifoundry.com/pub/unifont/unifont-${UNIFONT_VERSION}/font-builds/unifont-${UNIFONT_VERSION}.pcf.gz
	[ "$(md5sum ./unifont-${UNIFONT_VERSION}.pcf.gz | cut -d' ' -f1)" != "c371b9b4a8a51228c468cc7efccec098" ] && echo "md5 mismatch with unifont-${UNIFONT_VERSION}.pcf.gz" && exit 1
	
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Install unifont
	mkdir -pv $FAKEROOT/$NAME/usr/share/fonts/unifont &&
	gunzip -c ../unifont-${UNIFONT_VERSION}.pcf.gz > $FAKEROOT/$NAME/usr/share/fonts/unifont/unifont.pcf

	# Unset any env variables that might affect the build in some way
	unset {C,CPP,CXX,LD}FLAGS

	# Fix an issue causing grub-install to fail in some circumstances related to e2fsprogrs and the /boot partition
	patch -Np1 -i $PKG_PATH/grub-2.06-upstream_fixes-1.patch

	./configure --prefix=/usr    \
            --sysconfdir=/etc    \
            --disable-efiemu     \
            --enable-grub-mkfont \
            --with-platform=efi  \
            --target=x86_64      \
            --disable-werror
	unset TARGET_CC
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	mkdir -p $FAKEROOT/$NAME/usr/share/bash-completion/completions
	mv -v $FAKEROOT/$NAME/etc/bash_completion.d/grub $FAKEROOT/$NAME/usr/share/bash-completion/completions
}
