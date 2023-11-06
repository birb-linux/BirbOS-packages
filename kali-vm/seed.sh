NAME="kali-vm"
DESC="Kali Linux qcow2 disk image for qemu with a launch script"
VERSION="2023.3"
SOURCE="https://cdimage.kali.org/kali-${VERSION}/kali-linux-${VERSION}-qemu-amd64.7z"
CHECKSUM="50f80450086c64aff30e5a26331234bc"
DEPS="p7zip qemu bridge-utils"
FLAGS=""

_setup()
{
	printf ""
}

_build()
{
	printf ""
}

_install()
{
	# Create directories for the vm image
	VIRTUAL_MACHINE_DIR="/usr/share/virtual-machines"
	mkdir -p "${VIRTUAL_MACHINE_DIR:?}"

	mkdir -p "$FAKEROOT/$NAME/$VIRTUAL_MACHINE_DIR"

	# Extract the kali virtual machine image directly into its destination to avoid
	# unnecessary file I/O
	cd "$FAKEROOT/$NAME/$VIRTUAL_MACHINE_DIR" || exit
	7z x "$DISTFILES/$(basename $SOURCE)"

	# Create the startup script
	STARTUP_SCRIPT_PATH="$FAKEROOT/$NAME/usr/bin/kali-vm"
	cat >> "$STARTUP_SCRIPT_PATH" << EOF
	#!/bin/bash
qemu-system-x86_64 								\
	-enable-kvm 								\
	-cpu host 									\
	-m 4096 									\
	-net nic,netdev=net0,model=virtio-net-pci 	\
	-netdev bridge,id=net0 						\
	-smp cpus=4 								\
	-vga virtio 								\
	-drive file=$VIRTUAL_MACHINE_DIR/kali-linux-${VERSION}-qemu-amd64.qcow2,media=disk,if=virtio
EOF

	# Make the script executable
	chmod 755 "$STARTUP_SCRIPT_PATH"

	# Give everyone access to the vm file
	chmod 777 "$FAKEROOT/$NAME/$VIRTUAL_MACHINE_DIR/kali-linux-${VERSION}-qemu-amd64.qcow2"
}
