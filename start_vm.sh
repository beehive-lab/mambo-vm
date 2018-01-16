#!/bin/sh

qemu-system-aarch64 -m 512M -M virt -cpu cortex-a53 \
-kernel Image.gz -initrd initramfs-linux-fallback.img -append "root=/dev/sda rw" \
-device virtio-scsi-device,id=scsi -drive file=rootfs.img,if=none,format=raw,id=hd0 -device scsi-hd,drive=hd0 \
-netdev user,id=mynet,hostfwd=tcp:127.0.0.1:5040-:22 -device virtio-net-pci,netdev=mynet
