#!/bin/bash
# Script outline to install and build kernel.
# Author: Siddhant Jajoo.

set -e
set -u

OUTDIR=/tmp/aeld
KERNEL_REPO=git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
KERNEL_VERSION=v5.1.10
BUSYBOX_VERSION=1_33_1
FINDER_APP_DIR=$(realpath $(dirname $0))
ARCH=arm64
CROSS_COMPILE=aarch64-none-linux-gnu-

if [ $# -lt 1 ]
then
	echo "Using default directory ${OUTDIR} for output"
else
	OUTDIR=$1
	echo "Using passed directory ${OUTDIR} for output"
fi

mkdir -p ${OUTDIR}

cd "${OUTDIR}"
if [ ! -d "${OUTDIR}/linux-stable" ]; then
    #Clone only if the repository does not exist.
	echo "CLONING GIT LINUX STABLE VERSION ${KERNEL_VERSION} IN ${OUTDIR}"
	git clone ${KERNEL_REPO} --depth 1 --single-branch --branch ${KERNEL_VERSION}
fi
if [ ! -e ${OUTDIR}/linux-stable/arch/${ARCH}/boot/Image ]; then
    cd linux-stable
    echo "Checking out version ${KERNEL_VERSION}"
    git checkout ${KERNEL_VERSION}

    # TODO: Add your kernel build steps here
    echo "Kernel build steps"
    make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} mrproper
    echo "Deep clean kernel build tree"
    make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} defconfig
    echo "Configure for our virt arm dev board"
    make -j4 ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} all
    echo "Build kernel image for booting"
    make -j4 ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} modules
    echo "Build any kernel modules"
    make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} dtbs
    echo "Build the device tree"
fi 

echo "Adding the Image in outdir"
cp ${OUTDIR}/linux-stable/arch/${ARCH}/boot/Image ${OUTDIR}/

echo "Creating the staging directory for the root filesystem"
cd "${OUTDIR}"
if [ -d "${OUTDIR}/rootfs" ]
then
	echo "Deleting rootfs directory at ${OUTDIR}/rootfs and starting over"
    sudo rm  -rf ${OUTDIR}/rootfs
fi

# TODO: Create necessary base directories
mkdir ${OUTDIR}/rootfs
cd ${OUTDIR}/rootfs
mkdir -p bin dev etc home lib lib64 proc sbin sys tmp usr var
mkdir -p usr/bin usr/lib usr/sbin
mkdir -p var/log
echo "Base directories set"

cd "${OUTDIR}"
if [ ! -d "${OUTDIR}/busybox" ]
then
git clone git://busybox.net/busybox.git
    cd busybox
    git checkout ${BUSYBOX_VERSION}
    # TODO:  Configure busybox
    make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} distclean
    make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} defconfig

else
    cd busybox
fi

# TODO: Make and insatll busybox
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE}
make CONFIG_PREFIX=${OUTDIR}/rootfs ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} install
echo "Busybox installed"

echo "Library dependencies"
${CROSS_COMPILE}readelf -a ${OUTDIR}/rootfs/bin/busybox | grep "program interpreter"
${CROSS_COMPILE}readelf -a ${OUTDIR}/rootfs/bin/busybox | grep "Shared library"

# TODO: Add library dependencies to rootfs
export SYSROOT=$(${CROSS_COMPILE}gcc -print-sysroot)
cd ${OUTDIR}/rootfs
cp -L $SYSROOT/lib/ld-linux-aarch64.* lib
cp -L $SYSROOT/lib64/libm.so.* lib64
cp -L $SYSROOT/lib64/libc.so.* lib64
cp -L $SYSROOT/lib64/libresolv.so.* lib64
echo "Add library dependencies"

# TODO: Make device nodes
cd ${OUTDIR}/rootfs
sudo mknod -m 666 dev/null c 1 3
sudo mknod -m 600 dev/console c 5 1
echo "Make device nodes"

# TODO: Clean and build the writer utility
cd ${FINDER_APP_DIR}
make clean
make CROSS_COMPILE=${CROSS_COMPILE}
echo "Build writer utility"

# TODO: Copy the finder related scripts and executables to the /home directory
# on the target rootfs
cp ./conf/ -r ${OUTDIR}/rootfs/home
cp ./finder-test.sh ${OUTDIR}/rootfs/home
cp ./finder.sh ${OUTDIR}/rootfs/home
cp ./writer ${OUTDIR}/rootfs/home
cp ./autorun-qemu.sh ${OUTDIR}/rootfs/home

echo "Copy finder scripts to /rootfs/home"

# TODO: Chown the root directory
cd ${OUTDIR}/rootfs
sudo chown -R root:root *
echo "Change root directory"

# TODO: Create initramfs.cpio.gz
cd ${OUTDIR}/rootfs
find . | cpio -H newc -ov --owner root:root > ${OUTDIR}/initramfs.cpio
cd ..
gzip -f initramfs.cpio
echo "Create initramfs"
