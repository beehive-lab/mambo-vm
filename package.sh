#!/bin/sh
set -e

# Extract the kernel and initrd images
cp rootfs/boot/Image.gz .
cp rootfs/boot/initramfs-linux-fallback.img .

# create the disk image and copy the rootfs to it
rm -f rootfs.img
dd bs=1G seek=8 of=rootfs.img count=0
mkfs.ext4 rootfs.img
sudo mount -o loop rootfs.img mnt
sudo cp -Rp rootfs/* mnt
sudo umount mnt
tar -czvf mambo_vm.tar.gz Image.gz initramfs-linux-fallback.img rootfs.img readme.md start_vm.sh
