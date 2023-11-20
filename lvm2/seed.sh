NAME="lvm2"
DESC="Set of tools that manage logical partitions"
VERSION="2.03.22"
SOURCE="https://sourceware.org/ftp/lvm2/LVM2.${VERSION}.tgz"
CHECKSUM="a97cf533222a5760225dbd26c3982ca6"
DEPS="libaio"
FLAGS=""

_setup()
{
	kernel_check "CONFIG_BLK_DEV CONFIG_BLK_DEV_RAM CONFIG_MD CONFIG_BLK_DEV_DM CONFIG_DM_CRYPT CONFIG_DM_SNAPSHOT CONFIG_DM_THIN_PROVISIONING CONFIG_DM_CACHE CONFIG_DM_MIRROR CONFIG_DM_ZERO CONFIG_DM_DELAY"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd LVM2.${VERSION}
}

_build()
{
	PATH+=:/usr/sbin                \
	./configure --prefix=/usr       \
				--enable-cmdlib     \
				--enable-pkgconfig  \
				--enable-udev_sync

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# This udev rule requires systemd and thus shouldn't be here
	rm -fv $FAKEROOT/$NAME/usr/lib/udev/rules.d/69-dm-lvm.rules
}
