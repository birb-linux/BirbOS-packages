NAME="lm-sensors"
DESC="Userspace support for the hardware monitoring drivers in the Linux kernel"
VERSION="3-6-0"
SOURCE="https://github.com/lm-sensors/lm-sensors/archive/V${VERSION}/lm-sensors-${VERSION}.tar.gz"
CHECKSUM="f60e47b5eb50bbeed48a9f43bb08dd5e"
DEPS="which"
FLAGS=""

_setup()
{
	kernel_check "CONFIG_MODULES CONFIG_PCI CONFIG_I2C_CHARDEV CONFIG_HWMON"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make PREFIX=/usr        	\
		BUILD_STATIC_LIB=0 		\
     	MANDIR=/usr/share/man 	\
		-j${BUILD_JOBS}
}

_install()
{
	make PREFIX=/usr        	\
		DESTDIR=$FAKEROOT/$NAME \
		BUILD_STATIC_LIB=0 		\
     	MANDIR=/usr/share/man install

	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/lm_sensors-${VERSION}
	cp -rv              README INSTALL doc/* \
						$FAKEROOT/$NAME/usr/share/doc/lm_sensors-${VERSION}
}
