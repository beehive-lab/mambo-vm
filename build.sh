#!/bin/sh

# Create a new image and mount it
dd bs=1G seek=8 of=rootfs.img count=0
mkfs.ext4 rootfs.img
mkdir mnt
sudo mount -o loop rootfs.img ./mnt

# Extract the rootfs archive
cd mnt
sudo tar xpf ../ArchLinuxARM-aarch64-latest.tar.gz
cd ..

sudo mount -o bind /run/ mnt/run/
sudo mount -o bind /dev/ mnt/dev/
sudo mount -t proc none mnt/proc/
sudo chroot mnt/ /usr/bin/pacman -Syu gcc ruby git make --noconfirm
sudo chroot mnt/ /usr/bin/su alarm -c "cd /home/alarm && git clone https://github.com/beehive-lab/mambo.git && cd mambo && git submodule init && git submodule update"
sudo umount mnt/run/
sudo umount mnt/dev/
sudo umount mnt/proc/
sudo rm mnt/var/cache/pacman/pkg/*.tar.xz

# Extract the kernel and initrd images
cp mnt/boot/Image.gz .
cp mnt/boot/initramfs-linux-fallback.img .

sudo umount mnt
